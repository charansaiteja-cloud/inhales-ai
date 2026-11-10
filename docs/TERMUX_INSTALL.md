# Termux Installation Guide

Build and run **InhaleSkill AI** directly on your Android phone using Termux — no computer needed.

## ⚡ Quick Install

```bash
# Copy-paste this into Termux:
pkg install -y git curl wget unzip xz-utils zip libclang clang cmake ninja-build openjdk-17 android-tools && git clone --depth 1 https://github.com/charansaiteja-cloud/inhales-ai.git && cd inhales-ai && bash scripts/install_termux.sh
```

Or just run the installer script:

```bash
git clone --depth 1 https://github.com/charansaiteja-cloud/inhales-ai.git
cd inhales-ai
bash scripts/install_termux.sh
```

## 📋 Requirements

| Item | Minimum | Recommended |
|------|---------|-------------|
| **RAM** | 4 GB | 6 GB+ |
| **Storage** | 2.5 GB free | 5 GB+ free |
| **Architecture** | ARM64 (aarch64) | ARM64 |
| **Battery** | 50%+ | Keep charging during build |
| **Build Time** | 20-40 min | ~15 min on newer devices |

## 📖 Step-by-Step Guide

### 1. Install Termux

Download from [F-Droid](https://f-droid.org/packages/com.termux/) (recommended) or the [official repo](https://github.com/termux/termux-app/releases).

> ⚠️ **Don't use the Google Play version** — it's outdated and missing critical packages.

### 2. Update Termux

```bash
pkg update && pkg upgrade
```

### 3. Grant Storage Access

```bash
termux-setup-storage
```

Grant permission when prompted. This is needed to install the APK.

### 4. Install Build Dependencies

```bash
pkg install -y git curl wget unzip xz-utils zip libclang clang cmake ninja-build openjdk-17 android-tools
```

### 5. Install Flutter SDK

```bash
cd ~
git clone --depth 1 https://github.com/flutter/flutter.git -b stable
export PATH="$HOME/flutter/bin:$PATH"
echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
```

Configure Flutter:

```bash
export JAVA_HOME="/data/data/com.termux/files/usr/lib/jvm/openjdk-17"
export PUB_CACHE="$HOME/.pub-cache"
flutter --version
flutter config --no-analytics
```

### 6. Clone and Build InhaleSkill AI

```bash
cd ~
git clone --depth 1 https://github.com/charansaiteja-cloud/inhales-ai.git
cd inhales-ai/app
flutter pub get
flutter build apk --release
```

The build takes **20-40 minutes** on a phone. Keep the screen on or use `tmux` to prevent interruptions.

### 7. Install the APK

```bash
cd ~/inhales-ai/app
pm install -r build/app/outputs/flutter-apk/app-release.apk
```

### 8. Launch the App

Find "InhaleSkill AI" in your app drawer and open it!

## 🔄 Using tmux for Background Builds

If you want to build in the background:

```bash
pkg install -y tmux
tmux new -s inhale
# Run the build commands above
# Press Ctrl+B then D to detach
# Reattach later with: tmux attach -t inhale
```

## 📱 First-Time Setup

After installing:

1. Open the app
2. Go to **Model Manager**
3. Choose a model based on your RAM:
   - **Qwen3 0.6B (Q4)** — ~420MB, works on 4GB+ RAM devices
   - **Qwen3 1.7B (Q4)** — ~1GB, best for 6GB+ RAM
   - **Qwen3 4B (Q4)** — ~2.4GB, needs 8GB+ RAM
4. Download and load the model
5. Start chatting!

## 🔧 Troubleshooting

### Build fails with "No space left on device"

```bash
# Check available space
df -h

# Clean Flutter cache
flutter clean
rm -rf ~/.pub-cache/hosted

# Free up Termux packages you don't need
pkg clean
```

### Flutter doctor shows errors

```bash
# Run flutter doctor
flutter doctor

# If Android SDK issues, install:
sdkmanager "platform-tools" "build-tools;34.0.0" "platforms;android-34"
```

### "Cannot find native library" error at runtime

The build script copies native libraries automatically. If you built manually:

```bash
# Ensure native libs are in the right place
mkdir -p app/android/app/src/main/jniLibs/arm64-v8a
cp native/build-arm64/libinference.so app/android/app/src/main/jniLibs/arm64-v8a/libinhale_engine.so
cp native/build-arm64/bin/libllama.so* app/android/app/src/main/jniLibs/arm64-v8a/
```

### App crashes on model download

Check available storage:
```bash
df -h
```

You need at least **500MB-3GB** free for model downloads.

## 💡 Tips

- **Build during charging** — the build process uses significant CPU
- **Close other apps** — free up RAM for compilation
- **Use `flutter clean`** before rebuilding if something goes wrong
- **Keep Termux updated** — `pkg update && pkg upgrade` monthly

## 🚀 Alternative: Download Pre-built APK

If building is too slow, download a pre-built APK:

1. Go to [Releases](https://github.com/charansaiteja-cloud/inhales-ai/releases)
2. Download the latest `app-release.apk`
3. Install: `pm install -r /path/to/app-release.apk`
