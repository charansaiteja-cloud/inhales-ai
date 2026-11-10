/// Flashcards feature — deck list, study mode, review queue,
/// card/deck creation, and AI flashcard generation.
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/glass_button.dart';
import '../../widgets/glass_dialog.dart';
import '../../widgets/glass_text_field.dart';
import '../../widgets/glass_loading_indicator.dart';
import 'flashcard_provider.dart';
import 'fsrs_algorithm.dart';

// ── Main Screen ───────────────────────────────────────────

class FlashcardScreen extends ConsumerWidget {
  const FlashcardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(flashcardProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? InhaleColors.gradientBackgroundDark
                  : InhaleColors.gradientBackground,
        ),
        child: CustomScrollView(
          slivers: [
            // Header
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
                            color: InhaleColors.electricBlue.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: InhaleSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flashcards',
                            style: InhaleTypography.headlineMedium.copyWith(
                              color:
                                  isDark
                                      ? InhaleColors.textPrimary
                                      : InhaleColors.lightNavyText,
                            ),
                          ),
                          Text(
                            'AI-powered spaced repetition',
                            style: InhaleTypography.bodySmall.copyWith(
                              color:
                                  isDark
                                      ? InhaleColors.textMuted
                                      : InhaleColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // FAB: Generate with AI
                    GlassButton(
                      iconOnly: true,
                      onTap: () => _showGenerateDialog(context, ref),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Daily Progress
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: _buildDailyProgress(context, state),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: InhaleSpacing.md)),

            // Action row
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: Row(
                  children: [
                    Expanded(
                      child: GlassButton(
                        label: 'Start Review',
                        onTap:
                            state.dueCards.isNotEmpty
                                ? () => context.push('/flashcards/study')
                                : null,
                      ),
                    ),
                    const SizedBox(width: InhaleSpacing.sm),
                    Expanded(
                      child: GlassButton(
                        label: 'New Deck',
                        onTap: () => _showCreateDeckDialog(context, ref),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: InhaleSpacing.md)),

            // Section title
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: Text(
                  'Your Decks',
                  style: InhaleTypography.titleLarge.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: InhaleSpacing.sm)),

            // Deck list
            if (state.isLoading)
              const SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(InhaleSpacing.xxl),
                    child: GlassLoadingIndicator(),
                  ),
                ),
              )
            else if (state.decks.isEmpty)
              _buildEmptySliver(context)
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final deck = state.decks[index];
                    final deckCards = state.deckCards[deck.id] ?? [];
                    final dueCount = deckCards.where((c) => c.isDue).length;

