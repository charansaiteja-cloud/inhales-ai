# Performance Benchmarks — InhaleSkill AI

**Date:** 2026-11-12
**Status:** ✅ Phase 1 Complete - Ready for physical device testing
**Target devices:** Android 12+ (arm64-v8a recommended)

---

## Completed Phase 1 Features

### RAG Pipeline
- ✅ PDF extraction (Syncfusion `PdfTextExtractor`)
- ✅ Page-aware chunking with citations
- ✅ Hybrid retrieval (vector 0.7 + keyword 0.3)
- ✅ Multi-document search & bulk operations
- ✅ Extractive summarization (no AI engine)
- ✅ Unsupported-answer detection (threshold: 0.15)

### Test Coverage
- ✅ 59/59 tests passing
- ✅ `flutter analyze`: 0 issues
- ✅ `dart format`: Clean

---

## Benchmark Targets (Pending Physical Device)

### 1. RAG Pipeline Latency

| Operation | Target (p95) | Status |
|-----------|--------------|--------|
| PDF extraction (10 pages) | < 800ms | ⏳ Pending |
| Chunking + embedding (10 pages) | < 1.2s | ⏳ Pending |
| Hybrid search (top-10) | < 150ms | ⏳ Pending |
| Extractive summary | < 100ms | ⏳ Pending |
| Multi-doc search (3 docs) | < 300ms | ⏳ Pending |

### 2. On-Device Inference (llama.cpp FFI)

*Requires GGUF model loaded via `ModelManager`*

| Model | Quantization | TTFT Target | Tokens/sec Target |
|-------|--------------|-------------|-------------------|
| Llama-3.2-1B | Q4_K_M | < 1.5s | > 15 tok/s |
| Llama-3.2-3B | Q4_K_M | < 2.5s | > 10 tok/s |
| Phi-3-mini | Q4_K_M | < 1.2s | > 20 tok/s |

### 3. Memory Management

| Scenario | Target | Status |
|----------|--------|--------|
| Memory pressure unload | < 500ms | ⏳ Pending |
| Model reload time | < 2s | ⏳ Pending |
| Peak RAM (1B model) | < 1.5GB | ⏳ Pending |

### 4. App Performance

| Metric | Cold Start | Warm Start |
|--------|------------|------------|
| Time to interactive | < 2.5s | < 1.0s |
| Initial memory | < 200MB | < 150MB |
| Frame build (dashboard) | < 16ms | < 16ms |

---

## Testing Methodology

### Device Requirements
- Android 12 or higher
- arm64-v8a ABI (recommended: Pixel 6+, Samsung S22+, or equivalent)
- Minimum 6GB RAM for 1B+ model testing
- Storage: 2GB+ free for model files

### Benchmark Commands (To Be Implemented)

```bash
# Run all benchmarks
cd app
dart run benchmark/rag_benchmark.dart
dart run benchmark/inference_benchmark.dart

# Memory profiling
flutter run --profile
# Then use DevTools Memory tab

# Trace RAG pipeline
flutter run --profile --trace-startup
```

### Metrics Collection
- Use `dart:developer` Timeline for custom spans
- `ProcessInfo` for RSS/PSS memory
- Systrace/Perfetto for system-level profiling
- Flutter DevTools for CPU/memory profiling

---

## Known Constraints

1. **Embeddings**: Currently hash-based (deterministic, 384-dim). Real semantic embeddings require on-device model integration.

2. **Syncfusion PDF**: Trial watermark in debug/release builds without license key.

3. **Native Library**: `libinhale_engine.so` bundled for arm64-v8a, armeabi-v7a, x86_64. Performance varies by device CPU/GPU.

4. **Thermal Throttling**: Sustained token generation affected by thermal limits after 5+ minutes.

---

## Next Steps

1. **Physical device testing** — Deploy to Android device, run benchmarks
2. **Fill actual results** — Update this doc with real numbers
3. **Optimization** — Profile bottlenecks, optimize hot paths
4. **CI integration** — Add automated benchmark runs (requires device farm)

---

## References

- `docs/IMPLEMENTATION_REPORT.md` — Full implementation details
- `docs/TEST_REPORT.md` — Test suite results
- `docs/RAG_EVALUATION.md` — RAG quality assessment
- `lib/ai/rag/rag_service.dart` — RAG pipeline implementation
- `lib/ai/engine/ffi_inference_engine.dart` — Native inference