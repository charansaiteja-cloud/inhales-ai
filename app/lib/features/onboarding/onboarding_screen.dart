/// InhaleSkill AI — Onboarding Screen (Placeholder)
/// Simple skip-to-home onboarding. Can be extended with multi-page flow later.
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../shared/widgets/app_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.psychology_rounded,
      title: 'Your Private AI Assistant',
      description:
          'Powerful AI that runs entirely on your device. No internet required.',
    ),
    _OnboardingPage(
      icon: Icons.school_rounded,
      title: 'Learn Anything',
      description:
          'Get explanations, generate study notes, and create quizzes for any subject.',
    ),
    _OnboardingPage(
      icon: Icons.code_rounded,
      title: 'Code & Create',
      description:
          'Generate code, debug issues, write content, and translate languages.',
    ),
    _OnboardingPage(
      icon: Icons.security_rounded,
      title: '100% Offline & Private',
      description:
          'Your data never leaves your device. Complete privacy and control.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    // TODO: Persist onboarding completion in settings
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.darkBackground,
                    AppColors.darkSurface,
                    AppColors.darkBackground,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lightBackground,
                    AppColors.lightSurface,
                    AppColors.lightBackground,
                  ],
                ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: AppButton(
                    label: 'Skip',
                    variant: AppButtonVariant.text,
                    onPressed: _completeOnboarding,
                  ),
                ),
              ),
              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return Padding(
                      padding: EdgeInsets.all(AppSpacing.xxl),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: isDark
                                  ? AppColors.primaryGradientDark
                                  : AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(
                                AppRadius.xxxl,
                              ),
                              boxShadow: isDark
                                  ? AppShadows.darkPrimaryGlow
                                  : AppShadows.primaryGlow,
                            ),
                            child: Icon(
                              page.icon,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xxxl),
                          Text(
                            page.title,
                            style: AppTypography.headlineMedium.copyWith(
                              color: cs.onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppSpacing.lg),
                          Text(
                            page.description,
                            style: AppTypography.bodyLarge.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                    width: _currentPage == index ? 32 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? cs.primary
                          : cs.outlineVariant,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xxl),
              // Next/Get Started button
              Padding(
                padding: EdgeInsets.all(AppSpacing.xl),
                child: AppButton(
                  label: _currentPage == _pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  variant: AppButtonVariant.primary,
                  size: AppButtonSize.large,
                  isFullWidth: true,
                  onPressed: _nextPage,
                  trailingIcon: Icon(
                    _currentPage == _pages.length - 1
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });
}
