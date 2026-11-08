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
    return Scaffold(
      appBar: GlassAppBar(
        title: 'Notes',
        actions: [
          GlassIconButton(
            onTap: () => notifier.toggleSearch(),
            icon: Icon(Icons.search_rounded, color: InhaleColors.textPrimary),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: InhaleColors.gradientBackground),
        child: Column(
          children: [
            if (state.isSearching)
              Padding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: GlassTextField(hintText: 'Search notes...', onChanged: (v) => notifier.search(v)),
              ),
            Expanded(
              child: state.notes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.note_outlined, size: 64, color: InhaleColors.secondaryText),
                          const SizedBox(height: InhaleSpacing.md),
                          Text('No Notes Yet', style: InhaleTypography.titleMedium),
                          const SizedBox(height: InhaleSpacing.sm),
                          Text('Create a note to get started', style: InhaleTypography.bodyMedium.copyWith(color: InhaleColors.secondaryText)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(InhaleSpacing.md),
                      itemCount: state.notes.length,
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            onTap: () => notifier.openNote(index),
                            padding: EdgeInsets.all(InhaleSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(note['title'] ?? 'Untitled', style: InhaleTypography.titleSmall)),
                                    GlassIconButton(
                                      onTap: () => notifier.deleteNote(index),
                                      icon: Icon(Icons.delete_outline_rounded, color: InhaleColors.error, size: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(note['content'] ?? '', style: InhaleTypography.bodySmall.copyWith(color: InhaleColors.secondaryText), maxLines: 3, overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(InhaleSpacing.md),
              child: GlassButton(width: double.infinity, label: 'New Note', onTap: () => notifier.addNote()),
            ),
            const SizedBox(height: InhaleSpacing.md),
          ],
        ),
      ),
    );
  }
}
