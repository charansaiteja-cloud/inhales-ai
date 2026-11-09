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
import 'notes_provider.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notesProvider);
    final notifier = ref.read(notesProvider.notifier);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: GlassAppBar(
        title: 'Notes',
        actions: [
          GlassIconButton(
            onTap: () => notifier.toggleSearch(),
            icon: Icons.search_rounded,
            color:
                isDark
                    ? InhaleColors.electricBlue
                    : InhaleColors.lightPrimaryBlue,
          ),
          GlassIconButton(
            onTap: () => notifier.addNote(),
            icon: Icons.add_rounded,
            color:
                isDark
                    ? InhaleColors.electricBlue
                    : InhaleColors.lightPrimaryBlue,
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
            if (state.isSearching)
              Padding(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(
                  hintText: 'Search notes...',
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color:
                        isDark
                            ? InhaleColors.textMuted
                            : InhaleColors.lightTextMuted,
                  ),
                  onChanged: (v) => notifier.search(v),
                ),
              ),
            Expanded(
              child:
                  state.notes.isEmpty
                      ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(InhaleSpacing.xl),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: InhaleColors.gradientAccent,
                                  borderRadius: BorderRadius.circular(
                                    InhaleRadius.md,
                                  ),
                                ),
                                child: Icon(
                                  Icons.note_outlined,
                                  size: 48,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: InhaleSpacing.lg),
                              Text(
                                'No Notes Yet',
                                style: InhaleTypography.headlineSmall.copyWith(
                                  color:
                                      isDark
                                          ? InhaleColors.textPrimary
                                          : InhaleColors.lightNavyText,
                                ),
                              ),
                              const SizedBox(height: InhaleSpacing.sm),
                              Text(
                                'Create your first note to start organizing your thoughts.',
                                style: InhaleTypography.bodyMedium.copyWith(
                                  color:
                                      isDark
                                          ? InhaleColors.textSecondary
                                          : InhaleColors.lightTextSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: InhaleSpacing.lg),
                              GlassButton(
                                label: 'Create Note',
                                onTap: () => notifier.addNote(),
                                width: 200,
                              ),
                            ],
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(InhaleSpacing.md),
                        itemCount: state.notes.length,
                        itemBuilder: (context, index) {
                          final note = state.notes[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: InhaleSpacing.sm,
                            ),
                            child: GlassCard(
                              onTap: () => notifier.openNote(index),
                              padding: const EdgeInsets.all(InhaleSpacing.md),
                              elevated: true,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          note['title'] ?? 'Untitled',
                                          style: InhaleTypography.titleSmall
                                              .copyWith(
                                                color:
                                                    isDark
                                                        ? InhaleColors
                                                            .textPrimary
                                                        : InhaleColors
                                                            .lightNavyText,
                                              ),
                                        ),
                                      ),
                                      GlassIconButton(
                                        onTap: () => notifier.deleteNote(index),
                                        icon: Icons.delete_outline_rounded,
                                        color: InhaleColors.error,
                                        size: 36,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: InhaleSpacing.xs),
                                  Text(
                                    note['content'] ?? '',
                                    style: InhaleTypography.bodySmall.copyWith(
                                      color:
                                          isDark
                                              ? InhaleColors.textSecondary
                                              : InhaleColors.lightTextSecondary,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: InhaleSpacing.xs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isDark
                                                  ? InhaleColors.electricBlue
                                                      .withValues(alpha: 0.2)
                                                  : InhaleColors
                                                      .lightPrimaryBlue
                                                      .withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(
                                            InhaleRadius.xs,
                                          ),
                                        ),
                                        child: Text(
                                          '${note['wordCount'] ?? 0} words',
                                          style: InhaleTypography.labelSmall
                                              .copyWith(
                                                color:
                                                    isDark
                                                        ? InhaleColors
                                                            .electricBlue
                                                        : InhaleColors
                                                            .lightPrimaryBlue,
                                                fontSize: 10,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: GlassButton(
                width: double.infinity,
                label: 'New Note',
                onTap: () => notifier.addNote(),
                glow: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
