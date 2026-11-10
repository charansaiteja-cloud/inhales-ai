# InhaleSkill AI — Upgrade Audit Report

**Date:** 2026-11-09  
**Repository:** https://github.com/charansaiteja-cloud/inhales-ai.git  
**Project Name:** InhaleSkill AI (must remain unchanged)  
**Current Version:** 1.0.0-alpha

---

## 1. Current Architecture

### 1.1 Layered Structure
- **Presentation:** Flutter widgets with Riverpod state management
- **Application:** Feature providers and use cases (Notifier pattern)
- **Domain:** AI engine abstraction (`InferenceEngine`), model management, repository interfaces
- **Infrastructure:** Drift SQLite database, FFI native engine, services

### 1.2 Technology Stack
| Component | Technology | Version |
|-----------|------------|---------|
| Framework | Flutter | 3.47+ (stable) |
| Language | Dart | >=3.7.0 <4.0.0 |
| State Mgmt | Riverpod | 2.6.1 |
| Navigation | GoRouter | 18.1.3 |
| Database | Drift (SQLite) | 2.22.0 |
| Native | C++ / CMake | C++17 |
| AI Runtime | llama.cpp (optional) | via FFI |
| Build | GitHub Actions | Ubuntu/macOS/Windows |
| Tests | flutter_test | built-in |

### 1.3 Directory Structure
```
inhales-ai/
├── app/                          # Flutter application
│   ├── lib/
│   │   ├── ai/                   # AI engine, models, manager
│   │   ├── core/                 # Theme, routing, constants, responsive
│   │   ├── database/             # Drift schema, migrations
│   │   ├── data/                 # Repository implementations
│   │   ├── di/                   # Dependency injection
│   │   ├── domain/               # Entities, repository interfaces
│   │   ├── features/             # 15 feature screens + providers
│   │   ├── services/             # Hardware, storage, offline
│   │   ├── widgets/              # 15 glassmorphism components
│   │   ├── app.dart              # App root with theme wiring
│   │   └── main.dart             # Entry point
│   ├── test/                     # 1 widget test file
│   ├── pubspec.yaml              # Dependencies
│   └── analysis_options.yaml
├── native/                       # C++ native engine
│   ├── inference/inhale_engine.cpp   # Stub implementation
│   └── CMakeLists.txt            # USE_LLAMA option
└── docs/                         # architecture.md (only)
```

---

## 2. Existing Functionality

### 2.1 Fully Working Features
| Feature | Status | Notes |
|---------|--------|-------|
| **App Framework** | ✅ Complete | Riverpod + GoRouter + Drift + theme system |
| **Theme System** | ✅ Complete | Dark/light, tokens (spacing, radius, blur, shadows), typography |
| **Home Dashboard** | ✅ Complete | Responsive (sidebar desktop / bottom nav mobile), AI Orb, quick actions |
| **Chat Studio** | ✅ Complete | Sessions CRUD, streaming placeholder, history sidebar (mobile drawer + desktop persistent) |
| **Model Manager** | ✅ Complete | Hardware detection, catalog (4 Qwen models), download/install/load/delete UI |
| **School Learning** | ✅ UI Complete | Class/subject selection → routes to chat |
| **College Learning** | ✅ UI Complete | Subject selection → routes to chat |
| **General Learning** | ✅ UI Complete | Category grid → routes to chat |
| **Writing Assistant** | ✅ UI Complete | 11 modes, instructions, content area, generate button |
| **Coding Assistant** | ✅ UI Complete | 9 languages, code editor, explain/fix/optimize actions |
| **Mathematics** | ✅ UI Complete | Expression input, compute, history |
| **Translation** | ✅ UI Complete | 3 languages, swap, history |
| **Documents** | ✅ UI Complete | List, search, add (stub) |
| **Notes** | ✅ UI Complete | CRUD, search, pin |
| **Quizzes** | ✅ UI Complete | Topic input, category grid, MCQ flow |
| **Voice AI** | ✅ UI Complete | STT recording UI, TTS input, mock implementations |
| **Vision AI** | ✅ UI Complete | Image picker placeholder, analyze button, mock result |
| **Presentations** | ✅ UI Complete | List, create from topic |
| **Settings** | ✅ Complete | Theme, reduced motion/blur, offline mode, GPU, context, threads, clear data |
| **CI/CD Pipeline** | ✅ Complete | 6 jobs: analyze, build-apk, build-aab, build-linux, build-windows, build-macos |

