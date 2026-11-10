# InhaleSkill AI — Project Analysis

**Repository:** https://github.com/charansaiteja-cloud/inhales-ai.git  
**Analysis Date:** 2026-11-10  
**Current Version:** 1.0.0+1 (Flutter 3.47+, Dart SDK >=3.7.0)

---

## 1. Existing Architecture

### 1.1 Project Structure
```
inhales-ai/
├── app/                          # Flutter application
│   ├── lib/
│   │   ├── ai/                   # AI Engine & Services
│   │   │   ├── agent/            # AI Agent system (ToolRegistry)
│   │   │   ├── engine/           # AI Engine abstraction + FFI impl
│   │   │   ├── manager/          # Model management
│   │   │   ├── memory/           # Long-term memory manager
│   │   │   ├── models/           # Hardware profile, model catalog
│   │   │   └── rag/              # RAG Service (vector search)
│   │   ├── core/                 # Core infrastructure
│   │   │   ├── constants/        # App constants
│   │   │   ├── responsive/       # Responsive layout utilities
│   │   │   ├── routing/          # GoRouter configuration
│   │   │   └── theme/            # Inhale* theme system (Blue & White Liquid Glass)
│   │   ├── data/                 # Data layer (repository implementations)
│   │   ├── database/             # Drift/SQLite database
│   │   │   ├── tables/           # 10 table definitions
│   │   │   └── database.dart     # AppDatabase + migrations
│   │   ├── di/                   # Dependency injection (Riverpod)
│   │   ├── domain/               # Domain layer (entities + repository interfaces)
│   │   ├── features/             # Feature modules (17 screens)
│   │   ├── services/             # Shared services (hardware, storage, offline)
│   │   ├── shared/               # Shared widgets & layouts
│   │   ├── widgets/              # Glass UI components (17 components)
│   │   ├── app.dart              # Root widget
│   │   └── main.dart             # Entry point
│   ├── native/                   # Native C++ engine
│   │   └── inference/            # llama.cpp FFI wrapper (inhale_engine.cpp)
│   ├── test/                     # 47 tests (all passing)
│   ├── pubspec.yaml
│   └── analysis_options.yaml
├── docs/
│   ├── architecture.md
│   ├── TERMUX_INSTALL.md
│   ├── UPGRADE_AUDIT.md
│   └── UPGRADE_ROADMAP.md
├── CHANGELOG.md
├── LICENSE
└── README.md
```

### 1.2 Technology Stack

| Layer | Technology |
|-------|------------|
| **Frontend** | Flutter 3.47+, Dart SDK >=3.7.0 |
| **State Management** | Riverpod 2.6.1 (ProviderScope, StateNotifierProvider) |
| **Navigation** | GoRouter 18.1.3 (17 routes) |
| **Database** | Drift 2.22.0 + SQLite3 (sqlcipher-ready) |
| **Vector Search** | sqlite-vec (planned), fallback hash-based embeddings |
| **Local LLM** | llama.cpp via FFI (C++ native engine) |
| **Document Processing** | pdf 3.10.4, printing 5.11.0 |
| **File Handling** | file_picker 10.1.0, path_provider 2.1.5 |
| **Markdown** | markdown 7.2.2 |
| **TTS/STT** | flutter_tts 4.0.1, speech_to_text 7.0.0 |
| **Security** | flutter_secure_storage 10.3.4, crypto 3.0.0 |
| **Utilities** | http 1.2.1, connectivity_plus 7.3.2, shared_preferences 2.3.2 |

### 1.3 Architecture Pattern
**Clean Architecture** with clear separation:
- **Domain Layer**: Entities (`Conversation`, `Message`, `Model`) + Repository interfaces
- **Data Layer**: Repository implementations using Drift database
- **DI Layer**: Riverpod providers wiring everything together
- **Feature Layer**: Self-contained modules with providers + UI

