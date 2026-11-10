# AI Study Platform — Reference Platform Research

**Research Date:** 2026-11-10  
**Purpose:** Inform Phases 3-21 implementation for InhaleSkill AI study platform transformation

---

## 1. NotebookLM (Google) — Document-Centric AI Assistant

### Core Value Proposition
"Your AI research and thinking partner, grounded in the information you trust"

### Key Features
| Feature | Description | Implementation Insight |
|---------|-------------|------------------------|
| **Document Upload** | PDF, TXT, Markdown, Google Docs, Slides, URLs, YouTube links | Support multiple input types; our current PDF/TXT/DOCX is a good start |
| **Instant Summaries** | Auto-generated document summaries with key topics | Extend RAG service to generate structured summaries on import |
| **Q&A with Citations** | Answers grounded in sources with inline citations linking to exact passages | **Critical**: Our RAG needs citation tracking (chunk → source location) |
| **Audio Overviews** | Podcast-style audio summaries of documents | Phase 13 (Voice Learning) — TTS integration with structured script generation |
| **Suggested Questions** | Auto-generated follow-up questions based on content | Add to chat UX: "Suggested questions" panel after document load |
| **Note-Taking** | Pin AI responses as notes, organize into notebooks | Extend Notes feature with "pinned from chat" workflow |
| **Multi-Doc Synthesis** | Query across multiple uploaded documents | RAG already supports this; improve hybrid search ranking |

### UI/UX Patterns
- **Three-pane layout**: Sources (left) | Chat (center) | Notes/Insights (right)
- **Source grounding**: Every answer shows numbered citations [1][2] clickable to source highlight
- **Notebook metaphor**: Each project = notebook with multiple sources
- **No chat history persistence across notebooks** — each notebook is isolated context

### Gap for InhaleSkill
- We have: RAG, document upload, chat
- Need: Citation UI, multi-doc notebooks, audio summaries, suggested questions panel

---

## 2. Quizlet — Flashcards & Spaced Repetition

### Core Value Proposition
"Study smarter with spaced repetition and AI-generated study tools"

### Key Features
| Feature | Description | Implementation Insight |
|---------|-------------|------------------------|
| **Flashcard Creation** | Manual + AI-generated from notes/documents | Phase 7: AI Flashcard Generator from RAG chunks |
| **Study Modes** | Flashcards, Learn, Write, Spell, Test, Match, Gravity | Start with Flashcards + Learn (adaptive) + Test |
| **Spaced Repetition (SR)** | SM-2 variant with 4-button rating (Again/Hard/Good/Easy) | **Algorithm**: Implement FSRS (modern, better than SM-2) |
| **AI Features** | "Magic Notes" → flashcards, "Q-Chat" tutor bot | Our Phase 3 (AI Tutor) + Phase 7 (Flashcards) covers this |
| **Progress Tracking** | Mastery levels, streak, study time, upcoming reviews | Phase 15 Analytics dashboard |
| **Classes/Folders** | Organize sets into classes, share with others | We skip collaborative (per requirements) but keep folder org |

### Spaced Repetition Algorithm (FSRS)
```
Parameters per card: 
- stability (S): how long memory lasts
- difficulty (D): how hard to remember
- retrievability (R): probability of recall now

Review updates:
- Again: S decreases significantly, D increases
- Hard: S decreases slightly, D increases slightly  
- Good: S increases, D decreases slightly
- Easy: S increases significantly, D decreases

Next interval = S * ln(1/0.9) / ln(stability_factor)
```

### Data Model for Flashcards
```sql
-- Flashcards table
CREATE TABLE flashcards (
  id INTEGER PRIMARY KEY,
  deck_id INTEGER REFERENCES flashcard_decks(id),
  front TEXT NOT NULL,
  back TEXT NOT NULL,
  source_document_id INTEGER,  -- link to RAG document
  source_chunk_id TEXT,        -- citation for grounding
  tags TEXT,                   -- JSON array
  created_at DATETIME,
  updated_at DATETIME
);

-- Reviews table (FSRS state)
CREATE TABLE flashcard_reviews (
  id INTEGER PRIMARY KEY,
  flashcard_id INTEGER REFERENCES flashcards(id),
  rating INTEGER,              -- 1=Again, 2=Hard, 3=Good, 4=Easy
  stability REAL,
  difficulty REAL,
  elapsed_days INTEGER,
  scheduled_days INTEGER,
  reviewed_at DATETIME
);
```