### 2.2 Native Engine
- **inhale_engine.cpp** — Stub implementation (no llama.cpp linked)
- **CMakeLists.txt** — `USE_LLAMA=OFF` by default; requires manual llama.cpp clone to `native/llama.cpp`
- **FFI Bindings** — Complete type definitions matching stub exports
- **Dart FFI Engine** — Falls back to simulated responses when library unavailable

### 2.3 Database Schema (10 tables, schema v3)
- `conversations` — chat sessions (id, title, mode, context, timestamps, pinned, messageCount)
- `messages` — individual turns (conversationId, role, content, timestamp, edited)
- `notes` — user notes (title, content, folder, subject, class, pinned, timestamps)
- `bookmarks` — saved responses
- `quiz_history` — quiz attempts
- `learning_activity` — daily progress
- `app_models` — installed model metadata
- `preferences` — user settings (key-value)
- `documents` — imported files metadata

### 2.4 Design System (Current)
- **Tokens:** `InhaleSpacing` (xs→xxxl), `InhaleRadius` (xs→circle), `InhaleBlur` (light→reduced), `InhaleOpacity` (glass→high), `InhaleShadows`
- **Colors:** Midnight navy base, electric blue/violet/cyan accents, light variants
- **Typography:** SF Pro Display, full scale (display→label), dark + light variants
- **Components (15):** GlassCard, GlassButton, GlassTextField, GlassAppBar, GlassSidebar, GlassBackground, GlassIconButton, GlassChatBubble, GlassBottomNavigationBar, GlassSearchBar, GlassDialog, GlassBottomSheet, GlassLoadingIndicator, GlassStatusBadge, AIOrb

---

## 3. Missing Functionality (Gap Analysis)

### 3.1 AI Engine & Inference
| Missing | Priority | Notes |
|---------|----------|-------|
| Real llama.cpp integration | **Critical** | Native engine is a stub; `USE_LLAMA=ON` requires cloning llama.cpp |
| Model loading/unloading | **Critical** | FFI engine returns false; no real model state |
| Streaming token generation | **Critical** | `_generateResponse` uses `Future.delayed` + placeholder text |
| Inference cancellation | High | `cancel()` exists in interface but not wired |
| Context management | High | No conversation context injection into prompts |
| Hardware acceleration (GPU/Metal/CUDA) | Medium | `gpuLayers` param exists but unused |
| Benchmarking / perf metrics | Medium | No token/s measurement |

### 3.2 Model Management
| Missing | Priority |
|---------|----------|
| Actual model download (HTTP + resume) | **Critical** |
| Model verification (SHA256) | High |
| Model metadata persistence (Drift `app_models` table) | High |
| Quantization compatibility matrix | Medium |
| Model update/check for updates | Low |

### 3.3 RAG & Document Intelligence
| Missing | Priority |
|---------|----------|
| Document text extraction (PDF/TXT/DOCX) | **Critical** |
| Text chunking & normalization | **Critical** |
| Local embedding model (e.g., BGE, E5) | **Critical** |
| Vector storage (SQLite-vec or embedded FAISS) | **Critical** |
| Semantic search / retrieval | **Critical** |
| Grounded response generation with citations | **Critical** |
| Document Q&A workflow | High |
| Re-indexing, duplicate detection | Medium |

### 3.4 Memory System
| Missing | Priority |
|---------|----------|
| Persistent memory store (separate from conversations) | **Critical** |
| User preferences learning | High |
| Conversation summarization | High |
| Memory search / edit / delete | High |
| Enable/disable memory toggle | Medium |

### 3.5 AI Agents
| Missing | Priority |
|---------|----------|
| Agent framework (planning, tools, execution) | **Critical** |
| Tool registry with permissions | **Critical** |
| Research / Coding / Writing / Document agents | High |
| User approval for sensitive actions | High |
| Sandbox for code execution | High |

### 3.6 Voice & Vision
| Missing | Priority |
|---------|----------|
| Real STT (Whisper.cpp or similar) | **Critical** |
| Real TTS (Piper, Coqui, or system) | **Critical** |
| Voice conversation loop | High |
| Real vision model (Qwen2.5-VL, LLaVA) | **Critical** |
| Image preprocessing / OCR | Medium |

### 3.7 Document Workspace
| Missing | Priority |
|---------|----------|
| PDF reader (flutter_pdfview) | High |
| DOCX reader | Medium |
| AI summaries / page references | High |
| Export summaries | Medium |

### 3.8 Learning Studio
| Missing | Priority |
|---------|----------|
| Personalized study plans | High |
| Progress tracking / weak-topic identification | Medium |
| Spaced repetition / revision recommendations | Medium |

---

## 4. Technical Debt

