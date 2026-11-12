/// InhaleSkill AI — Premium Splash Screen
/// Professional loading screen with brand identity and subtle animation.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/routing/app_routes.dart';
import '../../core/constants/app_constants.dart';
import '../settings/settings_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _orbController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _orbRotation;

  @override
  void initState() {
    super.initState();

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOutCubic,
    );

    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    // Orb rotation
    _orbController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
    _orbRotation = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(CurvedAnimation(parent: _orbController, curve: Curves.linear));

    // Start animations
    _fadeController.forward();
    _scaleController.forward();

    // Navigate after delay
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    // Wait for animations
    await Future.delayed(const Duration(milliseconds: 1500));

    // Check onboarding status
    final settings = ref.read(settingsProvider);
    settings.whenData((appSettings) {
      // For now, navigate to home directly
      // In future: check if onboarding completed
      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _orbController.dispose();
    super.dispose();
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
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo Orb
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: AnimatedBuilder(
                      animation: _orbRotation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _orbRotation.value *
                              0.0174533, // degrees to radians
                          child: _buildOrbLogo(cs, isDark),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: AppSpacing.xxl),
                  // App Name
                  Text(
                    AppConstants.appName,
                    style: AppTypography.pageTitle.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.sm),
                  // Tagline
                  Text(
                    AppConstants.tagline,
                    style: AppTypography.bodyLarge.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSpacing.xxl),
                  // Loading indicator
                  _buildLoadingIndicator(cs),
                  SizedBox(height: AppSpacing.xl),
                  // Subtle message
                  Text(
                    'Your intelligence. Your device. Your possibilities.',
                    style: AppTypography.caption.copyWith(
                      color: cs.onSurfaceVariant.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrbLogo(ColorScheme cs, bool isDark) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient:
            isDark ? AppColors.primaryGradientDark : AppColors.primaryGradient,
        boxShadow: isDark
            ? [
                ...AppShadows.darkPrimaryGlow,
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ]
            : [
                ...AppShadows.primaryGlow,
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
      ),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: cs.surface,
            boxShadow: isDark ? AppShadows.darkLevel3 : AppShadows.level3,
          ),
          child: Center(
            child: Icon(Icons.psychology_rounded, size: 40, color: cs.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(ColorScheme cs) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer ring
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                cs.primary.withValues(alpha: 0.3),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          // Inner spinning ring
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
