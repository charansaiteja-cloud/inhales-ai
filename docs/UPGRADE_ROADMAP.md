# InhaleSkill AI — Upgrade Roadmap

> **Status:** In Progress  
> **Baseline:** `docs/UPGRADE_AUDIT.md`  
> **Design spec:** Blue #1677D2 / Sky Blue #38BDF8 / Pink #EC4899 + Black theme (#050505, #171717, #262626)  
> **Constraint:** Project name stays `InhaleSkill AI`. Flutter 3.47+, Dart >=3.7.0. CI: `flutter analyze` 0 errors, `flutter test` passing, `dart format` clean.

---

## Milestone 0 — Baseline (DONE)
- [x] Full codebase audit → `docs/UPGRADE_AUDIT.md`
- [x] CI green (analyze, build-apk, build-aab, build-linux, build-windows, build-macos)
- [x] 15 feature screens, 10-table Drift schema, native C++ stub, FFI bindings verified

## Milestone 1 — Design Tokens & Theme (Blue/Sky Blue/Pink + Black) ✅
**Goal:** Replace the midnight-navy/violet palette with the required Blue/Sky Blue/Pink identity and a Black theme as the primary dark surface.

- [x] Rewrite `inhale_colors.dart` — new token set (Blue, Sky Blue, Pink, Ice Blue, Frost White, Deep Navy; Black theme: #050505, #171717, #262626)
- [x] Add `InhaleTheme.blackTheme` + keep `InhaleTheme.darkTheme` as alternate
- [x] Update `InhaleTokens` (glass blur, opacity, shadows) for Black glassmorphism
- [x] Update `InhaleTypography` to reference new tokens
- [x] Re-point all 30 consumers of `InhaleColors.*` to new tokens
- [x] `flutter analyze` clean, `dart format` clean

## Milestone 2 — Glassmorphism Component Library ✅
**Goal:** Ship the full reusable widget set in `app/lib/widgets/`.

- [x] `GlassCard`, `GlassButton`, `GlassTextField`, `GlassChatBubble`
- [x] `AIOrb`, `GlassBackground`, `GlassSidebar`, `GlassAppBar`
- [x] `GlassBottomNavigation`, `GlassSearchBar`, `GlassIconButton`
- [x] `GlassDialog`, `GlassBottomSheet`, `GlassLoadingIndicator`, `GlassStatusBadge`
- [x] All components theme-aware (Black / Dark / Light)
- [x] `flutter analyze` clean

## Milestone 3 — Offline-First AI Core ✅
**Goal:** Wire the AI engine into ChatProvider and ship RAG/Memory/Agent services.

- [x] `AIEngine` abstraction (`ai_engine.dart`) + `FfiAIEngine` adapter (`ffi_ai_engine.dart`)
- [x] `ModelManager` — downloads, installs, and lifecycle
- [x] `RAGService` — document chunking and keyword search
- [x] `MemoryManager` — conversation memory with fact extraction & relevance scoring
- [x] `AgentManager` — tool-use agent loop
- [x] DI providers registered in `di/di.dart`
- [x] `ChatNotifier` wired to `AIEngine` — replaces `_generatePlaceholderResponse` with streaming inference
- [x] `flutter analyze` clean, `flutter test` passes, `dart format` applied
**Goal:** Real local intelligence: RAG, memory, agents.

- [3.1] `AIEngine` abstraction + `ModelManager` (GGUF download, lifecycle)
- [3.2] `RAGService` — document chunking + vector index (Drift `documents` table)
- [3.3] `MemoryManager` — conversation memory (Drift `messages` + `notes`)
- [3.4] `AgentManager` — tool-use agent loop
- [3.5] Wire `ChatProvider` to real engine (replace `Future.delayed` mocks)
- [3.6] Tests for each service

## Milestone 4 — Feature Polish & Performance
**Goal:** Production hardening.

- [x] [4.1] Pagination for `ChatState.sessions` (Drift `LIMIT/OFFSET`, 20-item pages, `loadMoreSessions()`, `refreshSessions()`)
- [x] [4.2] Voice + Vision model wiring (STT via `speech_to_text`, TTS via `flutter_tts`, Qwen2.5-VL stub ready)
- [x] [4.3] Document processing pipeline (PDF/MD/TXT → chunks → RAG index, file picker, Drift `documents` table)
- [x] [4.4] Settings persistence via Drift `preferences` table (JSON serialization)

## Milestone 5 — Verification & Release
**Goal:** Sign-off.

- [x] [5.1] `flutter analyze` 0 errors, 0 warnings
- [x] [5.2] `flutter test` all green (2/2)
- [x] [5.3] `dart format` clean
- [x] [5.4] APK build successful (`app-debug.apk` generated)
- [x] [5.5] `docs/UPGRADE_AUDIT.md` re-audit → closeout notes added (Section 11)

---

## Verification Gate (per milestone)
After each milestone: run `cd app && flutter analyze && dart format --set-exit-if-changed .` before proceeding.