import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/responsive/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_bottom_navigation_bar.dart';
import '../../widgets/glass_sidebar.dart';
import '../../widgets/ai_orb.dart';
import '../settings/settings_provider.dart';
import 'language_learning_provider.dart';

class LanguageLearningScreen extends ConsumerStatefulWidget {
  const LanguageLearningScreen({super.key});

  @override
  ConsumerState<LanguageLearningScreen> createState() =>
      _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends ConsumerState<LanguageLearningScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _textController = TextEditingController();
  final _grammarController = TextEditingController();
  final _topicController = TextEditingController();
  String _selectedLevel = 'Beginner';

  final _languageOptions = const [
    ('en', 'English', Icons.language),
    ('hi', 'Hindi', Icons.translate),
    ('es', 'Spanish', Icons.translate),
    ('fr', 'French', Icons.translate),
    ('de', 'German', Icons.translate),
    ('zh', 'Chinese', Icons.translate),
    ('ja', 'Japanese', Icons.translate),
    ('ko', 'Korean', Icons.translate),
    ('ar', 'Arabic', Icons.translate),
    ('ru', 'Russian', Icons.translate),
    ('pt', 'Portuguese', Icons.translate),
    ('it', 'Italian', Icons.translate),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _textController.dispose();
    _grammarController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final reducedBlur = settings.maybeWhen(
      data: (s) => s.reducedBlur,
      orElse: () => false,
    );

    final state = ref.watch(languageLearningProvider);
    final layout =
        Responsive.isDesktop(context)
            ? _buildDesktop(context, reducedBlur, state)
            : _buildMobile(context, reducedBlur, state);

    return Scaffold(
      body: SafeArea(child: layout),
      bottomNavigationBar:
          Responsive.isDesktop(context)
              ? null
              : GlassBottomNavigationBar(
                currentIndex: 0,
                onTap: (index) {
                  if (index == 0) {
                    GoRouter.of(context).go('/home');
                  } else if (index == 1) {
                    GoRouter.of(context).go('/chat');
                  }
                },
                items: const [
                  GlassBottomNavItem(
                    label: 'Learn',
                    icon: Icons.school_rounded,
                  ),
                  GlassBottomNavItem(label: 'Chat', icon: Icons.chat_rounded),
                  GlassBottomNavItem(label: 'Home', icon: Icons.home_rounded),
                ],
              ),
    );
  }

  Widget _buildMobile(
    BuildContext context,
    bool reducedBlur,
    LanguageLearningState state,
  ) {
    return _buildContent(context, reducedBlur, state, isDesktop: false);
  }

