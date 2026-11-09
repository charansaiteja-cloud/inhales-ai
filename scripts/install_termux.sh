#!/usr/bin/env bash
set -euo pipefail

# InhaleSkill AI — Termux installer
# Installs Flutter and builds the Android APK from source.
# Note: Pre-built APKs from GitHub Actions are recommended.

REPO_URL="https://github.com/charansaiteja-cloud/inhales-ai.git"
REPO_DIR="$HOME/inhales-ai"
FLUTTER_DIR="$HOME/flutter"

echo "=== InhaleSkill AI Termux installer ==="

# Validate Termux environment
if [ -z "${TERMUX_VERSION:-}" ]; then
  echo "This script should be run inside Termux on Android." >&2
  exit 1
fi

# Check available storage (need 1.5 GB+ for Flutter SDK + build)
AVAILABLE=$(df -m "$HOME" | awk 'NR==2 {print $4}')
echo "Available storage: ${AVAILABLE} MB"

if [ "$AVAILABLE" -lt 1500 ]; then
  echo "ERROR: Insufficient storage. Need at least 1500 MB for Flutter SDK + build." >&2
  exit 1
fi

# Install prerequisites
echo "Installing prerequisites..."
pkg update -y
pkg install -y git clang cmake ninja libstdc++ || true

# Install Flutter if not present
if [ ! -d "$FLUTTER_DIR/.git" ]; then
  echo "Cloning Flutter SDK (~300 MB)..."
  git clone --depth 1 https://github.com/flutter/flutter.git -b stable "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
export PUB_CACHE="$HOME/.pub-cache"

# Accept licenses and cache artifacts
flutter --version >/dev/null 2>&1 || true

# Clone or update repository
if [ ! -d "$REPO_DIR" ]; then
  echo "Cloning repository..."
  git clone --depth 1 "$REPO_URL" "$REPO_DIR"
else
  echo "Repository exists at $REPO_DIR"
fi

# Build
cd "$REPO_DIR/app"
echo "Running flutter pub get..."
flutter pub get

echo "Building Android debug APK..."
flutter build apk --debug 2>&1 | tail -5

APK_PATH="build/app/outputs/flutter-apk/app-debug.apk"

if [ -f "$APK_PATH" ]; then
  APK_SIZE=$(du -h "$APK_PATH" | cut -f1)
  echo ""
  echo "=== Build successful ==="
  echo "APK: $APK_PATH ($APK_SIZE)"
  echo ""
  echo "To install:"
  echo "  pm install -r $REPO_DIR/$APK_PATH"
else
  echo ""
  echo "=== Build failed ==="
  echo "Check the output above for errors."
  exit 1
fi
