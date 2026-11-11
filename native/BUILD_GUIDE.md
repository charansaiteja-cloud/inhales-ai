# Native Library Build Guide

Builds `libinhale_engine.so` from `native/inference/inhale_engine.cpp` + llama.cpp,
bundled into the Flutter Android app for real AI inference via FFI.

---

## Prerequisites

- CMake ≥ 3.16
- C/C++ compiler (GCC ≥ 9 or Clang)
- Android NDK r28+ (for Android builds)
- Internet access (llama.cpp is fetched from GitHub at build time)

---

## Build for Linux (desktop)

```bash
cd native
mkdir -p build-linux && cd build-linux
cmake .. -DUSE_LLAMA=ON -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=ON \
  -DLLAMA_CURL=OFF -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_EXAMPLES=OFF \
  -DLLAMA_BUILD_SERVER=OFF
cmake --build . -j$(nproc)
```

Output: `build-linux/libinference.so` (rename to `libinhale_engine.so` for FFI).

---

## Build for Android (arm64-v8a)

```bash
export NDK=$HOME/Android/Sdk/ndk/28.2.13676358
cd native
mkdir -p build-android-aarch64 && cd build-android-aarch64
cmake .. \
  -DUSE_LLAMA=ON -DCMAKE_BUILD_TYPE=Release -DGGML_NATIVE=OFF \
  -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
  -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-21 -DANDROID_NDK=$NDK \
  -DLLAMA_CURL=OFF -DLLAMA_BUILD_TESTS=OFF -DLLAMA_BUILD_EXAMPLES=OFF \
  -DLLAMA_BUILD_SERVER=OFF -DGGML_CURL=OFF -DGGML_BUILD_TESTS=OFF \
  -DGGML_BUILD_EXAMPLES=OFF
cmake --build . -j$(nproc)
```

Output: `build-android-aarch64/libinference.so`.

---

## Build for Android (armeabi-v7a)

Same as arm64 but with `-DANDROID_ABI=armeabi-v7a`.
The `ggml-cpu/llamafile/sgemm.cpp` is excluded on Android (NEON-incompatible).

---

## Build for Android (x86_64)

Same as arm64 but with `-DANDROID_ABI=x86_64`.

---

## Bundle into Flutter

```bash
mkdir -p app/android/app/src/main/jniLibs/{arm64-v8a,armeabi-v7a,x86_64}
cp build-android-aarch64/libinference.so app/android/app/src/main/jniLibs/arm64-v8a/libinhale_engine.so
cp build-android-armv7/libinference.so app/android/app/src/main/jniLibs/armeabi-v7a/libinhale_engine.so
cp build-android-x86_64/libinference.so app/android/app/src/main/jniLibs/x86_64/libinhale_engine.so
```

---

## Known Issues Fixed During Build

1. **`llama-mmap.h` missing `#include <cstdint>`** — added.
2. **`POSIX_MADV_WILLNEED` / `POSIX_MADV_RANDOM` undefined on Android** — guarded with `#if defined(__linux__) && !defined(__ANDROID__)`.
3. **llamafile NEON intrinsics (`vld1q_f16`) on ARMv7** — excluded `ggml-cpu/llamafile/sgemm.cpp` on Android via `GGML_LLAMAFILE AND NOT ANDROID` guard.

---

## Library Size

| ABI | Size |
|-----|------|
| arm64-v8a | 168 KB |
| armeabi-v7a | 128 KB |
| x86_64 | 162 KB |

Note: These are the engine wrappers only. Model weights (GGUF files) are loaded at runtime
and stored in the app's documents directory.