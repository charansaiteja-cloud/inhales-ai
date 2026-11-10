# InhaleSkill AI

**Universal Offline AI Learning and Productivity Assistant**

*Learn Anything. Build Skills. Anywhere.*

![Platforms](https://img.shields.io/badge/platform-Android%20%7C%20Linux%20%7C%20Windows%20%7C%20macOS-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Flutter](https://img.shields.io/badge/Flutter-3.47-blue)

InhaleSkill AI is a cross-platform, privacy-first AI application with **100% offline** local inference, a premium Blue & White Liquid Glass UI, and adaptive hardware support starting from 4 GB RAM devices.

## Features

| Category | Features |
|---|---|
| **Chat** | Streaming AI conversations, multi-session, history |
| **School** | Classes 1–10, subjects, quizzes, notes |
| **College** | Engineering, CS, sciences, commerce, humanities |
| **Writing** | Essays, letters, resumes, creative writing |
| **Coding** | Code generation, explanation, debugging |
| **Math** | Calculations, step-by-step solutions |
| **Translation** | Offline text translation |
| **Vision** | Image understanding (with vision model) |
| **Documents** | PDF, TXT, DOCX processing |
| **Quizzes** | MCQ, true/false, fill-in-blanks, timed |
| **Notes** | Local storage, folders, search, export |
| **Voice** | Text-to-speech, speech input |
| **PDF/PPTX** | Document generation and export |
| **Model Manager** | Download, install, switch local GGUF models |

## Tech Stack

- **Framework**: Flutter 3.47 / Dart 3.13
- **State**: Riverpod 2.6
- **Navigation**: GoRouter
- **Database**: Drift (SQLite)
- **AI Engine**: llama.cpp via FFI (native C++)
- **Models**: GGUF quantized models
- **CI/CD**: GitHub Actions

## Supported Platforms

| Platform | Status |
|---|---|
| Android (API 24+) | ✅ Built & tested (APK + AAB) |
| Linux (x64) | ✅ Built & tested |
| Windows | 🖥️ Platform configured (build on Windows host) |
| macOS | 🍎 Platform configured (build on macOS host) |

## Hardware Requirements

| Profile | RAM | Storage | Model |
|---|---|---|---|
| Minimum | 4 GB | 64 GB | Lightweight Q4 GGUF |
| Recommended | 6–8 GB | 128 GB | Balanced model |
| High-end | 12+ GB | 256 GB+ | Full-featured model |

## Quick Start

```bash
git clone https://github.com/charansaiteja-cloud/inhales-ai.git
cd inhales-ai/app
flutter pub get
flutter run
```

## Building

```bash
# Android release
cd app && flutter build apk --release

# Android Play Store
cd app && flutter build appbundle --release

# Linux
cd app && flutter build linux --release

# Windows (on Windows host)
cd app && flutter build windows --release

# macOS (on macOS host)
cd app && flutter build macos --release
```

## Termux (Build on Android Phone)

Build directly on your Android device — no computer needed!

```bash
# Quick install
pkg install -y git curl wget unzip xz-utils zip libclang clang cmake ninja-build openjdk-17 android-tools
git clone --depth 1 https://github.com/charansaiteja-cloud/inhales-ai.git
cd inhales-ai && bash scripts/install_termux.sh
```

**Requirements:** 4GB+ RAM, 2.5GB+ storage, ARM64 device  
**Build time:** 20-40 minutes

📖 Full guide: [`docs/TERMUX_INSTALL.md`](docs/TERMUX_INSTALL.md)

## Project Structure

```
inhales-ai/
├── app/                      # Flutter application
│   ├── lib/
│   │   ├── core/             # Theme, routing, constants
│   │   ├── ai/               # Inference engine, FFI, model manager
│   │   ├── features/         # Feature modules (chat, school, etc.)
│   │   ├── services/         # Storage, hardware detection
│   │   └── widgets/          # Liquid Glass UI components
│   └── test/                 # Tests
├── native/                   # Native C++ inference engine
│   └── inference/
├── scripts/                  # Build & install scripts
├── .github/workflows/        # CI/CD
└── docs/                     # Documentation
```

## Privacy

- No cloud AI APIs
- No mandatory login
- No telemetry
- No remote database
- All data stored locally via SQLite

## License

MIT — see [LICENSE](LICENSE)
