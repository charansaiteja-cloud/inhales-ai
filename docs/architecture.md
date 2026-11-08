# InhaleSkill AI Documentation

## Architecture

InhaleSkill AI follows a layered architecture:

- **Presentation**: Flutter widgets with Riverpod state management
- **Application**: Feature providers and use cases
- **Domain**: AI engine abstraction and model management
- **Infrastructure**: Drift SQLite database, FFI native engine

## AI Integration

The app uses llama.cpp via FFI for local inference. The native engine is a stub by default; to enable real llama.cpp integration:

1. Clone llama.cpp into `native/llama.cpp`
2. Build with `USE_LLAMA=ON`
3. Download a GGUF model via the Model Manager

## Database Schema

Tables:
- `conversations` — chat sessions
- `messages` — individual chat turns
- `notes` — user notes
- `bookmarks` — saved responses
- `quiz_history` — quiz attempts
- `learning_activity` — daily progress
- `models` — installed AI models
- `preferences` — user settings
- `documents` — imported files