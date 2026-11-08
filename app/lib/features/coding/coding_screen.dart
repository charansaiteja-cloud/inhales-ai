import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
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
    final languages = ['Python', 'Java', 'JavaScript', 'Dart', 'C++', 'C', 'HTML/CSS', 'SQL'];
    return Scaffold(
      appBar: GlassAppBar(title: 'Coding Assistant'),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md, vertical: InhaleSpacing.sm),
          child: Wrap(spacing: 8, children: languages.map((lang) {
            final selected = lang.toLowerCase() == state.language;
            return GlassCard(
              onTap: () => notifier.setLanguage(lang.toLowerCase()),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(lang, style: TextStyle(color: selected ? Colors.white : InhaleColors.primaryBlue, fontWeight: selected ? FontWeight.w600 : FontWeight.w400, fontSize: 12)),
              backgroundColor: selected ? InhaleColors.primaryBlue : InhaleColors.glassSurface,
            );
          }).toList()),
        ),
        Expanded(child: Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: GlassCard(
            padding: EdgeInsets.all(InhaleSpacing.md),
            child: GlassTextField(maxLines: null, hintText: 'Write or paste your code here...', onChanged: (v) => notifier.setCode(v)),
          ),
        )),
        Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: Row(children: [
            Expanded(child: GlassButton(label: 'Ask AI to Explain', onTap: () => notifier.askAI(state.code))),
            const SizedBox(width: InhaleSpacing.sm),
            Expanded(child: GlassButton(label: 'Fix Bugs', onTap: () => notifier.askAI('Fix bugs: ${state.code}'))),
          ]),
        ),
      ]),
    );
  }
}
