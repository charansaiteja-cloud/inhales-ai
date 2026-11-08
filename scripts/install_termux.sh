#!/usr/bin/env bash
set -euo pipefail

# InhaleSkill AI — Termux installer
# Repository: https://github.com/charansaiteja-cloud/inhales-ai.git
REPO_URL="https://github.com/charansaiteja-cloud/inhales-ai.git"
REPO_DIR="$HOME/inhales-ai"

echo "=== InhaleSkill AI Termux installer ==="

# Validate Termux
if [ ! -d "$HOME" ] || [ -z "${TERMUX_VERSION:-}" ]; then
  echo "This script should be run inside Termux on Android." >&2
  exit 1
fi

# Check available storage
AVAILABLE=$(df -m "$HOME" | awk 'NR==2 {print $4}')
echo "Available storage: ${AVAILABLE} MB"

if [ "$AVAILABLE" -lt 500 ]; then
  echo "ERROR: Insufficient storage. Need at least 500 MB." >&2
  exit 1
fi

# Install prerequisites
echo "Installing prerequisites..."
pkg install -y git clang cmake ninja libstdc++ libpng-dev libjpeg-dev protobuf-dev android-tools || true

# Install Flutter if not present
if [ ! -d "$HOME/flutter" ]; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"
fi
export PATH="$HOME/flutter/bin:$PATH"

echo "Flutter version:"
flutter --version | head -1

# Clone or update repository
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning repository..."
  git clone "$REPO_URL" "$REPO_DIR"
else
  echo "Updating repository..."
  cd "$REPO_DIR"
  git fetch --all
  git reset --hard origin/main
fi

# Build
cd "$REPO_DIR/app"
echo "Running flutter pub get..."
flutter pub get

echo "Building Android APK..."
flutter build apk --debug

# Sideload if device connected
DEVICE=$(adb devices 2>/dev/null | awk 'NR>1{print $1}' | grep -v "unauthorized" | head -1 || true)
if [ -n "$DEVICE" ]; then
  echo "Sideloading APK to $DEVICE..."
  adb -s "$DEVICE" install -r build/app/outputs/flutter-apk/app-debug.apk
else
  echo "No Android device connected via ADB."
  echo "APK location: build/app/outputs/flutter-apk/app-debug.apk"
fi

echo "=== Installation complete ==="
echo "Run the app from your Android launcher or use:"
echo "  cd $REPO_DIR/app && flutter run -d <device>"