### 1.4 Database Schema (10 Tables)
| Table | Purpose | Key Columns |
|-------|---------|-------------|
| `conversations` | Chat sessions | id, title, mode, context, createdAt, updatedAt, isPinned, messageCount |
| `messages` | Chat messages | id, conversationId(FK), role, content, createdAt, isEdited, isBookmarked, tokenCount |
| `notes` | User notes | id, title, content, folder, subject, classLevel, createdAt, updatedAt, isPinned, tags |
| `bookmarks` | Message bookmarks | id, messageId(FK), createdAt |
| `quiz_history` | Quiz attempts | id, title, subject, classLevel, totalQuestions, correctAnswers, score, durationSeconds, createdAt |
| `learning_activity` | Activity tracking | id, activityType, subject, classLevel, durationMinutes, date |
| `app_models` | Installed LLMs | id, name, filePath, quantization, sizeBytes, architecture, isActive, installedAt |
| `preferences` | Key-value settings | key(PK), value |
| `documents` | Uploaded files | id, title, filePath, fileType, sizeBytes, extractedText, summary, importedAt |
| `memories` | Long-term memory | id, conversationId(FK), type, content, importance, createdAt |

**Additional RAG Table** (created at runtime): `document_chunks` with embedding vectors stored as JSON

### 1.5 Routing (17 Routes)
```
/ → splash → /onboarding → /home
/home → /chat, /school, /college, /general, /writing, /coding, /math,
         /translation, /vision, /documents, /quizzes, /notes, /voice,
         /presentations, /models, /settings
/chat/:id → chat detail with conversation ID
```

---

## 2. Existing Features

### 2.1 Fully Implemented Features
| Feature | Screen | Provider | Status |
|---------|--------|----------|--------|
| **AI Chat** | ChatScreen | ChatProvider | ✅ Streaming, history sidebar, multi-session, pin/rename/delete |
| **School** | SchoolScreen | SchoolProvider | ✅ Classes 1-10, subjects |
| **College** | CollegeScreen | CollegeProvider | ✅ Engineering, CS, Sciences, Commerce, Humanities |
| **Writing** | WritingScreen | WritingProvider | ✅ Essays, letters, resumes, creative |
| **Coding** | CodingScreen | CodingProvider | ✅ Generation, explanation, debugging |
| **Mathematics** | MathScreen | MathProvider | ✅ Calculations, step-by-step |
| **Translation** | TranslationScreen | TranslationProvider | ✅ Offline text translation |
| **Vision** | VisionScreen | VisionProvider | ✅ Image understanding (with vision model) |
| **Documents** | DocumentsScreen | DocumentsProvider | ✅ PDF/TXT/DOCX upload, list, search, delete |
| **Quizzes** | QuizScreen | QuizProvider | ✅ AI-generated MCQs, practice mode, scoring |
| **Notes** | NotesScreen | NotesProvider | ✅ CRUD, folders, subjects, search (in-memory only) |
| **Voice** | VoiceScreen | VoiceProvider | ✅ STT, TTS, basic commands |
| **Presentations** | PresentationScreen | PresentationProvider | ✅ Slide generation |
| **Model Manager** | ModelManagerScreen | ModelManagerProvider | ✅ Download, list, activate models |
| **Settings** | SettingsScreen | SettingsProvider | ✅ Theme, offline mode, font size, CPU/GPU config |
| **General** | GeneralScreen | GeneralProvider | ✅ General purpose chat |

### 2.2 AI Engine & RAG
- **AIEngine abstraction** with FFI implementation wrapping llama.cpp
- **Native C++ engine** (`inhale_engine.cpp`) with full llama.cpp integration
- **RAG Service** with:
  - Document chunking (512 chars, 64 overlap)
  - Hash-based embeddings (384-dim, deterministic)
  - Hybrid search (vector + keyword, 0.7/0.3 weights)
  - SQLite storage with `document_chunks` table
  - In-memory index for fast retrieval

