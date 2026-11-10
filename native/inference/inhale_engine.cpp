// InhaleSkill AI — Native inference engine (llama.cpp wrapper).
// Build with CMake. See native/CMakeLists.txt.
//
// Exports:
//   inhale_init() -> int  (0 = ok)
//   inhale_load_model(path, ctx, threads, gpu) -> int (0 = ok)
//   inhale_generate(prompt, max_tokens, temp, top_p, top_k, ...) -> int
//   inhale_unload_model()
//   inhale_shutdown()
//   inhale_get_memory_mb() -> int
//   inhale_is_loaded() -> int
//   inhale_set_context(ctx)
//   inhale_get_context() -> int
//   inhale_cancel()

#include <cstdint>
#include <cstring>
#include <string>
#include <vector>
#include <atomic>
#include <memory>

#include "llama.h"

#ifdef _WIN32
  #define EXPORT __declspec(dllexport)
#else
  #define EXPORT __attribute__((visibility("default")))
#endif

struct InhaleEngine {
    llama_model* model = nullptr;
    llama_context* ctx = nullptr;
    llama_sampler* sampler = nullptr;
    const llama_vocab* vocab = nullptr;
    bool loaded = false;
    std::string modelPath;
    int contextLength = 2048;
    int cpuThreads = 4;
    bool useGpu = false;
    int memoryMb = 0;
    std::atomic<bool> cancelled{false};
};

static InhaleEngine g_engine;

// Forward declarations
static void common_log_callback(ggml_log_level level, const char* text, void* user_data);
static void inhale_unload_model_impl();

static void common_log_callback(ggml_log_level level, const char* text, void* user_data) {
    (void)level; (void)text; (void)user_data;
}

static void inhale_unload_model_impl() {
    if (g_engine.sampler) {
        llama_sampler_free(g_engine.sampler);
        g_engine.sampler = nullptr;
    }
    if (g_engine.ctx) {
        llama_free(g_engine.ctx);
        g_engine.ctx = nullptr;
    }
    if (g_engine.model) {
        llama_model_free(g_engine.model);
        g_engine.model = nullptr;
    }
    g_engine.vocab = nullptr;
    g_engine.loaded = false;
    g_engine.modelPath.clear();
    g_engine.memoryMb = 0;
    g_engine.cancelled = false;
}

extern "C" {

EXPORT int inhale_init() {
    llama_log_set(common_log_callback, nullptr);
    llama_backend_init();
    return 0;
}

EXPORT int inhale_load_model(const char* path, int ctx, int threads, int gpu) {
    if (!path) return -1;
    
    if (g_engine.loaded) {
        inhale_unload_model_impl();
    }
    
    g_engine.modelPath = path;
    g_engine.contextLength = ctx > 0 ? ctx : 2048;
    g_engine.cpuThreads = threads > 0 ? threads : 4;
    g_engine.useGpu = gpu != 0;
    g_engine.cancelled = false;

    llama_model_params model_params = llama_model_default_params();
    model_params.n_gpu_layers = g_engine.useGpu ? -1 : 0;
    
    g_engine.model = llama_model_load_from_file(g_engine.modelPath.c_str(), model_params);
    if (!g_engine.model) {
        g_engine.loaded = false;
        return -2;
    }

    g_engine.vocab = llama_model_get_vocab(g_engine.model);

    llama_context_params ctx_params = llama_context_default_params();
    ctx_params.n_ctx = g_engine.contextLength;
    ctx_params.n_threads = g_engine.cpuThreads;
    ctx_params.n_threads_batch = g_engine.cpuThreads;
    ctx_params.offload_kqv = g_engine.useGpu;
    
    g_engine.ctx = llama_init_from_model(g_engine.model, ctx_params);
    if (!g_engine.ctx) {
        llama_model_free(g_engine.model);
        g_engine.model = nullptr;
        g_engine.vocab = nullptr;
        g_engine.loaded = false;
        return -3;
    }

    llama_sampler_chain_params sampler_params = llama_sampler_chain_default_params();
    g_engine.sampler = llama_sampler_chain_init(sampler_params);
    llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_top_k(40));
    llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_top_p(0.9f, 1));
    llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_temp(0.7f));
    llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_dist(LLAMA_DEFAULT_SEED));

    g_engine.loaded = true;
    g_engine.memoryMb = (int)(llama_model_size(g_engine.model) / (1024 * 1024)) + 100;
    
    return 0;
}

