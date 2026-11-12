/// Study Planner screen — plan list, today's agenda, creation dialog & session logging.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/responsive/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_dialog.dart';
import '../../widgets/glass_loading_indicator.dart';
import 'study_plan_provider.dart';

// ═══════════════════════════════════════════════════════════════════
// Entry screen
// ═══════════════════════════════════════════════════════════════════

class StudyPlanScreen extends ConsumerWidget {
  const StudyPlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyPlanProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    if (state.isLoading && state.plans.isEmpty) {
      return const Center(child: GlassLoadingIndicator());
    }

    return Scaffold(
      body: _StudyPlanBody(state: state, isDark: isDark, isMobile: isMobile),
      floatingActionButton: !isMobile
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _showCreatePlanDialog(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: const Text('New Plan'),
              backgroundColor: InhaleColors.blue,
              foregroundColor: Colors.white,
            ),
    );
  }

  void _showCreatePlanDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (ctx) => const _CreatePlanDialog(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Scrollable body
// ═══════════════════════════════════════════════════════════════════

class _StudyPlanBody extends ConsumerWidget {
  final StudyPlanState state;
  final bool isDark;
  final bool isMobile;

  const _StudyPlanBody({
    required this.state,
    required this.isDark,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final mutedText =
        isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;

    return Container(
      decoration: BoxDecoration(
        gradient: isDark
            ? InhaleColors.gradientBackgroundDark
            : InhaleColors.gradientBackground,
      ),
      child: CustomScrollView(
        slivers: [
          // ── App bar ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                InhaleSpacing.lg,
                InhaleSpacing.lg,
                InhaleSpacing.lg,
                InhaleSpacing.md,
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: InhaleColors.gradientPrimary,
                      borderRadius: BorderRadius.circular(InhaleRadius.sm),
                      boxShadow: [
                        BoxShadow(
                          color: InhaleColors.blue.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Text(
                    'Study Planner',
                    style: InhaleTypography.headlineMedium.copyWith(
                      color: primaryText,
                    ),
                  ),
                  const Spacer(),
                  if (!isMobile)
                    GlassButton(
                      onTap: () => StudyPlanScreen()._showCreatePlanDialog(
                        context,
                        ref,
                      ),
                      label: 'New Plan',
                    ),
                  if (isMobile)
                    IconButton(
                      onPressed: () => StudyPlanScreen()._showCreatePlanDialog(
                        context,
                        ref,
                      ),
                      icon: Icon(Icons.add_rounded, color: primaryText),
                    ),
                ],
              ),
            ),
          ),

          // ── Overall progress card ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: InhaleSpacing.lg,
                vertical: InhaleSpacing.sm,
              ),
              child: _OverallProgressCard(state: state, isDark: isDark),
            ),
          ),

          // ── Today's Agenda ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
              child: _TodayAgenda(todayItems: state.todayItems, isDark: isDark),
            ),
          ),

          // ── Plans list ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
              child: Text(
                'Your Plans',
                style: InhaleTypography.titleLarge.copyWith(color: primaryText),
              ),
            ),
          ),

          if (state.plans.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.xl),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 64,
                        color: mutedText,
                      ),
                      const SizedBox(height: InhaleSpacing.md),
                      Text(
                        'No study plans yet',
                        style: InhaleTypography.titleMedium.copyWith(
                          color: mutedText,
                        ),
                      ),
                      const SizedBox(height: InhaleSpacing.xs),
                      Text(
                        'Create one to get started',
                        style: InhaleTypography.bodyMedium.copyWith(
                          color: mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: InhaleSpacing.lg,
                vertical: InhaleSpacing.sm,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final plan = state.plans[index];
                  final items =
                      state.items.where((i) => i.planId == plan.id).toList();
                  final completed = items.where((i) => i.isCompleted).length;
                  final progress =
                      items.isEmpty ? 0.0 : completed / items.length;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                    child: _PlanCard(
                      plan: plan,
                      items: items,
                      progress: progress,
                      isDark: isDark,
                    ),
                  );
                }, childCount: state.plans.length),
              ),
            ),

          // ── Recent Sessions ──
          if (state.sessions.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: Text(
                  'Recent Sessions',
                  style: InhaleTypography.titleLarge.copyWith(
                    color: primaryText,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: InhaleSpacing.lg,
                vertical: InhaleSpacing.sm,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final session = state.sessions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.xs),
                    child: _SessionRow(session: session, isDark: isDark),
                  );
                }, childCount: state.sessions.length.clamp(0, 5)),
              ),
            ),
          ],

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: InhaleSpacing.xxl)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Overall progress card
// ═══════════════════════════════════════════════════════════════════

