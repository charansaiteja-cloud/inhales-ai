// ignore_for_file: non_constant_identifier_names
// These variable names match native C function symbols in inhale_engine.cpp
import 'dart:ffi';
import 'package:ffi/ffi.dart';

/// FFI type definitions matching native/inference/inhale_engine.cpp.

typedef InhaleInitNative = Int32 Function();
typedef InhaleInit = int Function();

typedef InhaleLoadModelNative =
    Int32 Function(
      Pointer<Utf8> modelPath,
      Int32 ctx,
      Int32 threads,
      Int32 gpu,
    );
typedef InhaleLoadModel =
    int Function(Pointer<Utf8> modelPath, int ctx, int threads, int gpu);

typedef InhaleUnloadModelNative = Void Function();
typedef InhaleUnloadModel = void Function();

typedef InhaleIsLoadedNative = Int32 Function();
typedef InhaleIsLoaded = int Function();

typedef InhaleGetMemoryMbNative = Int32 Function();
typedef InhaleGetMemoryMb = int Function();

typedef InhaleSetContextNative = Void Function(Int32 ctx);
typedef InhaleSetContext = void Function(int ctx);

typedef InhaleGetContextNative = Int32 Function();
typedef InhaleGetContext = int Function();

typedef InhaleCancelNative = Void Function();
typedef InhaleCancel = void Function();

/// Simplified generate: no callbacks, returns int status.
typedef InhaleGenerateNative =
    Int32 Function(
      Pointer<Utf8> prompt,
      Int32 maxTokens,
      Float temp,
      Float topP,
      Int32 topK,
      Pointer<Void>,
      Pointer<Void>,
      Pointer<Void>,
      Int32 cancel,
    );
typedef InhaleGenerate =
    int Function(
      Pointer<Utf8> prompt,
      int maxTokens,
      double temp,
      double topP,
      int topK,
      Pointer<Void>,
      Pointer<Void>,
      Pointer<Void>,
      int cancel,
    );

class InhaleFFI {
  InhaleFFI(this._dylib);

  final DynamicLibrary _dylib;

  late final InhaleInit inhale_init = _dylib
      .lookupFunction<InhaleInitNative, InhaleInit>('inhale_init');
  late final InhaleLoadModel inhale_load_model = _dylib
      .lookupFunction<InhaleLoadModelNative, InhaleLoadModel>(
        'inhale_load_model',
      );
  late final InhaleUnloadModel inhale_unload_model = _dylib
      .lookupFunction<InhaleUnloadModelNative, InhaleUnloadModel>(
        'inhale_unload_model',
      );
  late final InhaleIsLoaded inhale_is_loaded = _dylib
      .lookupFunction<InhaleIsLoadedNative, InhaleIsLoaded>('inhale_is_loaded');
  late final InhaleGetMemoryMb inhale_get_memory_mb = _dylib
      .lookupFunction<InhaleGetMemoryMbNative, InhaleGetMemoryMb>(
        'inhale_get_memory_mb',
      );
  late final InhaleSetContext inhale_set_context = _dylib
      .lookupFunction<InhaleSetContextNative, InhaleSetContext>(
        'inhale_set_context',
      );
  late final InhaleGetContext inhale_get_context = _dylib
      .lookupFunction<InhaleGetContextNative, InhaleGetContext>(
        'inhale_get_context',
      );
  late final InhaleCancel inhale_cancel = _dylib
      .lookupFunction<InhaleCancelNative, InhaleCancel>('inhale_cancel');
  late final InhaleGenerate inhale_generate = _dylib
      .lookupFunction<InhaleGenerateNative, InhaleGenerate>('inhale_generate');
}
