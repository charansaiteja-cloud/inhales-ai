import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import 'coding_provider.dart';

class CodingScreen extends ConsumerWidget {
  const CodingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(codingProvider);
    final notifier = ref.read(codingProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final languages = [
      'Python',
      'Java',
      'JavaScript',
      'Dart',
      'C++',
      'C',
      'HTML/CSS',
      'SQL',
    ];

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Coding Assistant',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: InhaleSpacing.md),
            child: GlassButton(
              label: state.language.toUpperCase(),
              onTap: null,
              outlined: true,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: Column(
          children: [
            // Language selector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: InhaleSpacing.md,
                vertical: InhaleSpacing.sm,
              ),
              child: Wrap(
                spacing: InhaleSpacing.sm,
                runSpacing: InhaleSpacing.sm,
                children:
                    languages.map((lang) {
                      final selected = lang.toLowerCase() == state.language;
                      return GlassCard(
                        onTap: () => notifier.setLanguage(lang.toLowerCase()),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevated: selected,
                        glow: selected,
                        child: Text(
                          lang,
                          style: TextStyle(
                            color:
                                selected
                                    ? Colors.white
                                    : (isDark
                                        ? InhaleColors.electricBlue
                                        : InhaleColors.lightPrimaryBlue),
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            // Code editor area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  elevated: true,
                  child: GlassTextField(
                    maxLines: null,
                    minLines: 20,
                    hintText: 'Write or paste your code here...',
                    onChanged: (v) => notifier.setCode(v),
                  ),
                ),
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: GlassButton(
                      label: 'Ask AI to Explain',
                      onTap:
                          state.code.isNotEmpty
                              ? () => notifier.askAI(state.code)
                              : null,
                      glow: true,
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: GlassButton(
                      label: 'Fix Bugs',
                      onTap:
                          state.code.isNotEmpty
                              ? () => notifier.askAI('Fix bugs: ${state.code}')
                              : null,
                      outlined: true,
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: GlassButton(
                      label: 'Optimize',
                      onTap:
                          state.code.isNotEmpty
                              ? () => notifier.askAI('Optimize: ${state.code}')
                              : null,
                      outlined: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