---

## 3. Khan Academy — Mastery-Based Learning Dashboard

### Core Value Proposition
"Free world-class education for anyone, anywhere" — Mastery learning system

### Key Features
| Feature | Description | Implementation Insight |
|---------|-------------|------------------------|
| **Mastery Levels** | Not Started → Attempted → Familiar → Proficient → Mastered | Phase 15: 5-level mastery per topic/chapter |
| **Skill Tree** | Hierarchical: Course → Unit → Lesson → Skill | Map to: Subject → Chapter → Topic → Subtopic |
| **Mastery Challenges** | Mixed review across mastered skills | Phase 9: Exam Prep "Mastery Challenge" mode |
| **Progress Dashboard** | Visual rings, bars, streak, time spent | Phase 15: Circular progress, heatmap calendar |
| **Daily/Weekly Missions** | Gamified goals (5 skills, 30 min, etc.) | Phase 17: Gamification missions |
| **Course Mastery** | % complete per course, unit mastery | Aggregate topic mastery → subject mastery |

### Mastery Calculation
```
Mastery Score = (Correct Streak Weight) × (Recency Weight) × (Difficulty Weight)
- Correct answers increase mastery
- Wrong answers decrease mastery  
- Time decay: mastery drops if not practiced
- Spaced repetition integrated into mastery gains
```

### UI Patterns
- **Dashboard cards**: Mastery ring (circular progress), Missions, Learning Queue
- **Skill tree sidebar**: Expandable tree with mastery icons (empty/partial/full circles)
- **Exercise interface**: Immediate feedback, hints, video link, scratchpad

---

## 4. StudyFetch — All-in-One AI Study Platform

### Core Value Proposition
"Upload course materials → get notes, flashcards, quizzes, tutor, study plan"

### Key Features (Marketing Claims)
| Feature | Description | Our Phase Mapping |
|---------|-------------|-------------------|
| **Sparky (AI Tutor)** | 24/7 personalized tutor, conversational | Phase 3: AI Personal Study Assistant |
| **Study Plan** | Auto-generated schedule from syllabus/deadlines | Phase 8: AI Study Planner |
| **Notes** | AI-organized notes from PDFs, PPTs, videos | Phase 5: AI Notes Generator |
| **Flashcards** | Auto-generated with spaced repetition | Phase 7: AI Flashcard Generator |
| **Quizzes** | Practice tests, exam simulation | Phase 6: AI Quiz Generator |
| **Live Lecture** | Real-time transcription + note generation | Phase 11: Video Learning Assistant |
| **Arcade** | Gamified learning games | Phase 17: Gamification |

### Architecture Insight
- **Single upload → multiple outputs**: One document ingestion pipeline feeds notes, flashcards, quizzes, tutor context
- **Unified "Study Plan"**: Central orchestrator that schedules all activities
- **Sparky personality**: Encouraging, adaptive, remembers struggles

---

## 5. Photomath — Math Solver with OCR

### Core Value Proposition
"Scan math problems → step-by-step solutions with multiple methods"

### Key Features
| Feature | Description | Implementation Insight |
|---------|-------------|------------------------|
| **Camera OCR** | Recognizes handwritten & printed math | Phase 10: Integrate ML Kit / Tesseract + math parser |
| **Step-by-Step** | Multiple solution methods (algebraic, graphical, etc.) | Phase 10: Symbolic math engine (sympy via FFI or Dart port) |
| **Animated Tutorials** | Visual step animations | Phase 10: Custom math animation renderer |
| **Smart Calculator** | Keyboard input with math notation | Phase 10: Math keyboard + expression parser |
| **Word Problems** | Natural language → math extraction | Phase 10: LLM prompt for problem parsing |

### Technical Stack (Inferred)
- **OCR**: Custom CNN or Google ML Kit Text Recognition
- **Math Parsing**: Custom parser → AST → SymPy/ Giac for solving
- **Rendering**: LaTeX → MathML → Flutter custom painter for animations

---

## 6. Anki — Spaced Repetition Reference Implementation

### Algorithm: FSRS (Free Spaced Repetition Scheduler)
- **Superior to SM-2**: Models memory decay continuously, handles variable intervals
- **Parameters**: 17 global parameters optimized per user (or use defaults)
- **State per card**: Stability (days), Difficulty (0-10), Last Review, Due Date