                    return Padding(
                      padding: EdgeInsets.only(bottom: InhaleSpacing.sm),
                      child: _DeckCard(
                        deck: deck,
                        dueCount: dueCount,
                        totalCards: deckCards.length,
                        onTap:
                            () => context.push('/flashcards/deck/${deck.id}'),
                        onDelete:
                            () => _confirmDeleteDeck(context, ref, deck.id),
                      ),
                    );
                  }, childCount: state.decks.length),
                ),
              ),

            const SliverToBoxAdapter(
              child: SizedBox(height: InhaleSpacing.xxl),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress(BuildContext context, FlashcardState state) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = state.progress;

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Progress',
                style: InhaleTypography.titleMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              Text(
                '${state.todayReviews}/${state.dailyGoal}',
                style: InhaleTypography.titleSmall.copyWith(
                  color: InhaleColors.electricBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: InhaleSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: InhaleColors.glassSurfaceMedium,
              valueColor: AlwaysStoppedAnimation(InhaleColors.electricBlue),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: InhaleSpacing.xs),
          Text(
            state.totalDue > 0
                ? '${state.totalDue} cards due for review'
                : 'All caught up! 🎉',
            style: InhaleTypography.bodySmall.copyWith(
              color:
                  isDark
                      ? InhaleColors.textMuted
                      : InhaleColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptySliver(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(InhaleSpacing.xxl),
          child: Column(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 64,
                color: InhaleColors.textMuted,
              ),
              const SizedBox(height: InhaleSpacing.md),
              Text(
                'No decks yet',
                style: InhaleTypography.titleLarge.copyWith(
                  color: InhaleColors.textMuted,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              Text(
                'Create a deck or generate with AI',
                style: InhaleTypography.bodySmall.copyWith(
                  color: InhaleColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Deck Card Widget ──────────────────────────────────────

class _DeckCard extends StatelessWidget {
  final FlashcardDeck deck;
  final int dueCount;
  final int totalCards;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _DeckCard({
    required this.deck,
    required this.dueCount,
    required this.totalCards,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(InhaleSpacing.md),
      elevated: true,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [InhaleColors.electricBlue, InhaleColors.violet],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(InhaleRadius.sm),
            ),
            child: const Icon(
              Icons.collections_bookmark_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: InhaleSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deck.name,
                  style: InhaleTypography.titleMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$totalCards cards${dueCount > 0 ? ' • $dueCount due' : ''}',
                  style: InhaleTypography.bodySmall.copyWith(
                    color:
                        dueCount > 0
                            ? InhaleColors.warning
                            : (isDark
                                ? InhaleColors.textMuted
                                : InhaleColors.lightTextSecondary),
                  ),
                ),
              ],
            ),
          ),
          if (dueCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: InhaleColors.warningSoft,
                borderRadius: BorderRadius.circular(InhaleRadius.xs),
              ),
              child: Text(
                '$dueCount',
                style: InhaleTypography.labelSmall.copyWith(
                  color: InhaleColors.warning,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(width: InhaleSpacing.sm),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            color: InhaleColors.textMuted,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

// ── Study Screen ──────────────────────────────────────────

class StudyScreen extends ConsumerStatefulWidget {
  const StudyScreen({super.key});

  @override
  ConsumerState<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends ConsumerState<StudyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  late Animation<double> _halfTurn;
  bool _isFlipped = false;
  int _currentIndex = 0;
  late List<Flashcard> _dueCards;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _halfTurn = Tween<double>(begin: 0, end: math.pi).animate(_flipAnimation);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(flashcardProvider);
      _dueCards = state.dueCards.toList();
      if (_dueCards.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No cards due for review')),
        );
      }
    });
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
    _flipController.forward(from: 0);
  }

  Future<void> _rateCard(FlashcardRating rating) async {
    if (_dueCards.isEmpty) return;

    final card = _dueCards[_currentIndex];
    await ref.read(flashcardProvider.notifier).reviewFlashcard(card.id, rating);

    setState(() {
      _isFlipped = false;
      _flipController.reset();
      _dueCards = ref.read(flashcardProvider).dueCards;
      _currentIndex = math.min(_currentIndex, _dueCards.length - 1);
      if (_currentIndex < 0) _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(flashcardProvider);

    _dueCards = state.dueCards;
    final progress =
        state.dailyGoal > 0 ? state.todayReviews / state.dailyGoal : 0.0;

    if (_dueCards.isEmpty || _currentIndex >= _dueCards.length) {
      return _buildCompleteScreen(context, isDark, progress);
    }

    final card = _dueCards[_currentIndex];
    final cardNumber = _currentIndex + 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Study Session'),
        actions: [
          Text(
            ' $cardNumber/${_dueCards.length}',
            style: InhaleTypography.titleSmall,
          ),
          const SizedBox(width: InhaleSpacing.sm),
        ],
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
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
            // Progress bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: InhaleColors.glassSurfaceMedium,
                    valueColor: AlwaysStoppedAnimation(InhaleColors.success),
                    minHeight: 4,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: InhaleSpacing.sm),
                        child: Text(
                          '${(progress * 100).toInt()}% of goal',
                          style: InhaleTypography.labelSmall.copyWith(
                            color: InhaleColors.textMuted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: InhaleSpacing.lg),

            // Flashcard area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: GestureDetector(
                      onTap: _flipCard,
                      child: AnimatedBuilder(
                        animation: _halfTurn,
                        builder: (context, child) {
                          final turn = _halfTurn.value;
                          final halfTurn = math.pi / 2;
                          final frontOpacity =
                              turn < halfTurn ? 1 - (turn / halfTurn) : 0;
                          final backOpacity =
                              turn >= halfTurn
                                  ? (turn - halfTurn) / halfTurn
                                  : 0;

                          return Stack(
                            children: [
                              if (frontOpacity > 0)
                                Opacity(
                                  opacity: frontOpacity.toDouble(),
                                  child: _buildCardFace(
                                    context,
                                    card.front,
                                    isFront: true,
                                  ),
                                ),
                              if (backOpacity > 0)
                                Opacity(
                                  opacity: backOpacity.toDouble(),
                                  child: _buildCardFace(
                                    context,
                                    card.back,
                                    isFront: false,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: InhaleSpacing.md),

            // Hint chip
            if (card.hint != null && !_isFlipped)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(card.hint!),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                child: Text(
                  'Show Hint',
                  style: InhaleTypography.labelMedium.copyWith(
                    color: InhaleColors.warning,
                  ),
                ),
              ),

            // Rating buttons
            Padding(
              padding: EdgeInsets.all(InhaleSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _RatingButton(
                      label: 'Again',
                      icon: Icons.close,
                      color: InhaleColors.error,
                      onTap: () => _rateCard(FlashcardRating.again),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: _RatingButton(
                      label: 'Hard',
                      icon: Icons.remove,
                      color: InhaleColors.warning,
                      onTap: () => _rateCard(FlashcardRating.hard),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: _RatingButton(
                      label: 'Good',
                      icon: Icons.check,
                      color: InhaleColors.info,
                      onTap: () => _rateCard(FlashcardRating.good),
                    ),
                  ),
                  const SizedBox(width: InhaleSpacing.sm),
                  Expanded(
                    child: _RatingButton(
                      label: 'Easy',
                      icon: Icons.star,
                      color: InhaleColors.success,
                      onTap: () => _rateCard(FlashcardRating.easy),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: InhaleSpacing.sm),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFace(
    BuildContext context,
    String text, {
    required bool isFront,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      elevated: true,
      glow: true,
      padding: const EdgeInsets.all(InhaleSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isFront)
            Icon(
              Icons.help_outline_rounded,
              size: 32,
              color: InhaleColors.electricBlue,
            )
          else
            Icon(
              Icons.lightbulb_rounded,
              size: 32,
              color: InhaleColors.warning,
            ),
          const SizedBox(height: InhaleSpacing.md),
          Text(
            text,
            textAlign: TextAlign.center,
            style: InhaleTypography.titleLarge.copyWith(
              color:
                  isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: InhaleSpacing.lg),
          Text(
            isFront ? 'Tap to reveal answer' : 'Tap to see question',
            style: InhaleTypography.bodySmall.copyWith(
              color:
                  isDark
                      ? InhaleColors.textMuted
                      : InhaleColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteScreen(
    BuildContext context,
    bool isDark,
    double progress,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(InhaleSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                size: 80,
                color: InhaleColors.success,
              ),
              const SizedBox(height: InhaleSpacing.lg),
              Text(
                'Session Complete!',
                style: InhaleTypography.headlineMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              const SizedBox(height: InhaleSpacing.sm),
              Text(
                'All caught up for today',
                style: InhaleTypography.bodyMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: InhaleSpacing.md),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: InhaleSpacing.md,
                  vertical: InhaleSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: InhaleColors.successSoft,
                  borderRadius: BorderRadius.circular(InhaleRadius.sm),
                ),
                child: Text(
                  'Daily progress: ${(progress * 100).toInt()}%',
                  style: InhaleTypography.titleMedium.copyWith(
                    color: InhaleColors.success,
                  ),
                ),
              ),
              const SizedBox(height: InhaleSpacing.xl),
              GlassButton(
                label: 'Back to Decks',
                width: 200,
                onTap: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Rating Button ─────────────────────────────────────────

class _RatingButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _RatingButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Deck Detail Screen ────────────────────────────────────

class DeckDetailScreen extends ConsumerStatefulWidget {
  final int deckId;
  const DeckDetailScreen({super.key, required this.deckId});

  @override
  ConsumerState<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends ConsumerState<DeckDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(flashcardProvider.notifier).loadCardsForDeck(widget.deckId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(flashcardProvider);
    final cards = state.deckCards[widget.deckId] ?? [];
    final deck = state.decks.cast<FlashcardDeck?>().firstWhere(
      (d) => d != null && d.id == widget.deckId,
      orElse: () => null,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(deck?.name ?? 'Deck'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateCardDialog(context, ref),
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
        child:
            cards.isEmpty
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.auto_awesome_rounded,
                        size: 48,
                        color: InhaleColors.textMuted,
                      ),
                      const SizedBox(height: InhaleSpacing.md),
                      Text(
                        'No cards in this deck',
                        style: InhaleTypography.titleMedium.copyWith(
                          color: InhaleColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: InhaleSpacing.sm),
                      GlassButton(
                        label: 'Add Cards',
                        onTap: () => _showCreateCardDialog(context, ref),
                      ),
                    ],
                  ),
                )
                : ListView.builder(
                  padding: EdgeInsets.all(InhaleSpacing.lg),
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: InhaleSpacing.sm),
                      child: _CardItem(
                        card: card,
                        onDelete: () {
                          ref
                              .read(flashcardProvider.notifier)
                              .deleteCard(card.id);
                        },
                      ),
                    );
                  },
                ),
      ),
    );
  }
}

// ── Card Item ─────────────────────────────────────────────

class _CardItem extends StatelessWidget {
  final Flashcard card;
  final VoidCallback onDelete;

  const _CardItem({required this.card, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  card.front,
                  style: InhaleTypography.titleSmall.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
              ),
              if (card.isDue)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: InhaleColors.warningSoft,
                    borderRadius: BorderRadius.circular(InhaleRadius.xs),
                  ),
                  child: Text(
                    'Due',
                    style: InhaleTypography.labelSmall.copyWith(
                      color: InhaleColors.warning,
                    ),
                  ),
                )
              else if (card.isNew)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: InhaleColors.successSoft,
                    borderRadius: BorderRadius.circular(InhaleRadius.xs),
                  ),
                  child: Text(
                    'New',
                    style: InhaleTypography.labelSmall.copyWith(
                      color: InhaleColors.success,
                    ),
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 18),
                color: InhaleColors.textMuted,
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            card.back,
            style: InhaleTypography.bodySmall.copyWith(
              color:
                  isDark
                      ? InhaleColors.textSecondary
                      : InhaleColors.lightTextSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Dialogs ───────────────────────────────────────────────

Future<void> _showCreateDeckDialog(BuildContext context, WidgetRef ref) {
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  return GlassDialog.show(
    context: context,
    title: 'Create New Deck',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassTextField(controller: nameCtrl, hintText: 'Deck name'),
        const SizedBox(height: InhaleSpacing.sm),
        GlassTextField(
          controller: descCtrl,
          hintText: 'Description (optional)',
          maxLines: 2,
        ),
      ],
    ),
    actions: [
      GlassButton(
        label: 'Cancel',
        outlined: true,
        onTap: () => Navigator.of(context).pop(),
      ),
      GlassButton(
        label: 'Create',
        onTap: () async {
          final name = nameCtrl.text.trim();
          if (name.isEmpty) return;
          await ref
              .read(flashcardProvider.notifier)
              .createDeck(
                name: name,
                description:
                    descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
              );
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Future<void> _showCreateCardDialog(BuildContext context, WidgetRef ref) {
  final state = ref.read(flashcardProvider);
  final deck = state.decks.first; // Default to first deck
  final frontCtrl = TextEditingController();
  final backCtrl = TextEditingController();
  final hintCtrl = TextEditingController();

  return GlassDialog.show(
    context: context,
    title: 'Add Card',
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassTextField(
          controller: frontCtrl,
          hintText: 'Front (question)',
          maxLines: 2,
        ),
        const SizedBox(height: InhaleSpacing.sm),
        GlassTextField(
          controller: backCtrl,
          hintText: 'Back (answer)',
          maxLines: 3,
        ),
        const SizedBox(height: InhaleSpacing.sm),
        GlassTextField(controller: hintCtrl, hintText: 'Hint (optional)'),
      ],
    ),
    actions: [
      GlassButton(
        label: 'Cancel',
        outlined: true,
        onTap: () => Navigator.of(context).pop(),
      ),
      GlassButton(
        label: 'Add',
        onTap: () async {
          final front = frontCtrl.text.trim();
          final back = backCtrl.text.trim();
          if (front.isEmpty || back.isEmpty) return;
          await ref
              .read(flashcardProvider.notifier)
              .createCard(
                deckId: deck.id,
                front: front,
                back: back,
                hint:
                    hintCtrl.text.trim().isEmpty ? null : hintCtrl.text.trim(),
              );
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Future<void> _showGenerateDialog(BuildContext context, WidgetRef ref) {
  final topicCtrl = TextEditingController();
  final textCtrl = TextEditingController();
  final countCtrl = TextEditingController(text: '10');
  var generationMode = 0; // 0=topic, 1=text

  return showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return GlassDialog(
            title: 'Generate Flashcards with AI',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('By Topic')),
                    ButtonSegment(value: 1, label: Text('From Text')),
                  ],
                  selected: {generationMode},
                  onSelectionChanged: (v) {
                    setDialogState(() => generationMode = v.first);
                  },
                ),
                const SizedBox(height: InhaleSpacing.sm),
                if (generationMode == 0)
                  GlassTextField(
                    controller: topicCtrl,
                    hintText: 'Enter a topic (e.g. Photosynthesis)',
                  )
                else
                  GlassTextField(
                    controller: textCtrl,
                    hintText: 'Paste text to generate cards from',
                    maxLines: 5,
                  ),
                const SizedBox(height: InhaleSpacing.sm),
                GlassTextField(
                  controller: countCtrl,
                  hintText: 'Number of cards',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              GlassButton(
                label: 'Cancel',
                outlined: true,
                onTap: () => Navigator.of(dialogContext).pop(),
              ),
              GlassButton(
                label: 'Generate',
                onTap: () async {
                  Navigator.of(dialogContext).pop();

                  final count = int.tryParse(countCtrl.text) ?? 10;
                  final clampedCount = math.min(math.max(count, 1), 50);

                  if (generationMode == 0) {
                    final topic = topicCtrl.text.trim();
                    if (topic.isEmpty) return;
                    await ref
                        .read(flashcardProvider.notifier)
                        .generateFlashcardsFromTopic(
                          topic: topic,
                          count: clampedCount,
                        );
                  } else {
                    final text = textCtrl.text.trim();
                    if (text.isEmpty) return;
                    await ref
                        .read(flashcardProvider.notifier)
                        .generateFlashcardsFromText(
                          text: text,
                          count: clampedCount,
                        );
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> _confirmDeleteDeck(
  BuildContext context,
  WidgetRef ref,
  int deckId,
) async {
  return GlassDialog.show(
    context: context,
    title: 'Delete Deck',
    content: const Text('Are you sure you want to delete this deck?'),
    actions: [
      GlassButton(
        label: 'Cancel',
        outlined: true,
        onTap: () => Navigator.of(context).pop(),
      ),
      GlassButton(
        label: 'Delete',
        onTap: () async {
          await ref.read(flashcardProvider.notifier).deleteDeck(deckId);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}
