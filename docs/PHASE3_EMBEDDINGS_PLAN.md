# Phase 3: On-Device Embeddings Integration Plan

## Overview
Integrate BGE-small-en-v1.5 GGUF embedding model for semantic vector search, replacing hash-based embeddings.

## Tasks

### 1. Native Engine Modifications (`inhale_engine.cpp`)
- [ ] Add `inhale_generate_embedding()` function
- [ ] Load embedding model with `llama_model_default_params()` 
- [ ] Use `llama_tokenize()` for input text
- [ ] Call `llama_decode()` with batch
- [ ] Extract embeddings via `llama_get_embeddings()` or `llama_get_embeddings_ith()`
- [ ] Return embedding vector to Dart via callback
- [ ] Add `inhale_get_embedding_dim()` to query model dimension

### 2. FFI Bindings (`ffi_bindings.dart`)
- [ ] Add `InhaleGenerateEmbedding` typedef
- [ ] Add `InhaleGetEmbeddingDim` typedef  
- [ ] Register function lookups in `InhaleFFI` class

### 3. FFI Inference Engine (`ffi_inference_engine.dart`)
- [ ] Add `generateEmbedding(String text)` method
- [ ] Add `getEmbeddingDim()` method
- [ ] Handle embedding callback bridge

### 4. AI Engine Interface (`ai_engine.dart`)
- [ ] Add `generateEmbedding(String text)` to `AIEngine` interface
- [ ] Implement in `FfiAIEngine`

### 5. Model Manager (`model_manager.dart`)
- [ ] Add BGE-small-en-v1.5 to catalog
- [ ] Add embedding model download support
- [ ] Track embedding model separately from LLM

### 6. RAG Service (`rag_service.dart`)
- [ ] Replace `_hashEmbedding()` with real semantic embeddings
- [ ] Call `AIEngine.generateEmbedding()` for chunk embedding
- [ ] Update dimension handling (384 for BGE-small)

### 7. Database Schema
- [ ] Verify vector table supports variable dimensions
- [ ] No migration needed (already List<double>)

## BGE-small-en-v1.5 GGUF
- **URL**: https://huggingface.co/BAAI/bge-small-en-v1.5-gguf
- **File**: `bge-small-en-v1.5-q4_k_m.gguf` (~130MB)
- **Dimension**: 384
- **Context**: 512 tokens
- **Pooling**: CLS token (default)

## Testing
- [ ] Unit test: embedding generation
- [ ] Integration test: RAG retrieval with semantic search
- [ ] Performance: embedding latency <100ms per chunk

## Success Criteria
- Semantic search returns relevant results by meaning, not keyword match
- Embeddings are deterministic (same text = same vector)
- No breaking changes to existing API
