import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/glass_app_bar.dart';
import 'voice_provider.dart';

class VoiceScreen extends ConsumerWidget {
  const VoiceScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceProvider);
    final notifier = ref.read(voiceProvider.notifier);
    return Scaffold(
      appBar: GlassAppBar(title: 'Voice'),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Speech to Text', style: InhaleTypography.headlineMedium),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          state.transcribedText.isEmpty
                              ? Text(
                                'Tap the microphone to start speaking...',
                                style: InhaleTypography.bodyMedium.copyWith(
                                  color: InhaleColors.secondaryText,
                                ),
                              )
                              : Text(
                                state.transcribedText,
                                style: InhaleTypography.bodyLarge,
                              ),
                    ),
                    GlassIconButton(
                      onTap: () => notifier.toggleRecording(),
                      icon: Icon(
                        state.isRecording
                            ? Icons.mic_rounded
                            : Icons.mic_none_rounded,
                        color:
                            state.isRecording
                                ? InhaleColors.error
                                : InhaleColors.primaryBlue,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.isRecording) ...[
                const SizedBox(height: InhaleSpacing.sm),
                Center(
                  child: Text(
                    'Recording...',
                    style: TextStyle(
                      color: InhaleColors.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: InhaleSpacing.xl),
              Text('Text to Speech', style: InhaleTypography.headlineMedium),
              const SizedBox(height: InhaleSpacing.sm),
              GlassTextField(
                maxLines: 3,
                hintText: 'Enter text to speak...',
                onChanged: (v) => notifier.setText(v),
              ),
              const SizedBox(height: InhaleSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: GlassButton(
                      label: 'Speak',
                      onTap: () => notifier.speak(),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: GlassButton(
                      label: 'Stop',
                      onTap:
                          state.isSpeaking
                              ? () => notifier.stopSpeaking()
                              : null,
                    ),
                  ),
                ],
              ),
              if (state.isSpeaking) ...[
                const SizedBox(height: InhaleSpacing.sm),
                Center(
                  child: Text(
                    'Speaking...',
                    style: TextStyle(
                      color: InhaleColors.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: InhaleSpacing.xl),
              Text('Voice Commands', style: InhaleTypography.headlineMedium),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quick Actions', style: InhaleTypography.titleSmall),
                    const SizedBox(height: InhaleSpacing.sm),
                    _voiceCommandRow(
                      'Summarize this page',
                      () => notifier.executeCommand('summarize'),
                      context,
                    ),
                    _voiceCommandRow(
                      'Read this aloud',
                      () => notifier.executeCommand('read_aloud'),
                      context,
                    ),
                    _voiceCommandRow(
                      'Search the web',
                      () => notifier.executeCommand('search'),
                      context,
                    ),
                    _voiceCommandRow(
                      'Create a note',
                      () => notifier.executeCommand('create_note'),
                      context,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _voiceCommandRow(
    String label,
    VoidCallback onTap,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: InhaleTypography.bodyMedium)),
          Icon(
            Icons.play_circle_outline_rounded,
            color: InhaleColors.primaryBlue,
            size: 20,
          ),
        ],
      ),
    );
  }
}