class _OverallProgressCard extends StatelessWidget {
  final StudyPlanState state;
  final bool isDark;

  const _OverallProgressCard({required this.state, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final mutedText =
        isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;
    final pct = (state.overallProgress * 100).toInt();
    final activeCount = state.plans.where((p) => p.isActive).length;

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: true,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: state.overallProgress,
                  strokeWidth: 5,
                  backgroundColor: InhaleColors.glassSurface,
                  valueColor: AlwaysStoppedAnimation<Color>(InhaleColors.blue),
                ),
                Center(
                  child: Text(
                    '$pct%',
                    style: InhaleTypography.titleSmall.copyWith(
                      color: primaryText,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: InhaleSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Progress',
                  style: InhaleTypography.titleMedium.copyWith(
                    color: primaryText,
                  ),
                ),
                Text(
                  '$activeCount active plan${activeCount != 1 ? 's' : ''} · ${state.todayItems.length} due today',
                  style: InhaleTypography.bodySmall.copyWith(color: mutedText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Today's agenda
// ═══════════════════════════════════════════════════════════════════

class _TodayAgenda extends ConsumerWidget {
  final List<StudyPlanItemViewModel> todayItems;
  final bool isDark;

  const _TodayAgenda({required this.todayItems, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;

    return Padding(
      padding: const EdgeInsets.only(
        top: InhaleSpacing.lg,
        bottom: InhaleSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.today_rounded, color: InhaleColors.blue, size: 20),
              const SizedBox(width: InhaleSpacing.xs),
              Text(
                "Today's Agenda",
                style: InhaleTypography.titleLarge.copyWith(color: primaryText),
              ),
              const Spacer(),
              if (todayItems.isNotEmpty)
                Text(
                  '${todayItems.where((i) => i.isCompleted).length}/${todayItems.length}',
                  style: InhaleTypography.bodySmall.copyWith(
                    color: InhaleColors.blue,
                  ),
                ),
            ],
          ),
          if (todayItems.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: InhaleSpacing.sm),
              child: Text(
                'Nothing scheduled for today',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: isDark
                      ? InhaleColors.textMuted
                      : InhaleColors.lightTextMuted,
                ),
              ),
            )
          else
            ...todayItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(top: InhaleSpacing.xs),
                child: _AgendaItem(item: item, isDark: isDark),
              ),
            ),
        ],
      ),
    );
  }
}

class _AgendaItem extends ConsumerWidget {
  final StudyPlanItemViewModel item;
  final bool isDark;

  const _AgendaItem({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(studyPlanProvider.notifier);
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final secondaryText =
        isDark ? InhaleColors.textSecondary : InhaleColors.lightTextSecondary;
    final typeIcon = _typeIcon(item.type);
    final typeColor = _typeColor(item.type);

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.sm),
      child: Row(
        children: [
          Checkbox(
            value: item.isCompleted,
            onChanged: (_) => notifier.completeItem(item.id),
            activeColor: InhaleColors.blue,
          ),
          const SizedBox(width: InhaleSpacing.xs),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(InhaleRadius.xs),
            ),
            child: Icon(typeIcon, color: typeColor, size: 18),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: InhaleTypography.bodyMedium.copyWith(
                    color: item.isCompleted
                        ? (isDark
                            ? InhaleColors.textMuted
                            : InhaleColors.lightTextMuted)
                        : primaryText,
                    decoration:
                        item.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  '${item.estimatedMinutes} min · ${item.type}',
                  style: InhaleTypography.bodySmall.copyWith(
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
          if (!item.isCompleted)
            TextButton(
              onPressed: () => _showSessionBottomSheet(context, ref),
              child: Text(
                'Log',
                style: InhaleTypography.labelSmall.copyWith(
                  color: InhaleColors.blue,
                ),
              ),
            )
          else
            const Icon(
              Icons.check_circle_rounded,
              color: InhaleColors.success,
              size: 20,
            ),
        ],
      ),
    );
  }

