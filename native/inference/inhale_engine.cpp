// InhaleSkill AI — Native inference engine (llama.cpp wrapper).
// Build with CMake. See native/CMakeLists.txt.
//
// Exports:
//   inhale_init() -> int  (0 = ok)
//   inhale_load_model(path, ctx, threads, gpu) -> int (0 = ok)
//   inhale_generate(prompt, max_tokens, temp, top_p, top_k,
//                   token_cb, done_cb, err_cb, cancel) -> int
//   inhale_unload_model()
//   inhale_shutdown()
//   inhale_get_memory_mb() -> int
//
// Token callbacks are invoked from native threads; the Dart side
// marshals them onto the UI isolate via a registered callback.

#include <cstdint>
#include <cstring>
#include <string>
#include <vector>
#include <atomic>

#ifdef _WIN32
  #define EXPORT __declspec(dllexport)
#else
  #define EXPORT __attribute__((visibility("default")))
#endif

// Minimal stub engine interface. The full llama.cpp integration
// is wired through native/CMakeLists.txt and the llama.cpp submodule.
// This file compiles standalone and provides graceful fallbacks.

struct InhaleEngine {
    bool loaded = false;
    std::string modelPath;
    int contextLength = 2048;
    int cpuThreads = 4;
    bool useGpu = false;
    int memoryMb = 0;
    std::atomic<bool> cancelled{false};
};

static InhaleEngine g_engine;

extern "C" {

EXPORT int inhale_init() {
    return 0;
}

EXPORT int inhale_load_model(const char* path, int ctx, int threads, int gpu) {
    if (!path) return -1;
    g_engine.modelPath = path;
    g_engine.contextLength = ctx > 0 ? ctx : 2048;
    g_engine.cpuThreads = threads > 0 ? threads : 4;
    g_engine.useGpu = gpu != 0;
    g_engine.loaded = true;
    g_engine.cancelled = false;
    // Memory estimate: placeholder. Real implementation queries llama.
    g_engine.memoryMb = std::max(500, ctx / 2);
    return 0;
}

EXPORT void inhale_unload_model() {
    g_engine.loaded = false;
    g_engine.modelPath.clear();
    g_engine.memoryMb = 0;
    g_engine.cancelled = false;
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
    if (!g_engine.loaded) {
        if (err_cb) err_cb("No model loaded");
        return -1;
    }
    if (g_engine.cancelled) {
        if (err_cb) err_cb("Cancelled");
        return -2;
    }
    // Real implementation streams tokens via llama.cpp.
    // Stub: emit a placeholder token so the Dart layer can test plumbing.
    if (token_cb) token_cb("[engine:stub]");
    if (done_cb) done_cb();
    return 0;
}

EXPORT void inhale_shutdown() {
    inhale_unload_model();
}

}  // extern "C"