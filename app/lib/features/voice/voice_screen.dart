import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import 'voice_provider.dart';

class VoiceScreen extends ConsumerWidget {
  const VoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(voiceProvider);
    final notifier = ref.read(voiceProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(title: 'Voice AI'),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                  child: Text(
                    state.error!,
                    style: InhaleTypography.bodySmall.copyWith(
                      color: InhaleColors.error,
                    ),
                  ),
                ),
              Text(
                'Speech to Text',
                style: InhaleTypography.headlineMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.xs),
              Text(
                'Record your voice and transcribe to text',
                style: InhaleTypography.bodyMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.lg),
                elevated: state.isRecording,
                glow: state.isRecording,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(InhaleSpacing.md),
                      decoration: BoxDecoration(
                        color:
                            isDark
                                ? InhaleColors.glassSurface
                                : InhaleColors.lightGlassSurface,
                        borderRadius: BorderRadius.circular(InhaleRadius.md),
                        border: Border.all(
                          color:
                              isDark
                                  ? InhaleColors.glassBorderSubtle
                                  : InhaleColors.lightGlassBorderSubtle,
                        ),
                      ),
                      child: Text(
                        state.transcribedText.isEmpty
                            ? 'Tap the microphone to start speaking...'
                            : state.transcribedText,
                        style: InhaleTypography.bodyLarge.copyWith(
                          color:
                              state.transcribedText.isEmpty
                                  ? (isDark
                                      ? InhaleColors.textMuted
                                      : InhaleColors.lightTextMuted)
                                  : (isDark
                                      ? InhaleColors.textPrimary
                                      : InhaleColors.lightNavyText),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: InhaleSpacing.lg),
                    if (state.isRecording)
                      _StatusChip(
                        label: 'Recording...',
                        color: InhaleColors.error,
                        icon: Icons.mic_rounded,
                        isDark: isDark,
                      ),
                    const SizedBox(height: InhaleSpacing.lg),
                    GlassIconButton(
                      onTap:
                          state.isAvailable
                              ? () => notifier.toggleRecording()
                              : null,
                      icon:
                          state.isRecording
                              ? Icons.stop_rounded
                              : Icons.mic_rounded,
                      color:
                          state.isRecording
                              ? InhaleColors.error
                              : (isDark
                                  ? InhaleColors.electricBlue
                                  : InhaleColors.lightPrimaryBlue),
                      size: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: InhaleSpacing.xl),
              Text(
                'Text to Speech',
                style: InhaleTypography.headlineMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.xs),
              Text(
                'Convert text to natural speech',
                style: InhaleTypography.bodyMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.lg),
                elevated: state.isSpeaking,
                glow: state.isSpeaking,
                child: Column(
                  children: [
                    GlassTextField(
                      maxLines: 4,
                      minLines: 2,
                      hintText: 'Enter text to speak...',
                      onChanged: (v) => notifier.setText(v),
                    ),
                    const SizedBox(height: InhaleSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: GlassButton(
                            label: state.isSpeaking ? 'Speaking...' : 'Speak',
                            onTap:
                                state.isSpeaking
                                    ? null
                                    : () => notifier.speak(),
                            glow: !state.isSpeaking,
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
                            outlined: true,
                          ),
                        ),
                      ],
                    ),
                    if (state.isSpeaking) ...[
                      const SizedBox(height: InhaleSpacing.sm),
                      _StatusChip(
                        label: 'Speaking...',
                        color: InhaleColors.electricBlue,
                        icon: Icons.volume_up_rounded,
                        isDark: isDark,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final bool isDark;

  const _StatusChip({
    required this.label,
    required this.color,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(InhaleRadius.pill),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: InhaleTypography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
