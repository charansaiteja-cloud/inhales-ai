import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// FFI type definitions for the native Inhale inference engine.
/// These mirror the C API exposed by `native/inference/inhale_engine.cpp`.

typedef InhaleInitNative = Void Function();
typedef InhaleInit = void Function();

typedef InhaleLoadModelNative = Void Function(
    Pointer<Utf8> modelPath, Pointer<Utf8> threads, Pointer<Utf8> layers);
typedef InhaleLoadModel = void Function(
    Pointer<Utf8> modelPath, Pointer<Utf8> threads, Pointer<Utf8> layers);

typedef InhaleUnloadModelNative = Void Function();
typedef InhaleUnloadModel = void Function();

typedef InhaleIsLoadedNative = Bool Function();
typedef InhaleIsLoaded = bool Function();

typedef InhaleGetMemoryMbNative = Uint32 Function();
typedef InhaleGetMemoryMb = int Function();

typedef InhaleGenerateNative = Pointer<Utf8> Function(
    Pointer<Utf8> prompt, Pointer<Utf8> callback);
typedef InhaleGenerate = Pointer<Utf8> Function(
    Pointer<Utf8> prompt, Pointer<Utf8> callback);

typedef InhaleCancelNative = Void Function();
typedef InhaleCancel = void Function();

/// Native function pointers — resolved at runtime from the bundled shared library.
class InhaleFFI {
  InhaleFFI(this._dylib);

  final DynamicLibrary _dylib;

  late final InhaleInit inhale_init = _dylib
      .lookupFunction<InhaleInitNative, InhaleInit>('inhale_init');
  late final InhaleLoadModel inhale_load_model = _dylib
      .lookupFunction<InhaleLoadModelNative, InhaleLoadModel>('inhale_load_model');
  late final InhaleUnloadModel inhale_unload_model = _dylib
      .lookupFunction<InhaleUnloadModelNative, InhaleUnloadModel>('inhale_unload_model');
  late final InhaleIsLoaded inhale_is_loaded = _dylib
      .lookupFunction<InhaleIsLoadedNative, InhaleIsLoaded>('inhale_is_loaded');
  late final InhaleGetMemoryMb inhale_get_memory_mb = _dylib
      .lookupFunction<InhaleGetMemoryMbNative, InhaleGetMemoryMb>('inhale_get_memory_mb');
  late final InhaleGenerate inhale_generate = _dylib
      .lookupFunction<InhaleGenerateNative, InhaleGenerate>('inhale_generate');
  late final InhaleCancel inhale_cancel = _dylib
      .lookupFunction<InhaleCancelNative, InhaleCancel>('inhale_cancel');
}