### Key Implementation Details
```
Review Logic:
1. Calculate retrievability R = exp(-elapsed_days / stability)
2. User rates: Again(1), Hard(2), Good(3), Easy(4)
3. Update stability & difficulty using FSRS formulas
4. Next interval = stability * ln(1/0.9) * difficulty_factor

Default Parameters (from FSRS-4.5):
w = [0.4, 0.6, 2.4, 5.8, 4.93, 0.94, 0.86, 0.01, 1.49, 0.14, 0.94, 2.18, 0.05, 0.34, 1.26, 0.29, 2.61]
```

### Data Export Format (APKG)
- SQLite database with `col` (collection), `notes`, `cards`, `revlog`, `graves` tables
- Useful for import/export feature in Phase 7

---

## 7. Comparative Feature Matrix

| Feature | NotebookLM | Quizlet | Khan Academy | StudyFetch | Photomath | Anki | **InhaleSkill (Target)** |
|---------|-----------|---------|--------------|------------|-----------|------|-------------------------|
| Document Q&A | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ Phase 4 |
| Citations | ✅ | ❌ | ❌ | ⚠️ | ❌ | ❌ | ✅ Phase 4 |
| Audio Summaries | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ Phase 13 |
| Flashcards | ❌ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ Phase 7 |
| Spaced Repetition | ❌ | ✅ (SR) | ⚠️ Mastery | ✅ | ❌ | ✅ (FSRS) | ✅ Phase 7 (FSRS) |
| Quiz Generation | ❌ | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ Phase 6 |
| Notes Generation | ⚠️ Pin only | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ Phase 5 |
| Study Planner | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ Phase 8 |
| Exam Prep | ❌ | ✅ Test mode | ✅ Mastery | ✅ | ❌ | ❌ | ✅ Phase 9 |
| Math Solver | ❌ | ❌ | ✅ Exercises | ❌ | ✅ OCR+Steps | ❌ | ✅ Phase 10 |
| Video Learning | ✅ YouTube | ❌ | ✅ Videos | ✅ Live | ❌ | ❌ | ✅ Phase 11 |
| Mind Maps | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ Phase 12 |
| Voice Tutor | ❌ | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ Phase 13 |
| Language Learning | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ Phase 14 |
| Analytics | ❌ | ✅ Progress | ✅ Mastery | ⚠️ | ❌ | ✅ Stats | ✅ Phase 15 |
| Recommendations | ❌ | ❌ | ✅ Next skills | ✅ | ❌ | ❌ | ✅ Phase 16 |
| Gamification | ❌ | ✅ Streaks | ✅ Missions | ✅ Arcade | ✅ Streaks | ✅ Streaks | ✅ Phase 17 |
| Unified Library | ✅ Notebooks | ✅ Folders | ✅ Courses | ✅ | ❌ | ✅ Decks | ✅ Phase 18 |
| Notifications | ❌ | ✅ Reminders | ✅ | ✅ | ✅ | ✅ | ✅ Phase 19 |
| Multi-Provider AI | ✅ Gemini | ❌ | ❌ | ✅ | ❌ | ❌ | ✅ Phase 23 |

---

## 8. Implementation Priority & Dependencies

### Phase Dependency Graph
```
Phase 3 (AI Tutor) 
    └─→ Phase 4 (PDF Assistant) — needs tutor + RAG citations
    └─→ Phase 5 (Notes Gen) — needs tutor + RAG
    └─→ Phase 6 (Quiz Gen) — needs tutor + RAG
    └─→ Phase 7 (Flashcards) — needs quiz/questions + FSRS algo
    └─→ Phase 8 (Planner) — needs flashcards + quiz + topics
    └─→ Phase 9 (Exam Prep) — needs planner + quiz + flashcards
    └─→ Phase 10 (Math) — independent (OCR + symbolic)
    └─→ Phase 11 (Video) — needs transcript extraction + tutor
    └─→ Phase 12 (Mind Maps) — needs notes + topic hierarchy
    └─→ Phase 13 (Voice) — extends Phase 3 + TTS/STT
    └─→ Phase 14 (Language) — extends Phase 3 + Phase 7
    └─→ Phase 15 (Analytics) — needs all activity data
    └─→ Phase 16 (Recs) — needs analytics + content
    └─→ Phase 17 (Gamification) — needs analytics + streak data
    └─→ Phase 18 (Library) — unifies documents/notes/flashcards
    └─→ Phase 19 (Notifications) — needs planner + streak
```