### 2.3 UI System
- **Liquid Glass design** with 17 custom glass components
- **InhaleTheme** with light/dark modes (Blue & White palette)
- **InhaleColors**, **InhaleTypography**, **InhaleTokens**, **InhaleSpacing**
- Responsive layouts with sidebar + bottom navigation

---

## 3. Missing Features (Gap Analysis)

### 3.1 Database Gaps (Tables Needed)
| Missing Table | Purpose | Required By |
|---------------|---------|-------------|
| `subjects` | Subject/course catalog | Study Planner, Exam Prep, Analytics |
| `chapters` | Chapter hierarchy | Study Planner, Exam Prep |
| `topics` | Topic breakdown | All learning features |
| `learning_resources` | Unified resource library | Library, PDF Assistant, Notes |
| `flashcards` | Spaced repetition cards | Flashcard Generator |
| `flashcard_reviews` | Review history + intervals | Spaced Repetition |
| `study_plans` | Generated timetables | Study Planner |
| `study_sessions` | Session tracking | Analytics, Planner |
| `exam_schedules` | Exam dates + config | Exam Prep, Planner |
| `achievements` | Gamification badges | Gamification |
| `notifications` | In-app reminders | Notifications |
| `recommendations` | AI recommendations | Recommendation Engine |
| `mind_maps` | Mind map data | Mind Map Generator |
| `video_transcripts` | Video learning data | Video Assistant |

### 3.2 Feature Gaps (Per Master Prompt Phases 3-21)
| Phase | Feature | Status |
|-------|---------|--------|
| 3 | AI Personal Study Assistant (tutor behavior) | ⚠️ Basic chat exists, needs tutor personality |
| 4 | AI PDF/Document Assistant (NotebookLM-style) | ⚠️ Basic RAG exists, needs Q&A, citations, study materials |
| 5 | AI Notes Generator | ⚠️ Basic notes exist, needs AI generation from topics/PDFs/video |
| 6 | AI Quiz Generator | ⚠️ Basic MCQ exists, needs more types, exam modes, PDF-based |
| 7 | AI Flashcard Generator + Spaced Repetition | ❌ Missing entirely |
| 8 | AI Study Planner | ❌ Missing entirely |
| 9 | AI Exam Preparation | ❌ Missing entirely |
| 10 | AI Math Solver (OCR, graphs, symbolic) | ⚠️ Basic math exists, needs image input, step-by-step |
| 11 | AI Video Learning Assistant | ❌ Missing entirely |
| 12 | AI Mind Map Generator | ❌ Missing entirely |
| 13 | AI Voice Learning Assistant | ⚠️ Basic STT/TTS exists, needs tutor conversations |
| 14 | AI Language Learning | ❌ Missing entirely |
| 15 | AI Learning Analytics | ⚠️ Basic activity tracking exists, needs dashboards |
| 16 | Personalized Recommendations | ❌ Missing entirely |
| 17 | Gamification | ❌ Missing entirely |
| 18 | Personal Study Library | ⚠️ Documents exist, needs unified library |
| 19 | Notifications & Reminders | ❌ Missing entirely |
| 20 | Admin Dashboard | ❌ Not needed (single-user app) |
| 21 | UI/UX Redesign | ⚠️ Good base, needs study-platform navigation |

---

## 4. Current Issues & Technical Debt

| Issue | Severity | Location |
|-------|----------|----------|
| NotesProvider uses in-memory state only (no DB persistence) | High | `notes_provider.dart` |
| Quiz parsing is fragile (string splitting) | Medium | `quiz_provider.dart` |
| RAG uses hash embeddings (not semantic) | Medium | `rag_service.dart` |
| No vector database (sqlite-vec not integrated on Android) | Medium | `database.dart`, `rag_service.dart` |
| Voice commands not connected to AI Engine | Low | `voice_provider.dart` |
| ModelManager provider throws UnimplementedError | Low | `di.dart` |
| Some features use mock data instead of AI generation | Medium | Various providers |
| No API provider abstraction (only local llama.cpp) | Medium | `ai_engine.dart`, `di.dart` |
| No file upload size limits or validation | Low | `documents_provider.dart` |
| No pagination for large lists | Low | Various screens |

