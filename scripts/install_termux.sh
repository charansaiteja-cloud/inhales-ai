#!/usr/bin/env bash
set -euo pipefail

# InhaleSkill AI — Termux installer
# Installs Flutter, builds the native llama.cpp engine, and produces a release APK.
# Works on ARM64 Android devices (phones/tablets).

REPO_URL="https://github.com/charansaiteja-cloud/inhales-ai.git"
REPO_DIR="$HOME/inhales-ai"
FLUTTER_DIR="$HOME/flutter"
FLUTTER_VERSION="3.47.0"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║          InhaleSkill AI — Termux Installer              ║"
echo "║  Builds a 100% offline AI assistant on your device      ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ── Validate Termux ──────────────────────────────────────
if [ -z "${TERMUX_VERSION:-}" ]; then
  echo "⚠️  This script is designed for Termux on Android."
  echo "   Continue anyway? (y/n)"
  read -r confirm
  [ "$confirm" != "y" ] && exit 1
fi

# ── Check storage ────────────────────────────────────────
AVAILABLE=$(df -m "$HOME" | awk 'NR==2 {print $4}')
echo "📦 Available storage: ${AVAILABLE} MB"

if [ "$AVAILABLE" -lt 2500 ]; then
  echo "❌ Insufficient storage. Need at least 2500 MB."
  echo "   Free up space or use a device with more storage."
  exit 1
fi

# ── Grant storage access (Termux requires this) ─────────
if [ ! -d "$HOME/storage" ]; then
  echo ""
  echo "📂 Termux needs storage access to install the APK."
  echo "   Run this in Termux, then grant permission:"
  echo "   termux-setup-storage"
  echo ""
  termux-setup-storage
fi

# ── Install system packages ─────────────────────────────
echo ""
echo "📦 Installing system packages..."
pkg update -y >/dev/null 2>&1
pkg upgrade -y >/dev/null 2>&1
pkg install -y git curl wget unzip xz-utils zip libclang clang cmake \
  ninja-build openjdk-17 android-tools 2>&1 | tail -3
echo "   ✓ Done"

# ── Install Flutter ──────────────────────────────────────
if [ ! -d "$FLUTTER_DIR/.git" ]; then
  echo ""
  echo "⬇️  Downloading Flutter SDK (~300 MB)..."
  git clone --depth 1 --branch stable \
    https://github.com/flutter/flutter.git "$FLUTTER_DIR" 2>&1 | tail -3
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
export PUB_CACHE="$HOME/.pub-cache"
export JAVA_HOME="/data/data/com.termux/files/usr/lib/jvm/openjdk-17"

echo ""
echo "🔧 Configuring Flutter..."
flutter --version >/dev/null 2>&1 || true
flutter config --no-analytics >/dev/null 2>&1 || true

# ── Clone repo ───────────────────────────────────────────
if [ ! -d "$REPO_DIR" ]; then
  echo ""
  echo "⬇️  Cloning InhaleSkill AI..."
  git clone --depth 1 "$REPO_URL" "$REPO_DIR" 2>&1 | tail -3
else
  echo ""
  echo "📂 Repository exists at $REPO_DIR"
  read -r -p "   Pull latest changes? (y/n) " pull
  if [ "$pull" = "y" ]; then
    cd "$REPO_DIR" && git pull --ff-only 2>&1 | tail -3
  fi
fi

# ── Detect architecture ──────────────────────────────────
ARCH=$(uname -m)
echo ""
echo "🖥️  Detected architecture: $ARCH"

case "$ARCH" in
  aarch64|arm64)
    TARGET_ABI="arm64-v8a"
    ;;
  x86_64)
    TARGET_ABI="x86_64"
    ;;
  *)
    TARGET_ABI="arm64-v8a"
    echo "⚠️  Unknown arch, defaulting to arm64-v8a"
    ;;
esac

# ── Build native engine (llama.cpp) ──────────────────────
echo ""
echo "🔨 Building native llama.cpp engine for $TARGET_ABI..."

NDK_DIR="/data/data/com.termux/files/usr"
LLAMA_SRC="$REPO_DIR/native/llama.cpp"

if [ ! -d "$LLAMA_SRC" ]; then
  echo "⬇️  Cloning llama.cpp..."
  mkdir -p "$REPO_DIR/native"
  git clone --depth 1 https://github.com/ggerganov/llama.cpp.git \
    "$LLAMA_SRC" 2>&1 | tail -3
fi

NATIVE_BUILD="$REPO_DIR/native/build-$TARGET_ABI"
rm -rf "$NATIVE_BUILD"
mkdir -p "$NATIVE_BUILD"

# Use system clang for Termux (no Android NDK needed)
cd "$REPO_DIR/native"
cmake -S. -B"$NATIVE_BUILD" \
  -DUSE_LLAMA=ON \
  -DCMAKE_BUILD_TYPE=Release \
  2>&1 | grep -E "(llama.cpp|Configuring|Generating)" || true

echo "   Building (this takes 5-15 minutes on phone)..."
cmake --build "$NATIVE_BUILD" --config Release -j$(nproc) 2>&1 | tail -5
echo "   ✓ Native engine built"

# ── Copy native libs to Flutter project ──────────────────
JNI_DIR="$REPO_DIR/app/android/app/src/main/jniLibs/$TARGET_ABI"
mkdir -p "$JNI_DIR"
cp "$NATIVE_BUILD/libinference.so" "$JNI_DIR/libinhale_engine.so"
cp "$NATIVE_BUILD/bin/libllama.so"* "$JNI_DIR/" 2>/dev/null || \
  cp "$NATIVE_BUILD/libllama.so"* "$JNI_DIR/" 2>/dev/null || true
echo "   ✓ Native libraries copied to $JNI_DIR"

# ── Flutter build ────────────────────────────────────────
cd "$REPO_DIR/app"
echo ""
echo "🔧 Getting Flutter dependencies..."
flutter pub get 2>&1 | tail -3

echo ""
echo "🔨 Building release APK..."
echo "   This takes 10-20 minutes on a phone."
echo ""

# Suppress the Flutter version check that may hang on Termux
flutter build apk --release --no-tree-shake-icons 2>&1 | tail -10

APK_PATH="$REPO_DIR/app/build/app/outputs/flutter-apk/app-release.apk"

if [ -f "$APK_PATH" ]; then
  APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
  echo ""
  echo "╔══════════════════════════════════════════════════════════╗"
  echo "║                   ✅ BUILD SUCCESSFUL                    ║"
  echo "╠══════════════════════════════════════════════════════════╣"
  echo "║  APK: $APK_PATH"
  echo "║  Size: $APK_SIZE"
  echo "╠══════════════════════════════════════════════════════════╣"
  echo "║  To install:                                            ║"
  echo "║    pm install -r $APK_PATH"
  echo "║                                                         ║"
  echo "║  Or just run:                                           ║"
  echo "║    bash $REPO_DIR/scripts/install_termux.sh --install"
  echo "╚══════════════════════════════════════════════════════════╝"
else
  echo ""
  echo "❌ Build failed. Check the output above for errors."
  echo "   Common fixes:"
  echo "   • Run 'flutter doctor' to check setup"
  echo "   • Ensure you have enough free RAM (close other apps)"
  echo "   • Run 'flutter clean' and try again"
  exit 1
fi
