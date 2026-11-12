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
import 'translation_provider.dart';

class TranslationScreen extends ConsumerWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(translationProvider);
    final notifier = ref.read(translationProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final languages = {'en': 'English', 'hi': 'Hindi', 'te': 'Telugu'};

    return Scaffold(
      appBar: GlassAppBar(title: 'Translation'),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? InhaleColors.gradientBackgroundDark
              : InhaleColors.gradientBackground,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            children: [
              // Language Selector
              Row(
                children: [
                  Expanded(
                    child: GlassCard(
                      padding: EdgeInsets.zero,
                      child: DropdownButton<String>(
                        value: state.sourceLang,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        style: InhaleTypography.titleMedium.copyWith(
                          color: isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                        ),
                        dropdownColor: isDark
                            ? InhaleColors.glassSurface
                            : InhaleColors.lightGlassSurface,
                        items: languages.entries
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.key,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: InhaleSpacing.sm,
                                    horizontal: InhaleSpacing.md,
                                  ),
                                  child: Text(e.value),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            notifier.setLanguages(v, state.targetLang);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  GlassIconButton(
                    onTap: () => notifier.swapLanguages(),
                    icon: Icons.swap_horiz_rounded,
                    color: isDark
                        ? InhaleColors.electricBlue
                        : InhaleColors.lightPrimaryBlue,
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: GlassCard(
                      padding: EdgeInsets.zero,
                      child: DropdownButton<String>(
                        value: state.targetLang,
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        style: InhaleTypography.titleMedium.copyWith(
                          color: isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                        ),
                        dropdownColor: isDark
                            ? InhaleColors.glassSurface
                            : InhaleColors.lightGlassSurface,
                        items: languages.entries
                            .map(
                              (e) => DropdownMenuItem(
                                value: e.key,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: InhaleSpacing.sm,
                                    horizontal: InhaleSpacing.md,
                                  ),
                                  child: Text(e.value),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            notifier.setLanguages(state.sourceLang, v);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InhaleSpacing.lg),

              // Source Text Input
              Text(
                'Source Text',
                style: InhaleTypography.titleMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  maxLines: 8,
                  minLines: 4,
                  hintText: 'Enter text to translate...',
                  onChanged: (v) => notifier.setInputText(v),
                ),
              ),
              const SizedBox(height: InhaleSpacing.lg),

              // Translate Button
              GlassButton(
                width: double.infinity,
                label: state.isTranslating ? 'Translating...' : 'Translate',
                onTap: state.inputText.isNotEmpty
                    ? () => notifier.translate(state.inputText)
                    : null,
                glow: state.inputText.isNotEmpty,
              ),
              const SizedBox(height: InhaleSpacing.lg),

              // Translation Result
              Text(
                'Translation',
                style: InhaleTypography.titleMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                elevated: state.translatedText.isNotEmpty,
                child: Text(
                  state.translatedText.isNotEmpty
                      ? state.translatedText
                      : 'Translation will appear here.',
                  style: state.translatedText.isNotEmpty
                      ? InhaleTypography.bodyLarge.copyWith(
                          color: isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                        )
                      : InhaleTypography.bodyMedium.copyWith(
                          color: isDark
                              ? InhaleColors.textMuted
                              : InhaleColors.lightTextMuted,
                        ),
                ),
              ),

              // History
              if (state.history.isNotEmpty) ...[
                const SizedBox(height: InhaleSpacing.xl),
                Text(
                  'History',
                  style: InhaleTypography.titleMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.sm),
                  child: Column(
                    children: state.history.take(5).map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: InhaleSpacing.xs,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? InhaleColors.electricBlue
                                        .withValues(alpha: 0.15)
                                    : InhaleColors.lightPrimaryBlue
                                        .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                  InhaleRadius.sm,
                                ),
                              ),
                              child: Icon(
                                Icons.translate_rounded,
                                size: 16,
                                color: isDark
                                    ? InhaleColors.electricBlue
                                    : InhaleColors.lightPrimaryBlue,
                              ),
                            ),
                            const SizedBox(width: InhaleSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.source,
                                    style: InhaleTypography.bodySmall.copyWith(
                                      color: isDark
                                          ? InhaleColors.textSecondary
                                          : InhaleColors.lightTextSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    entry.translated,
                                    style: InhaleTypography.bodySmall.copyWith(
                                      color: isDark
                                          ? InhaleColors.textPrimary
                                          : InhaleColors.lightNavyText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${entry.sourceLang} → ${entry.targetLang}',
                              style: InhaleTypography.labelSmall.copyWith(
                                color: isDark
                                    ? InhaleColors.textMuted
                                    : InhaleColors.lightTextMuted,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