  Widget _buildDesktop(
    BuildContext context,
    bool reducedBlur,
    LanguageLearningState state,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 260,
          child: GlassSidebar(
            items: const [
              SidebarItem(
                label: 'Dashboard',
                icon: Icons.dashboard_rounded,
                route: '/home',
              ),
              SidebarItem(
                label: 'Chat',
                icon: Icons.chat_rounded,
                route: '/chat',
              ),
              SidebarItem(
                label: 'Language',
                icon: Icons.language_rounded,
                route: '/language-learning',
              ),
              SidebarItem(
                label: 'Settings',
                icon: Icons.settings_rounded,
                route: '/settings',
              ),
            ],
            currentIndex: 2,
            onItemTap: (index, label) {
              if (index == 0) {
                GoRouter.of(context).go('/home');
              } else if (index == 1) {
                GoRouter.of(context).go('/chat');
              } else if (index == 3) {
                GoRouter.of(context).go('/settings');
              }
            },
          ),
        ),
        Expanded(
          child: _buildContent(context, reducedBlur, state, isDesktop: true),
        ),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    bool reducedBlur,
    LanguageLearningState state, {
    required bool isDesktop,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient:
            isDark
                ? InhaleColors.gradientBackgroundDark
                : InhaleColors.gradientBackground,
      ),
      child: Column(
        children: [
          _buildHeader(context, isDark, isDesktop),
          _buildTabBar(isDark),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTranslateTab(context, state, isDark),
                _buildConversationTab(context, state, isDark),
                _buildGrammarTab(context, state, isDark),
                _buildVocabularyTab(context, state, isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.all(InhaleSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: InhaleColors.gradientPrimary,
              borderRadius: BorderRadius.circular(InhaleRadius.sm),
              boxShadow: [
                BoxShadow(
                  color: InhaleColors.electricBlue.withValues(alpha: 0.3),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.language_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Language Learning',
                style: InhaleTypography.displaySmall.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textPrimary
                          : InhaleColors.lightNavyText,
                ),
              ),
              Text(
                'Practice, translate, and learn',
                style: InhaleTypography.bodyMedium.copyWith(
                  color:
                      isDark
                          ? InhaleColors.textSecondary
                          : InhaleColors.lightTextSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(
            width: 60,
            height: 60,
            child: AIOrb(size: 60, isActive: true),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
      decoration: BoxDecoration(
        color:
            isDark
                ? InhaleColors.glassGrey.withValues(alpha: 0.5)
                : InhaleColors.lightGlassSurface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(InhaleRadius.md),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: InhaleColors.gradientPrimary,
          borderRadius: BorderRadius.circular(InhaleRadius.sm),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor:
            isDark
                ? InhaleColors.textSecondary
                : InhaleColors.lightTextSecondary,
        tabs: const [
          Tab(icon: Icon(Icons.translate_rounded), text: 'Translate'),
          Tab(icon: Icon(Icons.chat_rounded), text: 'Conversation'),
          Tab(icon: Icon(Icons.book_rounded), text: 'Grammar'),
          Tab(icon: Icon(Icons.school), text: 'Vocabulary'),
        ],
      ),
    );
  }

  // ==================== Translate Tab ====================
  Widget _buildTranslateTab(
    BuildContext context,
    LanguageLearningState state,
    bool isDark,
  ) {
    final translationState = state.translation;

    return SingleChildScrollView(
      padding: EdgeInsets.all(InhaleSpacing.lg),
      child: Column(
        children: [
          _buildLanguageSelector(
            translationState.sourceLang,
            translationState.targetLang,
            (source, target) {
              ref
                  .read(languageLearningProvider.notifier)
                  .setTranslationLanguages(source, target);
            },
            isDark,
          ),
          const SizedBox(height: InhaleSpacing.lg),
          _buildTranslationInput(translationState, isDark),
          const SizedBox(height: InhaleSpacing.lg),
          _buildTranslationOutput(translationState, isDark),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(
    String sourceLang,
    String targetLang,
    Function(String, String) onChanged,
    bool isDark,
  ) {
    return Row(
      children: [
        Expanded(
          child: _buildLanguageDropdown(sourceLang, 'From', (value) {
            if (value != null) {
              onChanged(value, targetLang);
            }
          }, isDark),
        ),
        IconButton(
          icon: const Icon(Icons.swap_horiz_rounded),
          onPressed: () {
            onChanged(targetLang, sourceLang);
          },
          color:
              isDark
                  ? InhaleColors.electricBlue
                  : InhaleColors.lightPrimaryBlue,
        ),
        Expanded(
          child: _buildLanguageDropdown(targetLang, 'To', (value) {
            if (value != null) {
              onChanged(sourceLang, value);
            }
          }, isDark),
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown(
    String value,
    String label,
    Function(String?) onChanged,
    bool isDark,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: isDark ? InhaleColors.glassGrey : InhaleColors.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(InhaleRadius.sm),
          borderSide: BorderSide.none,
        ),
      ),
      items:
          _languageOptions
              .map(
                (lang) => DropdownMenuItem(
                  value: lang.$1,
                  child: Text(
                    lang.$2,
                    style: InhaleTypography.bodyMedium.copyWith(
                      color:
                          isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                    ),
                  ),
                ),
              )
              .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTranslationInput(TranslationState state, bool isDark) {
    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _langName(state.sourceLang),
            style: InhaleTypography.labelSmall.copyWith(
              color:
                  isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: InhaleSpacing.xs),
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter text to translate...',
              border: InputBorder.none,
              filled: false,
            ),
            style: InhaleTypography.bodyMedium.copyWith(
              color:
                  isDark
                      ? InhaleColors.textPrimary
                      : InhaleColors.lightNavyText,
            ),
          ),
          const SizedBox(height: InhaleSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed:
                    state.isTranslating
                        ? null
                        : () {
                          ref
                              .read(languageLearningProvider.notifier)
                              .translate(
                                text: _textController.text,
                                fromLang: state.sourceLang,
                                toLang: state.targetLang,
                              );
                        },
                icon:
                    state.isTranslating
                        ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Icon(Icons.translate_rounded),
                label: Text(
                  state.isTranslating ? 'Translating...' : 'Translate',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: InhaleColors.electricBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(InhaleRadius.sm),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationOutput(TranslationState state, bool isDark) {
    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _langName(state.targetLang),
            style: InhaleTypography.labelSmall.copyWith(
              color:
                  isDark ? InhaleColors.textMuted : InhaleColors.lightTextMuted,
            ),
          ),
          const SizedBox(height: InhaleSpacing.xs),
          if (state.isTranslating)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.md),
                child: CircularProgressIndicator(),
              ),
            )
          else if (state.error != null)
            Text(
              'Error: ${state.error}',
              style: InhaleTypography.bodyMedium.copyWith(
                color: InhaleColors.error,
              ),
            )
          else if (state.translatedText.isNotEmpty)
            Text(
              state.translatedText,
              style: InhaleTypography.bodyLarge.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
            )
          else
            Text(
              'Translation will appear here',
              style: InhaleTypography.bodyMedium.copyWith(
                color:
                    isDark
                        ? InhaleColors.textSecondary
                        : InhaleColors.lightTextSecondary,
              ),
            ),
        ],
      ),
    );
  }

  // ==================== Conversation Tab ====================
  Widget _buildConversationTab(
    BuildContext context,
    LanguageLearningState state,
    bool isDark,
  ) {
    final conversationState = state.conversation;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(InhaleSpacing.md),
          child: _buildLanguageDropdown(
            conversationState.targetLanguage,
            'Practice Language',
            (value) {
              if (value != null) {
                ref
                    .read(languageLearningProvider.notifier)
                    .setConversationLanguage(value);
              }
            },
            isDark,
          ),
        ),
        Expanded(
          child:
              conversationState.messages.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 64,
                          color:
                              isDark
                                  ? InhaleColors.textMuted
                                  : InhaleColors.lightTextMuted,
                        ),
                        const SizedBox(height: InhaleSpacing.md),
                        Text(
                          'Start a conversation!',
                          style: InhaleTypography.titleMedium.copyWith(
                            color:
                                isDark
                                    ? InhaleColors.textPrimary
                                    : InhaleColors.lightNavyText,
                          ),
                        ),
                        const SizedBox(height: InhaleSpacing.xs),
                        Text(
                          'Practice speaking with AI tutor',
                          style: InhaleTypography.bodyMedium.copyWith(
                            color:
                                isDark
                                    ? InhaleColors.textSecondary
                                    : InhaleColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                  : _buildChatList(conversationState, isDark),
        ),
        _buildChatInput(conversationState, isDark),
      ],
    );
  }

  Widget _buildChatList(ConversationState state, bool isDark) {
    return ListView.builder(
      padding: EdgeInsets.all(InhaleSpacing.md),
      itemCount: state.messages.length,
      itemBuilder: (context, index) {
        final message = state.messages[index];
        return Align(
          alignment:
              message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: InhaleSpacing.sm),
            padding: EdgeInsets.all(InhaleSpacing.md),
            decoration: BoxDecoration(
              gradient: message.isUser ? InhaleColors.gradientPrimary : null,
              borderRadius: BorderRadius.circular(InhaleRadius.md),
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            child: Text(
              message.content,
              style: InhaleTypography.bodyMedium.copyWith(
                color:
                    message.isUser
                        ? Colors.white
                        : (isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatInput(ConversationState state, bool isDark) {
    return Container(
      padding: EdgeInsets.all(InhaleSpacing.md),
      decoration: BoxDecoration(
        color:
            isDark
                ? InhaleColors.glassGrey.withValues(alpha: 0.8)
                : InhaleColors.lightGlassSurface.withValues(alpha: 0.8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor:
                    isDark ? InhaleColors.glassGrey : InhaleColors.lightSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(InhaleRadius.lg),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: InhaleSpacing.md,
                  vertical: InhaleSpacing.sm,
                ),
              ),
              style: InhaleTypography.bodyMedium.copyWith(
                color:
                    isDark
                        ? InhaleColors.textPrimary
                        : InhaleColors.lightNavyText,
              ),
              onChanged: (value) {
                ref
                    .read(languageLearningProvider.notifier)
                    .setConversationInput(value);
              },
              onSubmitted: (_) => _sendConversationMessage(),
            ),
          ),
          const SizedBox(width: InhaleSpacing.sm),
          Container(
            decoration: BoxDecoration(
              gradient: InhaleColors.gradientPrimary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: state.isGenerating ? null : _sendConversationMessage,
              icon:
                  state.isGenerating
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
                      : const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _sendConversationMessage() {
    final input = _textController.text.trim();
    if (input.isEmpty) return;

    final notifier = ref.read(languageLearningProvider.notifier);
    notifier.conversationPractice(
      message: input,
      language: ref.read(languageLearningProvider).conversation.targetLanguage,
    );
    _textController.clear();
  }

  // ==================== Grammar Tab ====================
  Widget _buildGrammarTab(
    BuildContext context,
    LanguageLearningState state,
    bool isDark,
  ) {
    final grammarState = state.grammar;

    return SingleChildScrollView(
      padding: EdgeInsets.all(InhaleSpacing.lg),
      child: Column(
        children: [
          _buildLanguageDropdown(grammarState.language, 'Language', (value) {
            if (value != null) {
              ref
                  .read(languageLearningProvider.notifier)
                  .setGrammarLanguage(value);
            }
          }, isDark),
          const SizedBox(height: InhaleSpacing.lg),
          GlassCard(
            padding: const EdgeInsets.all(InhaleSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ask about grammar',
                  style: InhaleTypography.labelSmall.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textMuted
                            : InhaleColors.lightTextMuted,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.xs),
                TextField(
                  controller: _grammarController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'e.g., past tense, subjunctive mood, articles...',
                    border: InputBorder.none,
                    filled: false,
                  ),
                  style: InhaleTypography.bodyMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed:
                          grammarState.isLoading
                              ? null
                              : () {
                                ref
                                    .read(languageLearningProvider.notifier)
                                    .explainGrammar(
                                      query: _grammarController.text,
                                      language: grammarState.language,
                                    );
                              },
                      icon:
                          grammarState.isLoading
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(Icons.book_rounded),
                      label: Text(
                        grammarState.isLoading ? 'Explaining...' : 'Explain',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InhaleColors.electricBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(InhaleRadius.sm),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: InhaleSpacing.lg),
          if (grammarState.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.xl),
                child: CircularProgressIndicator(),
              ),
            )
          else if (grammarState.error != null)
            GlassCard(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: Text(
                'Error: ${grammarState.error}',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: InhaleColors.error,
                ),
              ),
            )
          else if (grammarState.explanation.isNotEmpty)
            GlassCard(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grammar Explanation',
                    style: InhaleTypography.titleMedium.copyWith(
                      color:
                          isDark
                              ? InhaleColors.textPrimary
                              : InhaleColors.lightNavyText,
                    ),
                  ),
                  const SizedBox(height: InhaleSpacing.sm),
                  Text(
                    grammarState.explanation,
                    style: InhaleTypography.bodyMedium.copyWith(
                      color:
                          isDark
                              ? InhaleColors.textSecondary
                              : InhaleColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ==================== Vocabulary Tab ====================
  Widget _buildVocabularyTab(
    BuildContext context,
    LanguageLearningState state,
    bool isDark,
  ) {
    final vocabState = state.vocabulary;

    return SingleChildScrollView(
      padding: EdgeInsets.all(InhaleSpacing.lg),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildLanguageDropdown(vocabState.language, 'Language', (
                  value,
                ) {
                  if (value != null) {
                    ref
                        .read(languageLearningProvider.notifier)
                        .setVocabularyLanguage(value);
                  }
                }, isDark),
              ),
              const SizedBox(width: InhaleSpacing.sm),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedLevel,
                  decoration: InputDecoration(
                    labelText: 'Level',
                    filled: true,
                    fillColor:
                        isDark
                            ? InhaleColors.glassGrey
                            : InhaleColors.lightSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(InhaleRadius.sm),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Beginner',
                      child: Text('Beginner'),
                    ),
                    DropdownMenuItem(
                      value: 'Intermediate',
                      child: Text('Intermediate'),
                    ),
                    DropdownMenuItem(
                      value: 'Advanced',
                      child: Text('Advanced'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLevel = value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: InhaleSpacing.lg),
          GlassCard(
            padding: const EdgeInsets.all(InhaleSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Topics (comma separated)',
                  style: InhaleTypography.labelSmall.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textMuted
                            : InhaleColors.lightTextMuted,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.xs),
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    hintText: 'e.g., food, travel, business',
                    border: InputBorder.none,
                    filled: false,
                  ),
                  style: InhaleTypography.bodyMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed:
                          vocabState.isLoading
                              ? null
                              : () {
                                final topics =
                                    _topicController.text
                                        .split(',')
                                        .map((s) => s.trim())
                                        .where((s) => s.isNotEmpty)
                                        .toList();
                                ref
                                    .read(languageLearningProvider.notifier)
                                    .generateVocabulary(
                                      topics: topics,
                                      language: vocabState.language,
                                    );
                              },
                      icon:
                          vocabState.isLoading
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(Icons.school),
                      label: Text(
                        vocabState.isLoading
                            ? 'Generating...'
                            : 'Generate Vocab',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InhaleColors.electricBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(InhaleRadius.sm),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed:
                          vocabState.isLoading
                              ? null
                              : () {
                                ref
                                    .read(languageLearningProvider.notifier)
                                    .generateSentences(
                                      level: _selectedLevel,
                                      language: vocabState.language,
                                    );
                              },
                      icon:
                          vocabState.isLoading
                              ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                              : const Icon(Icons.format_quote_rounded),
                      label: Text(
                        vocabState.isLoading
                            ? 'Generating...'
                            : 'Generate Sentences',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InhaleColors.success,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(InhaleRadius.sm),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: InhaleSpacing.lg),
          if (vocabState.isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(InhaleSpacing.xl),
                child: CircularProgressIndicator(),
              ),
            )
          else if (vocabState.error != null)
            GlassCard(
              padding: const EdgeInsets.all(InhaleSpacing.md),
              child: Text(
                'Error: ${vocabState.error}',
                style: InhaleTypography.bodyMedium.copyWith(
                  color: InhaleColors.error,
                ),
              ),
            )
          else if (vocabState.items.isNotEmpty)
            ...vocabState.items.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: InhaleSpacing.sm),
                child: GlassCard(
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.word,
                        style: InhaleTypography.titleMedium.copyWith(
                          color:
                              isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (item.pronunciation != null) ...[
                        const SizedBox(height: InhaleSpacing.xs),
                        Text(
                          item.pronunciation!,
                          style: InhaleTypography.bodySmall.copyWith(
                            color:
                                isDark
                                    ? InhaleColors.textMuted
                                    : InhaleColors.lightTextMuted,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      const SizedBox(height: InhaleSpacing.xs),
                      Text(
                        item.definition,
                        style: InhaleTypography.bodyMedium.copyWith(
                          color:
                              isDark
                                  ? InhaleColors.textSecondary
                                  : InhaleColors.lightTextSecondary,
                        ),
                      ),
                      if (item.example.isNotEmpty) ...[
                        const SizedBox(height: InhaleSpacing.xs),
                        Container(
                          padding: EdgeInsets.all(InhaleSpacing.xs),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? InhaleColors.glassGrey
                                    : InhaleColors.lightSurface,
                            borderRadius: BorderRadius.circular(
                              InhaleRadius.xs,
                            ),
                          ),
                          child: Text(
                            item.example,
                            style: InhaleTypography.bodySmall.copyWith(
                              color:
                                  isDark
                                      ? InhaleColors.textPrimary
                                      : InhaleColors.lightNavyText,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _langName(String code) {
    const names = {
      'en': 'English',
      'hi': 'Hindi',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'zh': 'Chinese',
      'ja': 'Japanese',
      'ko': 'Korean',
      'ar': 'Arabic',
      'ru': 'Russian',
      'pt': 'Portuguese',
      'it': 'Italian',
    };
    return names[code] ?? code;
  }
}