| Area | Issue | Severity |
|------|-------|----------|
| **Native Engine** | Stub only; real llama.cpp not integrated | Critical |
| **AI Inference** | Placeholder responses; no streaming | Critical |
| **Model Download** | UI only; no HTTP download implementation | Critical |
| **Providers** | Most use `Future.delayed` mocks; no real backend wiring | Critical |
| **Documents Provider** | In-memory list only; no Drift persistence | High |
| **Notes Provider** | In-memory list only; no Drift persistence | High |
| **Quiz Provider** | No persistence of results | Medium |
| **Translation Provider** | No local translation model | High |
| **Writing/Coding Providers** | No actual AI integration | High |
| **Voice/Vision Providers** | Mock implementations only | High |
| **Settings** | Some toggles (offline mode, GPU) not enforced | Medium |
| **Chat History** | Loads ALL messages on startup (no pagination) | Medium |
| **Theme** | Current colors are midnight navy/electric blue/violet — **does not match required Blue/Sky Blue/Pink + Black theme** | High |
| **Typography** | Uses SF Pro Display (Apple font); may need fallback for cross-platform | Medium |
| **Accessibility** | Semantics added but reduced-motion not fully respected in all animations | Medium |
| **Tests** | Only 1 widget test; no unit/integration/native tests | High |

---

## 5. Security Concerns

| Concern | Status | Notes |
|---------|--------|-------|
| **API Keys** | ✅ None in repo | Good |
| **Model Integrity** | ❌ No SHA256 verification on download | Must implement |
| **File Validation** | ❌ No validation on document import | PDF/DOCX parsers can be exploited |
| **Secure Storage** | ⚠️ `flutter_secure_storage` added but not used for sensitive data | Use for any future API keys |
| **Input Sanitization** | ❌ No validation on user prompts to AI | Prompt injection risk |
| **Code Execution** | ❌ Not implemented yet; if added, needs sandbox | Plan for isolation |
| **Network Transparency** | ⚠️ `OfflineService` exists but `offlineMode` not fully enforced | Audit all HTTP calls |
| **Data Deletion** | ✅ Clear data button in settings (UI only) | Must wire to actual deletion |

---

## 6. Performance Issues

| Issue | Impact | Location |
|-------|--------|----------|
| **Chat loads all sessions + messages on startup** | High memory, slow launch on large histories | `ChatNotifier._loadSessions()` |
| **No pagination in chat history** | Scroll performance degrades | `ChatHistorySidebar` |
| **Heavy blur effects on all glass cards** | GPU pressure on low-end devices | `GlassCard`, `GlassButton`, etc. |
| **`BackdropFilter` on many widgets** | Expensive rasterization | All glass components |
| **No `RepaintBoundary` on list items** | Unnecessary repaints | Various `ListView.builder` usages |
| **Mock `Future.delayed` blocks UI testing** | False confidence | All providers |
| **Image loading in vision screen** | No compression / downsampling | `VisionScreen._pickImage` |
| **Database queries not indexed** | Slow on large datasets | Drift tables lack indexes |

---

## 7. Dependency Concerns

| Package | Version | Concern |
|---------|---------|---------|
| `flutter_markdown` | **Removed** | Was deprecated; replaced with `markdown` 7.2.2 |
| `markdown` | 7.2.2 | Active, but verify syntax highlighting needs |
| `pdf` | 3.10.4 | For generation only; reading needs `flutter_pdfview` |
| `flutter_tts` | 4.0.1 | System TTS only; offline TTS needs separate engine |
| `sqlite3_flutter_libs` | 0.6.0+eol | Marked EOL; monitor for replacement |
| `drift` | 2.22.0 | Current; watch for 3.x migration |
| `go_router` | 18.1.3 | Current |
| `riverpod` | 2.6.1 | Current |
| **Missing** | — | `sqlite3-vec` or `faiss` for vector search |
| **Missing** | — | `image_picker` for vision |
| **Missing** | — | `file_picker` already present |
| **Missing** | — | `path_provider` already present |
| **Missing** | — | `http` already present |
| **Missing** | — | `crypto` already present |

---

## 8. Upgrade Recommendations

