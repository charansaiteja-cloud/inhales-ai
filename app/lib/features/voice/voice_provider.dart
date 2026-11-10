// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceState {
  final bool isRecording;
  final String transcribedText;
  final bool isSpeaking;
  final String textToSpeak;
  final bool isAvailable;
  final String? error;

  const VoiceState({
    this.isRecording = false,
    this.transcribedText = '',
    this.isSpeaking = false,
    this.textToSpeak = '',
    this.isAvailable = false,
    this.error,
  });

  VoiceState copyWith({
    bool? isRecording,
    String? transcribedText,
    bool? isSpeaking,
    String? textToSpeak,
    bool? isAvailable,
    String? error,
  }) => VoiceState(
    isRecording: isRecording ?? this.isRecording,
    transcribedText: transcribedText ?? this.transcribedText,
    isSpeaking: isSpeaking ?? this.isSpeaking,
    textToSpeak: textToSpeak ?? this.textToSpeak,
    isAvailable: isAvailable ?? this.isAvailable,
    error: error ?? this.error,
  );
}

final voiceProvider = StateNotifierProvider<VoiceNotifier, VoiceState>((ref) {
  return VoiceNotifier();
});

class VoiceNotifier extends StateNotifier<VoiceState> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  VoiceNotifier() : super(const VoiceState()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final available = await _speech.initialize(
        onError: (error) => state = state.copyWith(error: 'STT Error: $error'),
        onStatus: (status) {
          if (status == 'done' || status == 'notAvailable') {
            state = state.copyWith(isRecording: false);
          }
        },
      );
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.5);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
      state = state.copyWith(isAvailable: available);
      _initialized = true;
    } catch (e) {
      state = VoiceState(error: 'Init failed: $e', isAvailable: false);
    }
  }

  void toggleRecording() {
    if (!_initialized) return;

    if (state.isRecording) {
      _speech.stop();
      state = state.copyWith(isRecording: false);
    } else {
      state = state.copyWith(isRecording: true, transcribedText: '');
      _speech.listen(
        onResult: (result) {
          state = state.copyWith(transcribedText: result.recognizedWords);
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  void setText(String text) {
    state = state.copyWith(textToSpeak: text);
  }

  Future<void> speak() async {
    if (state.textToSpeak.isEmpty || !state.isAvailable) return;

    state = state.copyWith(isSpeaking: true);
    final result = await _tts.speak(state.textToSpeak);
    if (result == 1) {
      // Speaking started
      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(isSpeaking: false);
      });
    } else {
      state = state.copyWith(isSpeaking: false);
    }
  }

  Future<void> stopSpeaking() async {
    await _tts.stop();
    state = state.copyWith(isSpeaking: false);
  }

  void executeCommand(String command) {
    // In full implementation: process voice command via AIEngine
  }

  @override
  Future<void> dispose() async {
    await _tts.stop();
    super.dispose();
  }
}