EXPORT void inhale_unload_model() {
    inhale_unload_model_impl();
}

EXPORT int inhale_is_loaded() {
    return g_engine.loaded ? 1 : 0;
}

EXPORT int inhale_get_memory_mb() {
    return g_engine.memoryMb;
}

EXPORT void inhale_set_context(int ctx) {
    g_engine.contextLength = ctx > 0 ? ctx : 2048;
}

EXPORT int inhale_get_context() {
    return g_engine.contextLength;
}

EXPORT void inhale_cancel() {
    g_engine.cancelled = true;
}

using TokenCallback = void(*)(const char*);
using DoneCallback = void(*)();
using ErrorCallback = void(*)(const char*);

EXPORT int inhale_generate(
    const char* prompt,
    int max_tokens,
    float temp,
    float top_p,
    int top_k,
    void (*token_cb)(const char*),
    void (*done_cb)(),
    void (*err_cb)(const char*),
    int cancel_token)
{
    (void)cancel_token;
    
    if (!g_engine.loaded || !g_engine.ctx || !g_engine.sampler || !g_engine.vocab) {
        if (err_cb) err_cb("No model loaded");
        return -1;
    }
    if (g_engine.cancelled) {
        if (err_cb) err_cb("Cancelled");
        return -2;
    }
    
    if (!prompt) {
        if (err_cb) err_cb("Empty prompt");
        return -3;
    }

    // Tokenize prompt
    std::vector<llama_token> tokens(llama_n_ctx(g_engine.ctx));
    int n_tokens = llama_tokenize(g_engine.vocab, prompt, strlen(prompt), tokens.data(), (int)tokens.size(), true, true);
    if (n_tokens < 0) {
        tokens.resize(-n_tokens);
        n_tokens = llama_tokenize(g_engine.vocab, prompt, strlen(prompt), tokens.data(), (int)tokens.size(), true, true);
        if (n_tokens < 0) {
            if (err_cb) err_cb("Tokenization failed");
            return -4;
        }
    }
    tokens.resize(n_tokens);

    int n_ctx = llama_n_ctx(g_engine.ctx);
    if (n_tokens > n_ctx - 4) {
        if (err_cb) err_cb("Prompt too long for context");
        return -5;
    }

    // Update sampler params
    // Clear and rebuild sampler chain with new params
    llama_sampler_free(g_engine.sampler);
    llama_sampler_chain_params sampler_params = llama_sampler_chain_default_params();
    g_engine.sampler = llama_sampler_chain_init(sampler_params);
    if (top_k > 0) llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_top_k(top_k));
    if (top_p > 0.0f) llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_top_p(top_p, 1));
    if (temp >= 0.0f) llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_temp(temp));
    llama_sampler_chain_add(g_engine.sampler, llama_sampler_init_dist(LLAMA_DEFAULT_SEED));

    // Process prompt
    llama_batch batch = llama_batch_get_one(tokens.data(), tokens.size());
    
    if (llama_decode(g_engine.ctx, batch) != 0) {
        if (err_cb) err_cb("Prompt processing failed");
        return -6;
    }

    // Generate tokens
    int n_generated = 0;
    int n_past = n_tokens;
    std::string token_str;
    token_str.reserve(256);
    
    while (n_generated < max_tokens && !g_engine.cancelled) {
        llama_token id = llama_sampler_sample(g_engine.sampler, g_engine.ctx, -1);
        
        if (llama_vocab_is_eog(g_engine.vocab, id)) {
            break;
        }
        
        char buf[128];
        int n = llama_token_to_piece(g_engine.vocab, id, buf, sizeof(buf), 0, true);
        if (n > 0) {
            token_str.assign(buf, n);
            if (token_cb) {
                token_cb(token_str.c_str());
            }
        }
        
        // Prepare next batch
        llama_batch batch_next = llama_batch_get_one(&id, 1);
        batch_next.pos[0] = n_past;
        n_past++;
        
        if (llama_decode(g_engine.ctx, batch_next) != 0) {
            if (err_cb) err_cb("Decoding failed");
            return -7;
        }
        
        n_generated++;
    }
    
    if (g_engine.cancelled) {
        g_engine.cancelled = false;
        if (err_cb) err_cb("Cancelled");
        return -2;
    }
    
    if (done_cb) {
        done_cb();
    }
    return 0;
}

EXPORT void inhale_shutdown() {
    inhale_unload_model();
    llama_backend_free();
}

}  // extern "C"