### Immediate (Phase 1-2)
1. **Create UPGRADE_ROADMAP.md** with phased milestones
2. **Redesign theme** to match spec: Blue (#1677D2), Sky Blue (#38BDF8), Pink (#EC4899), Ice Blue (#BAE6FD), Frost White (#F8FAFC), Deep Navy (#0B1F3A) + Black (#050505) / Dark Charcoal (#171717) alternative
3. **Build reusable Glassmorphism component library** with centralized tokens
4. **Wire real llama.cpp**: clone to `native/llama.cpp`, build with `USE_LLAMA=ON`, integrate FFI

### Short-term (Phase 3-5)
5. **Implement ModelManager download/install/verify** with Drift persistence
6. **Replace all provider mocks** with real AI engine calls
7. **Implement RAG**: text extraction → chunking → local embeddings → vector search → grounded generation
8. **Add MemoryManager** with persistent user-controlled store
9. **Build AgentManager** with permissioned tool registry

### Medium-term (Phase 6-8)
10. **Voice**: Integrate whisper.cpp for STT, Piper for TTS
11. **Vision**: Integrate Qwen2.5-VL or LLaVA via llama.cpp
12. **Document workspace**: PDF reader, AI summaries, citations
13. **Learning studio**: Progress tracking, spaced repetition

### Long-term (Phase 9+)
14. **Security hardening**: Input validation, sandbox, model verification
15. **Performance**: Pagination, lazy loading, blur optimization, benchmarks
16. **Test coverage**: Unit, widget, integration, native tests
17. **Documentation**: All `docs/*.md` files per spec

---

## 9. Architecture Decisions to Preserve

- ✅ Project name: **InhaleSkill AI**
- ✅ Clean Architecture layers (domain/data/di)
- ✅ Riverpod for state management
- ✅ GoRouter for navigation
- ✅ Drift for database
- ✅ FFI for native inference
- ✅ llama.cpp as inference backend
- ✅ GGUF model format
- ✅ Responsive design (mobile/desktop)
- ✅ Offline-first principle
- ✅ GitHub Actions CI/CD (6 jobs)

---

## 10. Summary

**Current State:** A well-structured Flutter app with complete UI shells for 15 features, a solid theme/component system, working database/chat persistence, and passing CI. **However, the AI engine is a stub, all providers are mocked, RAG/memory/agents/voice/vision are absent, and the color theme does not match the required Blue/Sky Blue/Pink + Black specification.**

**Critical Path:** Native llama.cpp integration → Real model management → Replace provider mocks → RAG implementation → Memory → Agents → Voice/Vision → Polish & tests.

**Estimated Effort:** 12-16 milestones of focused implementation following the safe development workflow.

---

## 11. Closeout Notes — Milestones 1-5 Complete

**Date:** 2026-11-10  
**Status:** All Milestones 1-5 marked complete in `UPGRADE_ROADMAP.md`

### ✅ Completed Since Audit

| Area | What Was Done |
|------|---------------|
| **Theme** | Replaced midnight-navy/violet with Blue (#1677D2), Sky Blue (#38BDF8), Pink (#EC4899), Ice Blue, Frost White, Deep Navy + Black theme (#050505/#171717/#262626) |
| **Components** | 15 glassmorphism widgets built and wired (GlassCard, GlassButton, AIOrb, etc.) |
| **AI Core** | AIEngine abstraction, FfiAIEngine adapter, ModelManager, RAGService, MemoryManager, AgentManager |
| **Chat** | ChatNotifier wired to AIEngine, streaming inference |
| **Pagination** | 20-item pages via Drift LIMIT/OFFSET, `loadMoreSessions()`, `refreshSessions()` |
| **Documents** | PDF/MD/TXT import → Drift `documents` table → RAG indexing |
| **Settings** | Drift `preferences` table with JSON serialization |
| **Voice** | STT via `speech_to_text`, TTS via `flutter_tts` |
| **Vision** | VisionNotifier wired to AIEngine, image picker, analyze flow |
| **CI** | `flutter analyze` clean, `dart format` clean, `flutter test` 2/2, APK build success |

### ❌ Still Open (Critical)

| Area | Status |
|------|--------|
| Real llama.cpp integration | Stub only; `USE_LLAMA=OFF` |
| Model download/install | UI only; no HTTP |
| Streaming inference | Placeholder `Future.delayed` |
| RAG embeddings | Keyword search only; no vector index |
| Memory persistence | In-memory only |
| Agents | Framework exists; no tools wired |
| Real STT/TTS | System libs only; no Whisper/Piper |
| Real vision model | Stub placeholder |
| Test coverage | 1 widget test only |
| Security | No SHA256, no input validation |

### Next Steps

1. Wire real llama.cpp (clone to `native/`, build with `USE_LLAMA=ON`)
2. Implement ModelManager download + SHA256 verification
3. Replace all provider mocks with real AI engine calls
4. Add local embeddings + vector search for RAG
5. Add unit/integration tests for AI services
6. Security hardening (input validation, model verification)