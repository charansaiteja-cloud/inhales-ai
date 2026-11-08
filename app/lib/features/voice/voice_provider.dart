import 'package:flutter_riverpod/flutter_riverpod.dart';

class VoiceState {
  final bool isRecording;
  final String transcribedText;
  final bool isSpeaking;
  final String textToSpeak;

  const VoiceState({
    this.isRecording = false,
    this.transcribedText = '',
    this.isSpeaking = false,
    this.textToSpeak = '',
  });

  VoiceState copyWith({
    bool? isRecording,
    String? transcribedText,
    bool? isSpeaking,
    String? textToSpeak,
  }) => VoiceState(
        isRecording: isRecording ?? this.isRecording,
        transcribedText: transcribedText ?? this.transcribedText,
        isSpeaking: isSpeaking ?? this.isSpeaking,
        textToSpeak: textToSpeak ?? this.textToSpeak,
      );
}

final voiceProvider = StateNotifierProvider<VoiceNotifier, VoiceState>(
  (ref) => VoiceNotifier(),
);

class VoiceNotifier extends StateNotifier<VoiceState> {
  VoiceNotifier() : super(const VoiceState());

  void toggleRecording() {
    state = state.copyWith(isRecording: !state.isRecording);
    if (!state.isRecording) {
      state = state.copyWith(transcribedText: 'Transcribed text will appear here');
    }
  }

  void setText(String text) {
    state = state.copyWith(textToSpeak: text);
  }

  void speak() {
    if (state.textToSpeak.isEmpty) return;
    state = state.copyWith(isSpeaking: true);
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isSpeaking: false);
    });
  }

  void stopSpeaking() {
    state = state.copyWith(isSpeaking: false);
  }

  void executeCommand(String command) {
    // In full implementation: process voice command
  }
}
