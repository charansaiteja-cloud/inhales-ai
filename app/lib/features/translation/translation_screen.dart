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
    final languages = {'en': 'English', 'hi': 'Hindi', 'te': 'Telugu'};
    return Scaffold(
      appBar: GlassAppBar(title: 'Translation'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(InhaleSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: GlassCard(
                    padding: EdgeInsets.symmetric(vertical: InhaleSpacing.sm),
                    child: DropdownButton<String>(
                      value: state.sourceLang,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items:
                          languages.entries
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.key,
                                  child: Text(
                                    e.value,
                                    style: InhaleTypography.titleMedium,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.sm),
                  child: GlassIconButton(
                    onTap: () => notifier.swapLanguages(),
                    icon: Icons.swap_horiz_rounded,
                    color: InhaleColors.primaryBlue,
                  ),
                ),
                Expanded(
                  child: GlassCard(
                    padding: EdgeInsets.symmetric(vertical: InhaleSpacing.sm),
                    child: DropdownButton<String>(
                      value: state.targetLang,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items:
                          languages.entries
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.key,
                                  child: Text(
                                    e.value,
                                    style: InhaleTypography.titleMedium,
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
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
              child: GlassCard(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  maxLines: null,
                  hintText: 'Enter text to translate...',
                  onChanged: (v) => notifier.setInputText(v),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(InhaleSpacing.md),
            child: GlassButton(
              width: double.infinity,
              label: 'Translate',
              onTap:
                  state.inputText.isNotEmpty
                      ? () => notifier.translate(state.inputText)
                      : null,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
            child: GlassCard(
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: Text(
                state.translatedText.isNotEmpty
                    ? state.translatedText
                    : 'Translation will appear here.',
                style:
                    state.translatedText.isNotEmpty
                        ? InhaleTypography.bodyLarge
                        : InhaleTypography.bodyMedium.copyWith(
                          color: InhaleColors.secondaryText,
                        ),
              ),
            ),
          ),
          const SizedBox(height: InhaleSpacing.md),
        ],
      ),
    );
  }
}