---

## 5. Recommended Implementation Approach

### 5.1 Phase Order (Dependency-Based)
```
Phase 1: Analysis ✅ (this document)
Phase 2: REA Research → AI_STUDY_PLATFORM_RESEARCH.md
Phase 3: AI Tutor (extends chat_provider)
Phase 4: PDF Assistant (extends RAG + documents)
Phase 5: Notes Generator (extends notes + RAG)
Phase 6: Quiz Generator (extends quiz_provider)
Phase 7: Flashcards + Spaced Repetition (new tables + provider)
Phase 8: Study Planner (new tables + AI scheduling)
Phase 9: Exam Prep (extends quiz + planner)
Phase 10: Math Solver (new OCR + symbolic lib)
Phase 11: Video Assistant (new transcript extraction)
Phase 12: Mind Maps (new graph library)
Phase 13: Voice Tutor (extends voice + chat)
Phase 14: Language Learning (new provider)
Phase 15: Analytics Dashboard (extends learning_activity)
Phase 16: Recommendations (new ML/logic)
Phase 17: Gamification (new tables)
Phase 18: Unified Library (extends documents)
Phase 19: Notifications (new table + service)
Phase 20: Skip (single-user app)
Phase 21: UI Redesign (new navigation + dashboard)
Phase 22: Database Migration (all missing tables)
Phase 23: Multi-Provider AI (abstraction layer)
Phase 24: Performance & Security
Phase 25: Testing
Phase 26: Documentation
```

### 5.2 Key Architectural Decisions

1. **Preserve Clean Architecture** - Add new domain entities, repositories, providers for each feature
2. **Extend Existing Providers** - Don't rewrite chat_provider, enhance it with tutor modes
3. **RAG Enhancement** - Add proper embedding model support (sentence-transformers via FFI or ONNX)
4. **Database Migrations** - Add missing tables in schema v6+ with proper indexes
5. **AI Provider Abstraction** - Create `AIProvider` interface for OpenAI/Gemini/local
6. **Modular Feature Flags** - Each phase behind feature flag for incremental rollout

### 5.3 Dependencies to Add
```yaml
# Phase 7 - Spaced Repetition
# Phase 10 - Math OCR
# Phase 11 - Video processing
# Phase 12 - Graph visualization
# Phase 15 - Charts
  fl_chart: ^0.69.0
  # or syncfusion_flutter_charts
```

---

## 6. Running the Project

```bash
cd /tmp/inhales-ai/app
flutter pub get
flutter analyze  # 0 errors, 0 warnings
flutter test     # 47 tests passing
flutter run      # Runs on connected device/emulator
```

**Build Verification:**
- `flutter build apk --release` → 73.5MB APK (successful)
- All 47 tests pass including widget, AI agent, tool registry tests

---

## 7. Summary

**Strengths:**
- Solid Clean Architecture foundation
- Working local LLM inference via llama.cpp FFI
- Functional RAG with hybrid search
- Complete theme system (Liquid Glass)
- 17 feature screens with Riverpod state management
- All tests passing, clean build

**Critical Gaps for Study Platform:**
1. No spaced repetition / flashcards
2. No study planning / scheduling
3. No exam preparation module
4. No mind maps / video learning / language learning
5. No analytics dashboard / recommendations / gamification
6. Notes not persisted to database
7. RAG embeddings not semantic (hash-based only)
8. Single AI provider (local only)

**Next Steps:**
1. Complete Phase 2 REA research on reference platforms
2. Begin Phase 3: Enhance ChatProvider with tutor personalities
3. Phase 4: Build document Q&A with citations on top of RAG
4. Phase 22: Add missing database tables in migration v6+