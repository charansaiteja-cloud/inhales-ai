import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/responsive/responsive.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_search_bar.dart';
import '../../widgets/glass_status_badge.dart';
import '../../widgets/glass_bottom_navigation_bar.dart';
import '../../widgets/glass_sidebar.dart';
import '../../widgets/ai_orb.dart';
import '../settings/settings_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  final _searchController = TextEditingController();

  final _navDestinations = const [
    BottomNavDestination(label: 'Home', icon: Icons.home_rounded),
    BottomNavDestination(label: 'Chat', icon: Icons.chat_rounded),
    BottomNavDestination(label: 'Learn', icon: Icons.school_rounded),
    BottomNavDestination(label: 'Notes', icon: Icons.note_rounded),
    BottomNavDestination(label: 'Settings', icon: Icons.settings_rounded),
  ];

  final _dashboardTiles = const [
    DashboardTile(
      label: 'AI Chat',
      description: 'Ask anything',
      icon: Icons.smart_toy_rounded,
      route: '/chat',
      gradient: GradientInfo(InhaleColors.electricBlue, InhaleColors.violet),
    ),
    DashboardTile(
      label: 'School',
      description: 'Classes 1-10',
      icon: Icons.school_rounded,
      route: '/school',
      gradient: GradientInfo(InhaleColors.success, Color(0xFF27AE60)),
    ),
    DashboardTile(
      label: 'College',
      description: 'Higher education',
      icon: Icons.work_rounded,
      route: '/college',
      gradient: GradientInfo(Color(0xFFE67E22), Color(0xFFD35400)),
    ),
    DashboardTile(
      label: 'Writing',
      description: 'Assisted writing',
      icon: Icons.edit_note_rounded,
      route: '/writing',
      gradient: GradientInfo(InhaleColors.violet, Color(0xFF8E44AD)),
    ),
    DashboardTile(
      label: 'Coding',
      description: 'Code assistant',
      icon: Icons.code_rounded,
      route: '/coding',
      gradient: GradientInfo(InhaleColors.electricBlue, Color(0xFF2980B9)),
    ),
    DashboardTile(
      label: 'Mathematics',
      description: 'Calculations',
      icon: Icons.calculate_rounded,
      route: '/math',
      gradient: GradientInfo(Color(0xFF1ABC9C), Color(0xFF16A085)),
    ),
    DashboardTile(
      label: 'Quiz Studio',
      description: 'Test yourself',
      icon: Icons.quiz_rounded,
      route: '/quizzes',
      gradient: GradientInfo(InhaleColors.error, Color(0xFFC0392B)),
    ),
    DashboardTile(
      label: 'Exam Prep',
      description: 'Plan and practice exams',
      icon: Icons.schedule,
      route: '/exams',
      gradient: GradientInfo(InhaleColors.success, Color(0xFF4CAF50)),
    ),
    DashboardTile(
      label: 'Flashcards',
      description: 'Spaced repetition study',
      icon: Icons.auto_awesome_rounded,
      route: '/flashcards',
      gradient: GradientInfo(InhaleColors.electricBlue, InhaleColors.violet),
    ),
    DashboardTile(
      label: 'Study Plan',
      description: 'AI-powered schedule',
      icon: Icons.calendar_month_rounded,
      route: '/study-plan',
      gradient: GradientInfo(InhaleColors.blue, InhaleColors.pink),
    ),
    DashboardTile(
      label: 'Recommendations',
      description: 'Study suggestions',
      icon: Icons.recommend_rounded,
      route: '/recommendations',
      gradient: GradientInfo(InhaleColors.pink, InhaleColors.electricBlue),
    ),
    DashboardTile(
      label: 'Notes',
      description: 'Study workspace',
      icon: Icons.note_alt_rounded,
      route: '/notes',
      gradient: GradientInfo(Color(0xFFF39C12), Color(0xFFE67E22)),
    ),
    DashboardTile(
      label: 'AI Notes',
      description: 'Generate from topic, docs & video',
      icon: Icons.auto_awesome_rounded,
      route: '/ai-notes',
      gradient: GradientInfo(InhaleColors.pink, InhaleColors.electricBlue),
    ),
    DashboardTile(
      label: 'Translation',
      description: 'Multi-language',
      icon: Icons.translate_rounded,
      route: '/translation',
      gradient: GradientInfo(Color(0xFF8E44AD), InhaleColors.violet),
    ),
    DashboardTile(
      label: 'Language Learning',
      description: 'Practice speaking & vocab',
      icon: Icons.language_rounded,
      route: '/language-learning',
      gradient: GradientInfo(InhaleColors.success, InhaleColors.electricBlue),
    ),
    DashboardTile(
      label: 'Documents',
      description: 'PDF & files',
      icon: Icons.description_rounded,
      route: '/documents',
      gradient: GradientInfo(Color(0xFF2C3E50), Color(0xFF34495E)),
    ),
    DashboardTile(
      label: 'Voice',
      description: 'Speech assistant',
      icon: Icons.mic_rounded,
      route: '/voice',
      gradient: GradientInfo(Color(0xFFE91E63), Color(0xFFC2185B)),
    ),
    DashboardTile(
      label: 'Image Math Solver',
      description: 'Upload and solve',
      icon: Icons.image_rounded,
      route: '/math_solver',
      gradient: GradientInfo(Color(0xFF00BCD4), Color(0xFF0097A7)),
    ),
  ];

  void _onNavItemTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
      case 1:
        GoRouter.of(context).go('/chat');
      case 2:
        GoRouter.of(context).go('/school');
      case 3:
        GoRouter.of(context).go('/notes');
      case 4:
        GoRouter.of(context).go('/settings');
    }
  }

  void _onTileTap(String route) {
    GoRouter.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final reducedBlur = settings.maybeWhen(
      data: (s) => s.reducedBlur,
      orElse: () => false,
    );

    final layout =
        Responsive.isDesktop(context)
            ? _buildDesktop(context, reducedBlur)
            : _buildMobile(context, reducedBlur);

    return Scaffold(
      body: SafeArea(child: layout),
      bottomNavigationBar:
          Responsive.isDesktop(context)
              ? null
              : GlassBottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onNavItemTap,
                items:
                    _navDestinations
                        .map(
                          (d) =>
                              GlassBottomNavItem(label: d.label, icon: d.icon),
                        )
                        .toList(),
              ),
    );
  }

  Widget _buildDesktop(BuildContext context, bool reducedBlur) {
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
                label: 'School',
                icon: Icons.school_rounded,
                route: '/school',
              ),
              SidebarItem(
                label: 'Notes',
                icon: Icons.note_rounded,
                route: '/notes',
              ),
              SidebarItem(
                label: 'Settings',
                icon: Icons.settings_rounded,
                route: '/settings',
              ),
            ],
            currentIndex: _selectedIndex,
            onItemTap: (index, label) => _onNavItemTap(index),
          ),
        ),
        Expanded(child: _buildContent(context, reducedBlur)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context, bool reducedBlur) {
    return _buildContent(context, reducedBlur);
  }

  Widget _buildContent(BuildContext context, bool reducedBlur) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient:
            isDark
                ? InhaleColors.gradientBackgroundDark
                : InhaleColors.gradientBackground,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top:
                    Responsive.isMobile(context)
                        ? InhaleSpacing.md
                        : InhaleSpacing.xl,
                bottom: InhaleSpacing.md,
                left: InhaleSpacing.lg,
                right: InhaleSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: InhaleColors.gradientPrimary,
                          borderRadius: BorderRadius.circular(InhaleRadius.sm),
                          boxShadow: [
                            BoxShadow(
                              color: InhaleColors.electricBlue.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'I',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: InhaleSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good evening',
                              style: InhaleTypography.bodyMedium.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textSecondary
                                        : InhaleColors.lightTextSecondary,
                              ),
                            ),
                            Text(
                              'InhaleSkill AI',
                              style: InhaleTypography.displaySmall.copyWith(
                                color:
                                    isDark
                                        ? InhaleColors.textPrimary
                                        : InhaleColors.lightNavyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GlassStatusBadge(
                        label: 'AI Ready',
                        backgroundColor: InhaleColors.successSoft,
                        textColor: InhaleColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: InhaleSpacing.lg),
                  _buildHeroCard(context, isDark),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: InhaleSpacing.lg),
              child: GlassSearchBar(
                hintText: 'Ask anything...',
                onChanged: (_) {
                  if (_searchController.text.isNotEmpty) {
                    GoRouter.of(context).push('/chat');
                  }
                },
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.all(InhaleSpacing.lg),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: Responsive.crossAxisCount(
                  context,
                  mobile: 2,
                  tablet: 3,
                  desktop: 4,
                ),
                crossAxisSpacing: InhaleSpacing.md,
                mainAxisSpacing: InhaleSpacing.md,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final tile = _dashboardTiles[index];
                return GlassCard(
                  onTap: () => _onTileTap(tile.route),
                  padding: const EdgeInsets.all(InhaleSpacing.md),
                  elevated: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [tile.gradient.start, tile.gradient.end],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(InhaleRadius.sm),
                          boxShadow: [
                            BoxShadow(
                              color: tile.gradient.start.withValues(alpha: 0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(tile.icon, color: Colors.white, size: 28),
                      ),
                      const SizedBox(height: InhaleSpacing.sm),
                      Text(
                        tile.label,
                        style: InhaleTypography.titleMedium.copyWith(
                          color:
                              isDark
                                  ? InhaleColors.textPrimary
                                  : InhaleColors.lightNavyText,
                        ),
                      ),
                      Text(
                        tile.description,
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
              }, childCount: _dashboardTiles.length),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(InhaleSpacing.lg),
              child: GlassCard(
                padding: const EdgeInsets.all(InhaleSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatusItem(
                      icon: Icons.memory_rounded,
                      label: 'RAM',
                      value: '4GB+',
                      isDark: isDark,
                    ),
                    _StatusItem(
                      icon: Icons.storage_rounded,
                      label: 'Storage',
                      value: 'Free',
                      isDark: isDark,
                    ),
                    _StatusItem(
                      icon: Icons.model_training_rounded,
                      label: 'Model',
                      value: 'None',
                      isDark: isDark,
                    ),
                    _StatusItem(
                      icon: Icons.wifi_off_rounded,
                      label: 'Mode',
                      value: 'Offline',
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, bool isDark) {
    return GlassCard(
      padding: const EdgeInsets.all(InhaleSpacing.lg),
      elevated: true,
      glow: true,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Intelligence Hub',
                  style: InhaleTypography.headlineLarge.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textPrimary
                            : InhaleColors.lightNavyText,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.xs),
                Text(
                  'Your personal AI, ready whenever you are.',
                  style: InhaleTypography.bodyMedium.copyWith(
                    color:
                        isDark
                            ? InhaleColors.textSecondary
                            : InhaleColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: InhaleSpacing.md),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: InhaleColors.successSoft,
                        borderRadius: BorderRadius.circular(InhaleRadius.xs),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: InhaleColors.success,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'AI Model Ready',
                            style: InhaleTypography.labelSmall.copyWith(
                              color: InhaleColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: InhaleSpacing.sm),
                    Text(
                      'Offline',
                      style: InhaleTypography.labelSmall.copyWith(
                        color:
                            isDark
                                ? InhaleColors.textMuted
                                : InhaleColors.lightTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: InhaleSpacing.lg),
          const SizedBox(
            width: 80,
            height: 80,
            child: AIOrb(size: 80, isActive: true),
          ),
        ],
      ),
    );
  }
}

class GradientInfo {
  final Color start;
  final Color end;
  const GradientInfo(this.start, this.end);
}

class DashboardTile {
  final String label;
  final String description;
  final IconData icon;
  final String route;
  final GradientInfo gradient;
  const DashboardTile({
    required this.label,
    required this.description,
    required this.icon,
    required this.route,
    required this.gradient,
  });
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color:
              isDark
                  ? InhaleColors.electricBlue
                  : InhaleColors.lightPrimaryBlue,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: InhaleTypography.labelSmall.copyWith(
            color:
                isDark
                    ? InhaleColors.textMuted
                    : InhaleColors.lightTextSecondary,
          ),
        ),
        Text(
          value,
          style: InhaleTypography.titleSmall.copyWith(
            color:
                isDark ? InhaleColors.textPrimary : InhaleColors.lightNavyText,
          ),
        ),
      ],
    );
  }
}

class BottomNavDestination {
  final String label;
  final IconData icon;
  const BottomNavDestination({required this.label, required this.icon});
}
