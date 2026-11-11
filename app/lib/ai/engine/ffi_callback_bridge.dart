/// Bridges native FFI callbacks to a Dart stream.
/// Uses static functions so Pointer.fromFunction works.
library;

import 'dart:async';
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import 'ffi_bindings.dart';

/// Bridges native C callbacks to a Dart stream.
class CallbackBridge {
  static CallbackBridge? _active;

  final List<String> _tokens = [];
  final Completer<void> _done = Completer<void>();
  String? _error;

  /// Add a token from the callback.
  static void _addToken(Pointer<Utf8> ptr) {
    _active?._tokens.add(ptr.toDartString());
  }

  /// Signal generation complete.
  static void _signalDone() {
    if (_active != null && !_active!._done.isCompleted) {
      _active!._done.complete();
    }
  }

  /// Signal error from the callback.
  static void _addError(Pointer<Utf8> ptr) {
    if (_active != null && !_active!._done.isCompleted) {
      _active!._error = ptr.toDartString();
      _active!._done.complete();
    }
  }

  late final Pointer<NativeFunction<TokenCallbackNative>> tokenPtr;
  late final Pointer<NativeFunction<DoneCallbackNative>> donePtr;
  late final Pointer<NativeFunction<ErrorCallbackNative>> errorPtr;

  CallbackBridge() {
    _active = this;
    tokenPtr = Pointer.fromFunction<TokenCallbackNative>(_addToken);
    donePtr = Pointer.fromFunction<DoneCallbackNative>(_signalDone);
    errorPtr = Pointer.fromFunction<ErrorCallbackNative>(_addError);
  }

  void dispose() {
    if (_active == this) _active = null;
    if (!_done.isCompleted) _done.complete();
  }

  /// Wait for generation to complete, then stream collected tokens.
  Future<void> waitForDone() async {
    await _done.future;
  }

  /// Stream the collected tokens.
  Stream<String> tokenStream() async* {
    for (final token in _tokens) {
      yield token;
    }
  }

  String? get error => _error;
}
