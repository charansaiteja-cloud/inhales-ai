/// AI Notes Screen - View, create, edit, and generate AI-powered notes.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../di/di.dart';
import '../../database/database.dart' as db;
import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_app_bar.dart';
import '../../widgets/glass_icon_button.dart';
import '../../widgets/glass_bottom_sheet.dart';
import '../../widgets/glass_dialog.dart';
import 'ai_notes_provider.dart';

/// AI Notes screen - handles both list view and edit view.
class AINotesScreen extends ConsumerStatefulWidget {
  final int? noteId;

  const AINotesScreen({super.key, this.noteId});

  @override
  ConsumerState<AINotesScreen> createState() => _AINotesScreenState();
}

class _AINotesScreenState extends ConsumerState<AINotesScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _folderController = TextEditingController();
  final _subjectController = TextEditingController();
  final _classLevelController = TextEditingController();
  final _tagsController = TextEditingController();
  final _topicController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    ref.read(aiNotesProvider.notifier).loadNotes();

    if (widget.noteId != null) {
      _isEditing = true;
      _loadNoteForEditing();
    }
  }

  Future<void> _loadNoteForEditing() async {
    final note = await ref
        .read(aiNotesProvider.notifier)
        .loadNote(widget.noteId!);
    if (note != null && mounted) {
      _titleController.text = note.title;
      _contentController.text = note.content;
      _folderController.text = note.folder ?? '';
      _subjectController.text = note.subject ?? '';
      _classLevelController.text = note.classLevel ?? '';
      _tagsController.text = note.tags.join(', ');
      ref.read(aiNotesProvider.notifier).setCurrentNote(note);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _folderController.dispose();
    _subjectController.dispose();
    _classLevelController.dispose();
    _tagsController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiNotesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isEditing && widget.noteId != null) {
      return _buildEditView(state, isDark);
    }

    return _buildListView(state, isDark);
  }

  Widget _buildListView(AINotesState state, bool isDark) {
    return Scaffold(
      appBar: GlassAppBar(
        title: 'AI Notes',
        actions: [
          GlassIconButton(
            onTap: () => _showFilterOptions(),
            icon: Icons.filter_list_rounded,
            color:
                isDark
                    ? InhaleColors.electricBlue
                    : InhaleColors.lightPrimaryBlue,
          ),
          GlassIconButton(
            onTap: () => ref.read(aiNotesProvider.notifier).toggleSearch(),
            icon: Icons.search_rounded,
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
                  onChanged:
                      (v) => ref.read(aiNotesProvider.notifier).search(v),
                  onSubmitted: (_) {},
                ),
              ),
            if (state.selectedFolder != null || state.selectedTag != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: InhaleSpacing.md,
                  vertical: InhaleSpacing.sm,
                ),
                child: Row(
                  children: [
                    if (state.selectedFolder != null)
                      _FilterChip(
                        label: '📁 ${state.selectedFolder}',
                        onRemove:
                            () => ref
                                .read(aiNotesProvider.notifier)
                                .filterByFolder(null),
                      ),
                    if (state.selectedTag != null)
                      _FilterChip(
                        label: '🏷️ ${state.selectedTag}',
                        onRemove:
                            () => ref
                                .read(aiNotesProvider.notifier)
                                .filterByTag(null),
                      ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        ref.read(aiNotesProvider.notifier).filterByFolder(null);
                        ref.read(aiNotesProvider.notifier).filterByTag(null);
                      },
                      child: const Text('Clear filters'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child:
                  state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : state.notes.isEmpty
                      ? _buildEmptyState(isDark)
                      : _buildNotesList(state, isDark),
            ),
            Padding(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: GlassButton(
                width: double.infinity,
                label: 'New AI Note',
                onTap: () => _showCreateNoteOptions(),
                glow: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
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
                borderRadius: BorderRadius.circular(InhaleRadius.md),
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 48,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: InhaleSpacing.lg),
            Text(
              'Generate Your First AI Note',
              style: InhaleTypography.headlineSmall.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Text(
              'Create notes from topics, documents, or video transcripts using AI.',
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
              onTap: () => _showCreateNoteOptions(),
              width: 200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesList(AINotesState state, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      itemCount: state.notes.length,
      itemBuilder: (context, index) {
        final note = state.notes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
          child: GlassCard(
            onTap: () => _openNoteForEditing(note),
            padding: const EdgeInsets.all(InhaleSpacing.md),
            elevated: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (note.isPinned)
                            Padding(
                              padding: const EdgeInsets.only(
                                right: InhaleSpacing.xs,
                              ),
                              child: Icon(
                                Icons.push_pin_rounded,
                                size: 16,
                                color: InhaleColors.pink,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              note.title,
                              style: InhaleTypography.titleSmall.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textPrimary
                                        : InhaleColors.lightNavyText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GlassIconButton(
                          onTap:
                              () => ref
                                  .read(aiNotesProvider.notifier)
                                  .togglePin(note.id),
                          icon:
                              note.isPinned
                                  ? Icons.push_pin_rounded
                                  : Icons.push_pin_outlined,
                          color:
                              note.isPinned
                                  ? InhaleColors.pink
                                  : InhaleColors.textMuted,
                          size: 36,
                        ),
                        const SizedBox(width: InhaleSpacing.xs),
                        GlassIconButton(
                          onTap: () => _confirmDeleteNote(note),
                          icon: Icons.delete_outline_rounded,
                          color: InhaleColors.error,
                          size: 36,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: InhaleSpacing.xs),
                Text(
                  note.content,
                  style: InhaleTypography.bodySmall.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textSecondary
                            : InhaleColors.lightTextSecondary,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (note.tags.isNotEmpty) ...[
                  const SizedBox(height: InhaleSpacing.xs),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children:
                        note.tags.take(5).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isDark
                                      ? InhaleColors.electricBlue.withValues(
                                        alpha: 0.2,
                                      )
                                      : InhaleColors.lightPrimaryBlue
                                          .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                InhaleRadius.xs,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: InhaleTypography.labelSmall.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.electricBlue
                                        : InhaleColors.lightPrimaryBlue,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
                const SizedBox(height: InhaleSpacing.xs),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.format_size_rounded,
                      label: '${note.wordCount} words',
                      isDark: isDark,
                    ),
                    if (note.folder != null && note.folder!.isNotEmpty) ...[
                      const SizedBox(width: InhaleSpacing.xs),
                      _InfoChip(
                        icon: Icons.folder_rounded,
                        label: note.folder!,
                        isDark: isDark,
                      ),
                    ],
                    if (note.subject != null && note.subject!.isNotEmpty) ...[
                      const SizedBox(width: InhaleSpacing.xs),
                      _InfoChip(
                        icon: Icons.school_rounded,
                        label: note.subject!,
                        isDark: isDark,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditView(AINotesState state, bool isDark) {
    final currentNote = state.currentNote;

    return Scaffold(
      appBar: GlassAppBar(
        title: currentNote == null ? 'New Note' : 'Edit Note',
        actions: [
          GlassIconButton(
            onTap: () => _saveNote(),
            icon: Icons.save_rounded,
            color: isDark ? InhaleColors.success : InhaleColors.success,
            size: 40,
          ),
          GlassIconButton(
            onTap: () => Navigator.of(context).pop(),
            icon: Icons.close_rounded,
            color:
                isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted,
            size: 40,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(InhaleSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlassTextField(
                hintText: 'Note Title',
                controller: _titleController,
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassTextField(
                hintText: 'Content (Markdown supported)',
                controller: _contentController,
                maxLines: 15,
                minLines: 10,
              ),
              const SizedBox(height: InhaleSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: GlassTextField(
                      hintText: 'Folder',
                      controller: _folderController,
                      prefixIcon: const Icon(Icons.folder_outlined),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: GlassTextField(
                      hintText: 'Subject',
                      controller: _subjectController,
                      prefixIcon: const Icon(Icons.school_outlined),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassTextField(
                hintText: 'Class/Level (e.g., Grade 10, College)',
                controller: _classLevelController,
                prefixIcon: const Icon(Icons.class_outlined),
              ),
              const SizedBox(height: InhaleSpacing.md),
              GlassTextField(
                hintText: 'Tags (comma-separated)',
                controller: _tagsController,
                prefixIcon: const Icon(Icons.label_outlined),
              ),
              const SizedBox(height: InhaleSpacing.lg),
              if (currentNote != null) ...[
                GlassButton(
                  label: 'Delete Note',
                  onTap: () => _confirmDeleteNote(currentNote),
                  outlined: true,
                  width: double.infinity,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _openNoteForEditing(Note note) {
    ref.read(aiNotesProvider.notifier).setCurrentNote(note);
    _titleController.text = note.title;
    _contentController.text = note.content;
    _folderController.text = note.folder ?? '';
    _subjectController.text = note.subject ?? '';
    _classLevelController.text = note.classLevel ?? '';
    _tagsController.text = note.tags.join(', ');
    setState(() {
      _isEditing = true;
    });
  }

  Future<void> _saveNote() async {
    final currentNote = ref.read(aiNotesProvider).currentNote;
    final tags =
        _tagsController.text
            .split(',')
            .map((t) => t.trim())
            .where((t) => t.isNotEmpty)
            .toList();

    if (currentNote != null) {
      await ref
          .read(aiNotesProvider.notifier)
          .updateNote(
            id: currentNote.id,
            title: _titleController.text,
            content: _contentController.text,
            folder:
                _folderController.text.isEmpty ? null : _folderController.text,
            subject:
                _subjectController.text.isEmpty
                    ? null
                    : _subjectController.text,
            classLevel:
                _classLevelController.text.isEmpty
                    ? null
                    : _classLevelController.text,
            tags: tags,
          );
    } else {
      await ref
          .read(aiNotesProvider.notifier)
          .createNote(
            title:
                _titleController.text.isEmpty
                    ? 'Untitled Note'
                    : _titleController.text,
            content: _contentController.text,
            folder:
                _folderController.text.isEmpty ? null : _folderController.text,
            subject:
                _subjectController.text.isEmpty
                    ? null
                    : _subjectController.text,
            classLevel:
                _classLevelController.text.isEmpty
                    ? null
                    : _classLevelController.text,
            tags: tags,
          );
    }

    if (mounted) {
      setState(() {
        _isEditing = false;
      });
      ref.read(aiNotesProvider.notifier).loadNotes();
    }
  }

  Future<void> _confirmDeleteNote(Note note) async {
    final confirmed = await GlassDialog.show<bool>(
      context: context,
      title: 'Delete Note',
      content: Text(
        'Are you sure you want to delete "${note.title}"? This action cannot be undone.',
        style: InhaleTypography.bodyMedium,
      ),
      actions: [
        GlassButton(
          label: 'Cancel',
          onTap: () => Navigator.of(context).pop(false),
          outlined: true,
        ),
        GlassButton(
          label: 'Delete',
          onTap: () => Navigator.of(context).pop(true),
          outlined: true,
        ),
      ],
    );

    if (confirmed == true && mounted) {
      await ref.read(aiNotesProvider.notifier).deleteNote(note.id);
      setState(() {
        _isEditing = false;
      });
    }
  }

  Future<void> _showCreateNoteOptions() async {
    final option = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => GlassBottomSheet(
            title: 'Create AI Note',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.lightbulb_outline_rounded),
                  title: const Text('From Topic'),
                  subtitle: const Text(
                    'Generate notes from a topic description',
                  ),
                  onTap: () => Navigator.pop(context, 'topic'),
                ),
                ListTile(
                  leading: const Icon(Icons.description_rounded),
                  title: const Text('From Document'),
                  subtitle: const Text(
                    'Generate notes from an uploaded PDF/document',
                  ),
                  onTap: () => Navigator.pop(context, 'document'),
                ),
                ListTile(
                  leading: const Icon(Icons.video_library_rounded),
                  title: const Text('From Video'),
                  subtitle: const Text(
                    'Generate notes from a video transcript',
                  ),
                  onTap: () => Navigator.pop(context, 'video'),
                ),
                ListTile(
                  leading: const Icon(Icons.edit_rounded),
                  title: const Text('Manual Note'),
                  subtitle: const Text('Create an empty note to edit manually'),
                  onTap: () => Navigator.pop(context, 'manual'),
                ),
              ],
            ),
          ),
    );

    if (!mounted) return;

    switch (option) {
      case 'topic':
        _showTopicInputDialog();
        break;
      case 'document':
        _showDocumentSelectionDialog();
        break;
      case 'video':
        _showVideoSelectionDialog();
        break;
      case 'manual':
        _createManualNote();
        break;
    }
  }

  void _createManualNote() async {
    await ref.read(aiNotesProvider.notifier).createNote();
    if (mounted) {
      final state = ref.read(aiNotesProvider);
      if (state.notes.isNotEmpty) {
        _openNoteForEditing(state.notes.first);
      }
    }
  }

  void _showTopicInputDialog() {
    String selectedType = 'study';
    final folderController = TextEditingController();
    final subjectController = TextEditingController();
    final tagsController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setDialogState) => GlassDialog(
                  title: 'Generate Notes from Topic',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GlassTextField(
                        hintText: 'Enter topic or description',
                        controller: _topicController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: InhaleSpacing.md),
                      DropdownButtonFormField<String>(
                        initialValue: selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Note Type',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'study',
                            child: Text('Study Notes'),
                          ),
                          DropdownMenuItem(
                            value: 'summary',
                            child: Text('Summary Notes'),
                          ),
                          DropdownMenuItem(
                            value: 'revision',
                            child: Text('Revision Notes'),
                          ),
                        ],
                        onChanged: (v) {
                          setDialogState(() {
                            selectedType = v!;
                          });
                        },
                      ),
                      const SizedBox(height: InhaleSpacing.md),
                      GlassTextField(
                        hintText: 'Folder (optional)',
                        controller: folderController,
                      ),
                      const SizedBox(height: InhaleSpacing.sm),
                      GlassTextField(
                        hintText: 'Subject (optional)',
                        controller: subjectController,
                      ),
                      const SizedBox(height: InhaleSpacing.sm),
                      GlassTextField(
                        hintText: 'Tags (comma-separated, optional)',
                        controller: tagsController,
                      ),
                    ],
                  ),
                  actions: [
                    GlassButton(
                      label: 'Cancel',
                      onTap: () => Navigator.pop(context),
                      outlined: true,
                    ),
                    GlassButton(
                      label: 'Generate',
                      onTap: () async {
                        Navigator.pop(context);
                        await _generateNotesFromTopic(
                          selectedType,
                          folderController.text,
                          subjectController.text,
                          tagsController.text,
                        );
                      },
                    ),
                  ],
                ),
          ),
    );
  }

  Future<void> _generateNotesFromTopic(
    String noteType,
    String folder,
    String subject,
    String tagsStr,
  ) async {
    if (_topicController.text.isEmpty) return;

    final tags =
        tagsStr
            .split(',')
            .map((t) => t.trim())
            .where((t) => t.isNotEmpty)
            .toList();

    final note = await ref
        .read(aiNotesProvider.notifier)
        .generateFromTopic(
          topicDescription: _topicController.text,
          noteType: noteType,
          folder: folder.isEmpty ? null : folder,
          subject: subject.isEmpty ? null : subject,
          tags: tags.isEmpty ? null : tags,
        );

    if (mounted && note != null) {
      _openNoteForEditing(note);
    }
    _topicController.clear();
  }

  Future<void> _showDocumentSelectionDialog() async {
    final database = ref.read(databaseProvider);
    final documents = await database.select(database.documents).get();

    if (!mounted) return;

    if (documents.isEmpty) {
      await GlassDialog.show(
        context: context,
        title: 'No Documents',
        content: const Text(
          'Please upload documents first in the Documents section.',
        ),
        actions: [
          GlassButton(label: 'OK', onTap: () => Navigator.pop(context)),
        ],
      );
      return;
    }

    final selectedDoc = await showDialog<db.Document>(
      context: context,
      builder:
          (context) => GlassDialog(
            title: 'Select Document',
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  return ListTile(
                    leading: const Icon(Icons.description_rounded),
                    title: Text(doc.title),
                    subtitle: Text(
                      '${doc.fileType.toUpperCase()} • ${(doc.sizeBytes / 1024).toStringAsFixed(1)} KB',
                    ),
                    onTap: () => Navigator.pop(context, doc),
                  );
                },
              ),
            ),
            actions: [
              GlassButton(
                label: 'Cancel',
                onTap: () => Navigator.pop(context),
                outlined: true,
              ),
            ],
          ),
    );

    if (selectedDoc != null && mounted) {
      await _generateNotesFromDocument(selectedDoc.id);
    }
  }

  Future<void> _generateNotesFromDocument(int documentId) async {
    final note = await ref
        .read(aiNotesProvider.notifier)
        .generateFromDocument(documentId: documentId, noteType: 'study');

    if (mounted && note != null) {
      _openNoteForEditing(note);
    }
  }

  Future<void> _showVideoSelectionDialog() async {
    final database = ref.read(databaseProvider);
    final transcripts = await database.select(database.videoTranscripts).get();

    if (!mounted) return;

    if (transcripts.isEmpty) {
      await GlassDialog.show(
        context: context,
        title: 'No Video Transcripts',
        content: const Text(
          'No video transcripts available. Add videos with transcripts first.',
        ),
        actions: [
          GlassButton(label: 'OK', onTap: () => Navigator.pop(context)),
        ],
      );
      return;
    }

    final selectedTranscript = await showDialog<db.VideoTranscript>(
      context: context,
      builder:
          (context) => GlassDialog(
            title: 'Select Video',
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: transcripts.length,
                itemBuilder: (context, index) {
                  final transcript = transcripts[index];
                  return ListTile(
                    leading: const Icon(Icons.video_library_rounded),
                    title: Text('Video #${transcript.id}'),
                    subtitle: Text(
                      '${transcript.language} • ${transcript.fullText.length} chars',
                    ),
                    onTap: () => Navigator.pop(context, transcript),
                  );
                },
              ),
            ),
            actions: [
              GlassButton(
                label: 'Cancel',
                onTap: () => Navigator.pop(context),
                outlined: true,
              ),
            ],
          ),
    );

    if (selectedTranscript != null && mounted) {
      await _generateNotesFromVideo(selectedTranscript.resourceId);
    }
  }

  Future<void> _generateNotesFromVideo(int resourceId) async {
    final note = await ref
        .read(aiNotesProvider.notifier)
        .generateFromVideoTranscript(
          resourceId: resourceId,
          noteType: 'summary',
        );

    if (mounted && note != null) {
      _openNoteForEditing(note);
    }
  }

  void _showFilterOptions() {
    final notifier = ref.read(aiNotesProvider.notifier);
    final folders = notifier.getFolders();
    final tags = notifier.getTags();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => GlassBottomSheet(
            title: 'Filter Notes',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (folders.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                    child: Text(
                      'Folders',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...folders.map(
                    (folder) => ListTile(
                      leading: const Icon(Icons.folder_rounded),
                      title: Text(folder),
                      onTap: () {
                        notifier.filterByFolder(folder);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const Divider(),
                ],
                if (tags.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.md),
                    child: Text(
                      'Tags',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...tags.map(
                    (tag) => ListTile(
                      leading: const Icon(Icons.label_rounded),
                      title: Text(tag),
                      onTap: () {
                        notifier.filterByTag(tag);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
                if (folders.isEmpty && tags.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(InhaleSpacing.md),
                    child: Text('No folders or tags yet.'),
                  ),
              ],
            ),
          ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _FilterChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color:
            isDark
                ? InhaleColors.electricBlue.withValues(alpha: 0.2)
                : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: InhaleTypography.labelSmall),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, size: 14),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color:
            isDark
                ? InhaleColors.electricBlue.withValues(alpha: 0.2)
                : InhaleColors.lightPrimaryBlue.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(InhaleRadius.xs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color:
                isDark
                    ? InhaleColors.electricBlue
                    : InhaleColors.lightPrimaryBlue,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: InhaleTypography.labelSmall.copyWith(
              color:
                  isDark
                      ? InhaleColors.electricBlue
                      : InhaleColors.lightPrimaryBlue,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