  void _showSessionBottomSheet(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(studyPlanProvider.notifier);
    final durationCtrl = TextEditingController(
      text: item.estimatedMinutes.toString(),
    );
    final notesCtrl = TextEditingController();
    final focusScore = ValueNotifier<int?>(null);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => GlassDialog(
        title: 'Log Study Session',
        content: StatefulBuilder(
          builder: (ctx2, setModalState) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlassTextField(
                  labelText: 'Duration (minutes)',
                  hintText: item.estimatedMinutes.toString(),
                  controller: durationCtrl,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassTextField(
                  labelText: 'Notes (optional)',
                  hintText: 'What did you learn?',
                  controller: notesCtrl,
                  maxLines: 3,
                ),
                const SizedBox(height: InhaleSpacing.sm),
                Text(
                  'Focus Score',
                  style: InhaleTypography.bodyMedium.copyWith(
                    color: isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(10, (i) {
                    final score = i + 1;
                    final isSelected = focusScore.value == score;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 2,
                      ),
                      child: ChoiceChip(
                        label: Text(score.toString()),
                        selected: isSelected,
                        onSelected: (v) => focusScore.value = v ? score : null,
                        selectedColor: InhaleColors.blue,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText),
                          fontSize: 12,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: InhaleSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: GlassButton(
                        onTap: () {
                          Navigator.pop(ctx2);
                          Navigator.pop(context);
                        },
                        label: 'Cancel',
                        outlined: true,
                      ),
                    ),
                    const SizedBox(width: InhaleSpacing.sm),
                    Expanded(
                      child: GlassButton(
                        onTap: () async {
                          final duration = int.tryParse(durationCtrl.text) ??
                              item.estimatedMinutes;

                          // Start and immediately stop a session to log it
                          final sessionId = await notifier.startSession(
                            planItemId: item.id,
                            activityType: item.type,
                          );
                          if (sessionId > 0) {
                            await notifier.stopSession(
                              sessionId: sessionId,
                              durationMinutes: duration,
                              focusScore: focusScore.value,
                              notes: notesCtrl.text.isEmpty
                                  ? null
                                  : notesCtrl.text,
                            );
                          }
                          // Also mark the item as completed
                          await notifier.completeItem(item.id);
                          if (context.mounted) Navigator.pop(context);
                        },
                        label: 'Complete',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: InhaleSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _typeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'read':
        return Icons.menu_book_rounded;
      case 'video':
        return Icons.play_circle_rounded;
      case 'quiz':
        return Icons.quiz_rounded;
      case 'flashcard':
        return Icons.auto_awesome_rounded;
      case 'practice':
        return Icons.edit_note_rounded;
      case 'review':
        return Icons.refresh_rounded;
      default:
        return Icons.school_rounded;
    }
  }

  Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'read':
        return InhaleColors.skyBlue;
      case 'video':
        return InhaleColors.pink;
      case 'quiz':
        return InhaleColors.warning;
      case 'flashcard':
        return InhaleColors.success;
      case 'practice':
        return InhaleColors.blue;
      case 'review':
        return InhaleColors.pink;
      default:
        return InhaleColors.info;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════
// Plan card (expandable)
// ═══════════════════════════════════════════════════════════════════

class _PlanCard extends ConsumerStatefulWidget {
  final StudyPlanViewModel plan;
  final List<StudyPlanItemViewModel> items;
  final double progress;
  final bool isDark;

  const _PlanCard({
    required this.plan,
    required this.items,
    required this.progress,
    required this.isDark,
  });

  @override
  ConsumerState<_PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends ConsumerState<_PlanCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(studyPlanProvider.notifier);
    final primaryText =
        widget.isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final mutedText =
        widget.isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;
    final pct = (widget.progress * 100).toInt();

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Switch.adaptive(
                value: widget.plan.isActive,
                onChanged: (_) => notifier.togglePlanActive(widget.plan.id),
                activeThumbColor: InhaleColors.blue,
                activeTrackColor: InhaleColors.blue.withValues(alpha: 0.3),
              ),
              const SizedBox(width: InhaleSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.plan.name,
                      style: InhaleTypography.titleMedium.copyWith(
                        color: primaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${_formatDate(widget.plan.startDate)} → ${_formatDate(widget.plan.endDate)}',
                      style: InhaleTypography.bodySmall.copyWith(
                        color: mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              // Progress circle
              SizedBox(
                width: 44,
                height: 44,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: widget.progress,
                      strokeWidth: 4,
                      backgroundColor: InhaleColors.glassSurface,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.progress >= 1.0
                            ? InhaleColors.success
                            : InhaleColors.blue,
                      ),
                    ),
                    Center(
                      child: Text(
                        '$pct%',
                        style: InhaleTypography.labelSmall.copyWith(
                          color: primaryText,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expand / delete
              const SizedBox(width: InhaleSpacing.xs),
              IconButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                icon: Icon(
                  _expanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: widget.isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
                ),
              ),
              IconButton(
                onPressed: () => _confirmDelete(context),
                icon: const Icon(Icons.delete_outline_rounded),
                color: InhaleColors.error.withValues(alpha: 0.7),
              ),
            ],
          ),

          // Progress bar
          const SizedBox(height: InhaleSpacing.sm),
          LinearProgressIndicator(
            value: widget.progress,
            minHeight: 4,
            backgroundColor: InhaleColors.glassSurface,
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.progress >= 1.0 ? InhaleColors.success : InhaleColors.blue,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          const SizedBox(height: InhaleSpacing.xs),
          Text(
            '${widget.items.where((i) => i.isCompleted).length} / ${widget.items.length} tasks',
            style: InhaleTypography.bodySmall.copyWith(color: mutedText),
          ),

          // Goals
          if (widget.plan.goals.isNotEmpty) ...[
            const SizedBox(height: InhaleSpacing.xs),
            Wrap(
              spacing: InhaleSpacing.xs,
              runSpacing: InhaleSpacing.xs,
              children: widget.plan.goals
                  .take(3)
                  .map(
                    (g) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: InhaleColors.blue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(
                          InhaleRadius.xs,
                        ),
                      ),
                      child: Text(
                        g,
                        style: InhaleTypography.labelSmall.copyWith(
                          color: InhaleColors.blue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],

          // Expanded items list
          if (_expanded && widget.items.isNotEmpty) ...[
            const SizedBox(height: InhaleSpacing.md),
            Divider(color: mutedText.withValues(alpha: 0.3)),
            ...widget.items.take(20).map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(top: InhaleSpacing.xs),
                    child: _PlanItemRow(item: item, isDark: widget.isDark),
                  ),
                ),
            if (widget.items.length > 20)
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View all ${widget.items.length} items',
                    style: InhaleTypography.bodySmall.copyWith(
                      color: InhaleColors.blue,
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => GlassDialog(
        title: 'Delete Plan',
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete "${widget.plan.name}"?',
              style: InhaleTypography.bodyMedium.copyWith(
                color: widget.isDark
                    ? InhaleColors.textSecondary
                    : InhaleColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: InhaleSpacing.md),
            Row(
              children: [
                Expanded(
                  child: GlassButton(
                    onTap: () => Navigator.pop(ctx),
                    label: 'Cancel',
                    outlined: true,
                  ),
                ),
                const SizedBox(width: InhaleSpacing.sm),
                Expanded(
                  child: GlassButton(
                    onTap: () {
                      ref
                          .read(studyPlanProvider.notifier)
                          .deletePlan(widget.plan.id);
                      Navigator.pop(ctx);
                    },
                    label: 'Delete',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  }
}

// ═══════════════════════════════════════════════════════════════════
// Plan item row (inside expanded plan)
// ═══════════════════════════════════════════════════════════════════

class _PlanItemRow extends ConsumerWidget {
  final StudyPlanItemViewModel item;
  final bool isDark;

  const _PlanItemRow({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(studyPlanProvider.notifier);
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final mutedText =
        isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;
    final typeColor = _typeColor(item.type);

    return Row(
      children: [
        Checkbox(
          value: item.isCompleted,
          onChanged: (_) => notifier.completeItem(item.id),
          activeColor: InhaleColors.blue,
          visualDensity: VisualDensity.compact,
        ),
        const SizedBox(width: InhaleSpacing.xs),
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: typeColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: InhaleSpacing.sm),
        Expanded(
          child: Text(
            item.title,
            style: InhaleTypography.bodySmall.copyWith(
              color: item.isCompleted ? mutedText : primaryText,
              decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        Text(
          '${item.estimatedMinutes}m',
          style: InhaleTypography.labelSmall.copyWith(color: mutedText),
        ),
        if (item.scheduledDate != null) ...[
          const SizedBox(width: InhaleSpacing.sm),
          Text(
            _shortDate(item.scheduledDate!),
            style: InhaleTypography.labelSmall.copyWith(color: mutedText),
          ),
        ],
      ],
    );
  }

  Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'read':
        return InhaleColors.skyBlue;
      case 'video':
        return InhaleColors.pink;
      case 'quiz':
        return InhaleColors.warning;
      case 'flashcard':
        return InhaleColors.success;
      case 'practice':
        return InhaleColors.blue;
      case 'review':
        return InhaleColors.pink;
      default:
        return InhaleColors.info;
    }
  }

  String _shortDate(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}';
  }
}

// ═══════════════════════════════════════════════════════════════════
// Session row
// ═══════════════════════════════════════════════════════════════════

class _SessionRow extends StatelessWidget {
  final StudySessionViewModel session;
  final bool isDark;

  const _SessionRow({required this.session, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final mutedText =
        isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;

    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: InhaleSpacing.md,
        vertical: InhaleSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              gradient: InhaleColors.gradientPrimary,
              borderRadius: BorderRadius.circular(InhaleRadius.xs),
            ),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.activityType,
                  style: InhaleTypography.bodyMedium.copyWith(
                    color: primaryText,
                  ),
                ),
                Text(
                  '${session.durationMinutes} min${session.focusScore != null ? ' · Focus ${session.focusScore}/10' : ''}',
                  style: InhaleTypography.bodySmall.copyWith(color: mutedText),
                ),
              ],
            ),
          ),
          Text(
            _timeAgo(session.startedAt),
            style: InhaleTypography.labelSmall.copyWith(color: mutedText),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    return '${diff.inMinutes}m ago';
  }
}

// ═══════════════════════════════════════════════════════════════════
// Create plan dialog
// ═══════════════════════════════════════════════════════════════════

class _CreatePlanDialog extends ConsumerStatefulWidget {
  const _CreatePlanDialog();

  @override
  ConsumerState<_CreatePlanDialog> createState() => _CreatePlanDialogState();
}

class _CreatePlanDialogState extends ConsumerState<_CreatePlanDialog> {
  final _nameCtrl = TextEditingController();
  final _goalsCtrl = TextEditingController();
  final _hoursCtrl = TextEditingController(text: '10');

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _goalsCtrl.dispose();
    _hoursCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final secondaryText =
        isDark ? InhaleColors.textSecondary : InhaleColors.lightTextSecondary;

    return GlassDialog(
      title: 'Create Study Plan',
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GlassTextField(
              labelText: 'Plan Name',
              hintText: 'e.g. Python Masterclass',
              controller: _nameCtrl,
            ),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(
              labelText: 'Goals (comma separated)',
              hintText: 'Learn syntax, Build projects, Pass exam',
              controller: _goalsCtrl,
              maxLines: 2,
            ),
            const SizedBox(height: InhaleSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickStartDate,
                    borderRadius: BorderRadius.circular(InhaleRadius.sm),
                    child: Container(
                      padding: const EdgeInsets.all(InhaleSpacing.sm),
                      decoration: BoxDecoration(
                        color: InhaleColors.glassSurface,
                        borderRadius: BorderRadius.circular(InhaleRadius.sm),
                        border: Border.all(color: InhaleColors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start Date',
                            style: InhaleTypography.labelSmall.copyWith(
                              color: secondaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(_startDate),
                            style: InhaleTypography.bodyMedium.copyWith(
                              color: primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: InhaleSpacing.sm),
                Expanded(
                  child: InkWell(
                    onTap: _pickEndDate,
                    borderRadius: BorderRadius.circular(InhaleRadius.sm),
                    child: Container(
                      padding: const EdgeInsets.all(InhaleSpacing.sm),
                      decoration: BoxDecoration(
                        color: InhaleColors.glassSurface,
                        borderRadius: BorderRadius.circular(InhaleRadius.sm),
                        border: Border.all(color: InhaleColors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End Date',
                            style: InhaleTypography.labelSmall.copyWith(
                              color: secondaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(_endDate),
                            style: InhaleTypography.bodyMedium.copyWith(
                              color: primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: InhaleSpacing.sm),
            GlassTextField(
              labelText: 'Hours per week',
              hintText: '10',
              controller: _hoursCtrl,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: InhaleSpacing.md),
            Row(
              children: [
                Expanded(
                  child: GlassButton(
                    onTap: () => Navigator.pop(context),
                    label: 'Cancel',
                    outlined: true,
                  ),
                ),
                const SizedBox(width: InhaleSpacing.sm),
                Expanded(
                  child: GlassButton(onTap: _submit, label: 'Create Plan'),
                ),
              ],
            ),
            const SizedBox(height: InhaleSpacing.sm),
          ],
        ),
      ),
    );
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
  }

  void _submit() {
    if (_nameCtrl.text.trim().isEmpty) return;

    final goals = _goalsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (goals.isEmpty) goals.add('Learn new topics');

    final hours = int.tryParse(_hoursCtrl.text) ?? 10;

    ref.read(studyPlanProvider.notifier).createPlan(
          name: _nameCtrl.text.trim(),
          goals: goals,
          startDate: _startDate,
          endDate: _endDate,
          hoursPerWeek: hours,
        );

    Navigator.pop(context);
  }

  String _formatDate(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }
}