### Critical Path (Minimum Viable Study Platform)
1. **Phase 3** — AI Tutor personalities (extends existing chat)
2. **Phase 4** — Document Q&A with citations (extends RAG)
3. **Phase 7** — Flashcards + FSRS (new tables + algorithm)
4. **Phase 8** — Study Planner (scheduling engine)
5. **Phase 15** — Analytics Dashboard (visualizes all data)

### Database Migration Strategy (Phase 22)
```sql
-- Migration v6: Study Platform Tables
CREATE TABLE subjects (...);
CREATE TABLE chapters (...);
CREATE TABLE topics (...);
CREATE TABLE learning_resources (...);
CREATE TABLE flashcards (...);
CREATE TABLE flashcard_reviews (...);
CREATE TABLE study_plans (...);
CREATE TABLE study_sessions (...);
CREATE TABLE exam_schedules (...);
CREATE TABLE achievements (...);
CREATE TABLE notifications (...);
CREATE TABLE recommendations (...);
CREATE TABLE mind_maps (...);
CREATE TABLE video_transcripts (...);
-- Indexes for query performance
CREATE INDEX idx_flashcards_deck ON flashcards(deck_id);
CREATE INDEX idx_reviews_due ON flashcard_reviews(due_date);
CREATE INDEX idx_sessions_date ON study_sessions(date);
```

---

## 9. Key Technical Decisions

### AI Provider Abstraction (Phase 23)
```dart
abstract class AIProvider {
  Future<String> complete(String prompt, {ModelConfig config});
  Stream<String> streamComplete(String prompt, {ModelConfig config});
  Future<List<double>> embed(String text);  // For semantic RAG
  int get maxContextTokens;
}

class LocalLLMProvider implements AIProvider { /* llama.cpp FFI */ }
class GeminiProvider implements AIProvider { /* Google AI API */ }
class OpenAIProvider implements AIProvider { /* OpenAI API */ }
```

### FSRS Implementation (Phase 7)
- **Option A**: Port `ts-fsrs` (TypeScript) to Dart
- **Option B**: Use Python `fsrs` via FFI (heavier)
- **Option C**: Implement core algorithm in Dart (recommended — lightweight)

### Vector Search Upgrade (Phase 4+)
- **Current**: Hash-based embeddings (deterministic, not semantic)
- **Target**: sentence-transformers (all-MiniLM-L6-v2, 384-dim) via ONNX Runtime FFI
- **Interim**: Keep hash for exact-match, add semantic as parallel index

---

## 10. UI/UX Design Principles (from Research)

### Navigation Pattern
- **NotebookLM**: Three-pane (Sources | Chat | Notes) — adopt for document-centric views
- **Quizlet**: Deck list → Study modes → Review — adopt for flashcard flow
- **Khan Academy**: Dashboard → Skill Tree → Exercise — adopt for mastery/progress

### Color & Feedback
- **Mastery colors**: Gray (0%) → Blue (learning) → Green (mastered)
- **SR buttons**: Red (Again) → Orange (Hard) → Green (Good) → Blue (Easy)
- **Streaks**: Fire icon + count, daily completion ring

### Information Density
- **Mobile-first**: Bottom nav (5 tabs max) + collapsible sidebar
- **Tablet/Desktop**: Persistent sidebar + three-pane when space allows
- **Progressive disclosure**: Simple defaults, advanced options in settings

---

## 11. Next Actions

1. **Phase 3**: Enhance `ChatProvider` with tutor personalities (system prompts per mode)
2. **Phase 4**: Extend `RAGService` with citation tracking + document Q&A UI
3. **Phase 22**: Create database migration v6+ with all missing tables
4. **Phase 7**: Implement FSRS algorithm in Dart + flashcard CRUD + review UI
5. **Phase 23**: Abstract `AIEngine` → `AIProvider` interface for multi-provider support

---

## References

- NotebookLM: https://notebooklm.google.com
- Quizlet Spaced Repetition: https://help.quizlet.com/hc/en-us/articles/48324742264077
- Khan Academy Dashboard: https://support.khanacademy.org/hc/en-us/articles/46935588089997
- StudyFetch: https://www.studyfetch.com
- Photomath: https://photomath.com
- Anki FSRS: https://docs.ankiweb.net/faqs/what-spaced-repetition-algorithm.html
- FSRS Algorithm: https://github.com/open-spaced-repetition/fsrs4anki
- TS-FSRS (TypeScript): https://github.com/open-spaced-repetition/ts-fsrs