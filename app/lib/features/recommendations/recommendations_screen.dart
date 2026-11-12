/// AI Recommendations screen — personalized study suggestions.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/responsive/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_loading_indicator.dart';
import 'recommendations_provider.dart';

// ═══════════════════════════════════════════════════════════════════
// Entry screen
// ═══════════════════════════════════════════════════════════════════

class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recommendationsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);

    if (state.isLoading && state.recommendations.isEmpty) {
      return Scaffold(body: const Center(child: GlassLoadingIndicator()));
    }

    return Scaffold(
      body: _RecommendationsBody(
        state: state,
        isDark: isDark,
        isMobile: isMobile,
      ),
      floatingActionButton: !isMobile
          ? null
          : FloatingActionButton.extended(
              onPressed: () => ref
                  .read(recommendationsProvider.notifier)
                  .generateRecommendations(),
              icon: state.isGenerating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : const Icon(Icons.auto_awesome_rounded),
              label: Text(state.isGenerating ? 'Generating...' : 'Generate'),
              backgroundColor: InhaleColors.blue,
              foregroundColor: Colors.white,
            ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════
// Scrollable body
// ═══════════════════════════════════════════════════════════════════

class _RecommendationsBody extends ConsumerWidget {
  final RecommendationsState state;
  final bool isDark;
  final bool isMobile;

  const _RecommendationsBody({
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
    final notifier = ref.read(recommendationsProvider.notifier);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          Icons.recommend_rounded,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: InhaleSpacing.sm),
                      Text(
                        'Recommendations',
                        style: InhaleTypography.headlineMedium.copyWith(
                          color: primaryText,
                        ),
                      ),
                      const Spacer(),
                      if (!isMobile)
                        GlassButton(
                          onTap: () => notifier.generateRecommendations(),
                          label: state.isGenerating
                              ? 'Generating...'
                              : 'Generate New',
                        ),
                      if (isMobile)
                        IconButton(
                          onPressed: () => notifier.generateRecommendations(),
                          icon: Icon(
                            state.isGenerating
                                ? Icons.hourglass_empty_rounded
                                : Icons.add_rounded,
                            color: primaryText,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: InhaleSpacing.sm),
                  Text(
                    'AI-powered study suggestions tailored to your learning',
                    style: InhaleTypography.bodyMedium.copyWith(
                      color: mutedText,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Filter chips ──
          if (state.availableTypes.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: Text(
                          'All',
                          style: InhaleTypography.labelSmall.copyWith(
                            color: state.filterType == null
                                ? Colors.white
                                : (isDark
                                    ? InhaleColors.textPrimary
                                    : InhaleColors.lightNavyText),
                          ),
                        ),
                        selected: state.filterType == null,
                        onSelected: (_) => notifier.clearFilter(),
                        selectedColor: InhaleColors.blue,
                        backgroundColor: InhaleColors.glassSurface,
                        side: BorderSide(
                          color: isDark
                              ? InhaleColors.glassBorder
                              : InhaleColors.lightGlassBorder,
                        ),
                      ),
                      const SizedBox(width: InhaleSpacing.xs),
                      ...state.availableTypes.map(
                        (type) => Padding(
                          padding: const EdgeInsets.only(
                            left: InhaleSpacing.xs,
                          ),
                          child: FilterChip(
                            label: Text(
                              _typeLabel(type),
                              style: InhaleTypography.labelSmall.copyWith(
                                color: state.filterType == type
                                    ? Colors.white
                                    : (isDark
                                        ? InhaleColors.textPrimary
                                        : InhaleColors.lightNavyText),
                              ),
                            ),
                            selected: state.filterType == type,
                            onSelected: (_) => notifier.setFilter(type),
                            selectedColor: InhaleColors.blue,
                            backgroundColor: InhaleColors.glassSurface,
                            side: BorderSide(
                              color: isDark
                                  ? InhaleColors.glassBorder
                                  : InhaleColors.lightGlassBorder,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── Recommendations list ──
          if (state.filteredRecommendations.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.xl),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.recommend_rounded, size: 64, color: mutedText),
                      const SizedBox(height: InhaleSpacing.md),
                      Text(
                        state.recommendations.isEmpty
                            ? 'No recommendations yet'
                            : 'No matching recommendations',
                        style: InhaleTypography.titleMedium.copyWith(
                          color: mutedText,
                        ),
                      ),
                      const SizedBox(height: InhaleSpacing.xs),
                      Text(
                        state.recommendations.isEmpty
                            ? 'Tap "Generate New" to get personalized suggestions'
                            : 'Try a different filter',
                        style: InhaleTypography.bodySmall.copyWith(
                          color: mutedText,
                        ),
                      ),
                      if (state.recommendations.isEmpty) ...[
                        const SizedBox(height: InhaleSpacing.md),
                        GlassButton(
                          onTap: () => notifier.generateRecommendations(),
                          label: 'Generate Recommendations',
                        ),
                      ],
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
                  final rec = state.filteredRecommendations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: InhaleSpacing.sm),
                    child: _RecommendationCard(
                      recommendation: rec,
                      isDark: isDark,
                    ),
                  );
                }, childCount: state.filteredRecommendations.length),
              ),
            ),

          // ── Dismiss all button ──
          if (state.activeRecommendations.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: GlassButton(
                        onTap: () => _confirmDismissAll(context, ref),
                        label: 'Dismiss All',
                        outlined: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: InhaleSpacing.xxl)),
        ],
      ),
    );
  }

  void _confirmDismissAll(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? InhaleColors.glassSurface : Colors.white,
        title: Text(
          'Dismiss All',
          style: InhaleTypography.titleMedium.copyWith(
            color:
                isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText,
          ),
        ),
        content: Text(
          'Are you sure you want to dismiss all recommendations?',
          style: InhaleTypography.bodyMedium.copyWith(
            color: isDark
                ? InhaleColors.textSecondary
                : InhaleColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: InhaleTypography.labelSmall.copyWith(
                color: InhaleColors.blue,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(recommendationsProvider.notifier).dismissAll();
              Navigator.pop(ctx);
            },
            child: Text(
              'Dismiss All',
              style: InhaleTypography.labelSmall.copyWith(
                color: InhaleColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'topic':
        return 'Topic';
      case 'resource':
        return 'Resource';
      case 'quiz':
        return 'Quiz';
      case 'flashcard':
        return 'Flashcard';
      case 'review':
        return 'Review';
      case 'schedule':
        return 'Schedule';
      default:
        return type;
    }
  }
}

// ═══════════════════════════════════════════════════════════════════
// Recommendation card
// ═══════════════════════════════════════════════════════════════════

class _RecommendationCard extends ConsumerWidget {
  final RecommendationViewModel recommendation;
  final bool isDark;

  const _RecommendationCard({
    required this.recommendation,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(recommendationsProvider.notifier);
    final primaryText =
        isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText;
    final secondaryText =
        isDark ? InhaleColors.textSecondary : InhaleColors.lightTextSecondary;
    final mutedText =
        isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted;

    final priorityColor = _priorityColor(recommendation.priority);
    final typeIcon = recommendation.typeIcon;

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: priorityColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(InhaleRadius.xs),
                ),
                child: Icon(typeIcon, color: priorityColor, size: 20),
              ),
              const SizedBox(width: InhaleSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recommendation.title,
                      style: InhaleTypography.titleMedium.copyWith(
                        color: primaryText,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: priorityColor.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              InhaleRadius.xs,
                            ),
                          ),
                          child: Text(
                            recommendation.priorityLabel,
                            style: InhaleTypography.labelSmall.copyWith(
                              color: priorityColor,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: InhaleSpacing.xs),
                        Text(
                          _typeLabel(recommendation.type),
                          style: InhaleTypography.labelSmall.copyWith(
                            color: mutedText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action buttons
              Column(
                children: [
                  IconButton(
                    onPressed: () => notifier.dismiss(recommendation.id),
                    icon: const Icon(Icons.close_rounded),
                    iconSize: 20,
                    color: mutedText,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    onPressed: () => notifier.accept(recommendation.id),
                    icon: const Icon(Icons.check_rounded),
                    iconSize: 20,
                    color: InhaleColors.success,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),

          // Description
          const SizedBox(height: InhaleSpacing.sm),
          Text(
            recommendation.description,
            style: InhaleTypography.bodyMedium.copyWith(color: secondaryText),
          ),

          // Reason
          const SizedBox(height: InhaleSpacing.xs),
          Container(
            padding: const EdgeInsets.all(InhaleSpacing.sm),
            decoration: BoxDecoration(
              color: isDark
                  ? InhaleColors.glassSurface
                  : InhaleColors.blue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(InhaleRadius.xs),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: InhaleColors.blue,
                ),
                const SizedBox(width: InhaleSpacing.xs),
                Expanded(
                  child: Text(
                    recommendation.reason,
                    style: InhaleTypography.bodySmall.copyWith(
                      color: isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action button
          const SizedBox(height: InhaleSpacing.sm),
          Row(
            children: [
              Expanded(
                child: GlassButton(
                  onTap: () => _handleAccept(context, ref),
                  label: 'Accept',
                ),
              ),
              const SizedBox(width: InhaleSpacing.sm),
              GlassButton(
                onTap: () => notifier.dismiss(recommendation.id),
                label: 'Dismiss',
                outlined: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _priorityColor(int priority) {
    switch (priority) {
      case 1:
        return InhaleColors.error;
      case 2:
        return InhaleColors.warning;
      case 3:
        return InhaleColors.info;
      default:
        return InhaleColors.blue;
    }
  }

  String _typeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'topic':
        return 'Topic';
      case 'resource':
        return 'Resource';
      case 'quiz':
        return 'Quiz';
      case 'flashcard':
        return 'Flashcard';
      case 'review':
        return 'Review';
      case 'schedule':
        return 'Schedule';
      default:
        return type;
    }
  }

  void _handleAccept(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(recommendationsProvider.notifier);
    notifier.accept(recommendation.id);

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Accepted: ${recommendation.title}'),
        backgroundColor: InhaleColors.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
