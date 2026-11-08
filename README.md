# InhaleSkill AI

**InhaleSkill AI** is a cross-platform, offline AI learning and productivity assistant built with Flutter. It supports Classes 1–10, college learning, AI chat, coding, mathematics, writing, quizzes, notes, translation, image and document understanding, voice assistance, PDF and presentations, with adaptive local AI models and a premium Blue & White Liquid Glass UI.

## Features

- **Offline AI** — 100% local inference via llama.cpp FFI; no cloud, no login, no telemetry
- **Chat** — streaming AI conversations with local model
- **School** — Classes 1–10 curriculum modules
- **College** — higher education learning modules
- **General** — general-purpose AI assistant
- **Writing** — assisted writing and editing
- **Coding** — code assistant and explanation
- **Mathematics** — calculations and problem solving
- **Translation** — multi-language translation
- **Vision** — image and document understanding
- **Documents** — PDF and file processing
- **Quizzes** — test yourself with generated quizzes
- **Notes** — study workspace with local storage
- **Voice** — text-to-speech assistance
- **Presentations** — presentation generation
- **Model Manager** — download and manage local GGUF models
- **Liquid Glass UI** — premium blue & white glassmorphism design

## Tech Stack

- **Framework**: Flutter 3.47 (stable)
- **State**: Riverpod 2.5
- **Navigation**: GoRouter 14.2
- **Database**: Drift 2.22 (SQLite)
- **AI**: llama.cpp FFI (native C++ engine)
- **CI**: GitHub Actions

## Supported Platforms

- Android
- iOS
- Windows
- macOS
- Linux

## Hardware Requirements

- 4 GB RAM minimum (6 GB recommended)
- 64 GB storage
- Works fully offline

## Quick Start

```bash
git clone https://github.com/charansaiteja-cloud/inhales-ai.git
cd inhales-ai/app
flutter pub get
flutter run -d windows  # or -d linux, -d macos
```

## Termux Installation

See `scripts/install_termux.sh` for Termux setup instructions.

## License

MIT — see LICENSE