/// InhaleSkill AI — Premium Shared Widgets
/// Empty states, loading states, error states
library;

import 'package:flutter/material.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import 'app_button.dart';
import 'app_card.dart';

// ============================================================================
// APP EMPTY STATE
// ============================================================================

class AppEmptyState extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? message;
  final Widget? action;
  final EdgeInsetsGeometry? padding;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const AppEmptyState({
    super.key,
    this.icon,
    required this.title,
    this.message,
    this.action,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Padding(
      padding: padding ?? AppSpacing.pagePaddingLargeInsets,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: cs.primaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
            ),
            child: Center(
              child: icon ??
                  Icon(Icons.inbox_rounded, size: 40, color: cs.primary),
            ),
          ),
          SizedBox(height: AppSpacing.xl),
          // Title
          Text(
            title,
            style: AppTypography.h2.copyWith(
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          // Message
          if (message != null) ...[
            SizedBox(height: AppSpacing.sm),
            Text(
              message!,
              style: AppTypography.body.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
          // Action
          if (action != null) ...[SizedBox(height: AppSpacing.xl), action!],
        ],
      ),
    );
  }
}

// ============================================================================
// APP LOADING STATE (Skeleton)
// ============================================================================

class AppSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration animationDuration;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = widget.baseColor ??
        (isDark
            ? AppColors.darkSurfaceContainer
            : AppColors.lightSurfaceContainer);
    final highlightColor = widget.highlightColor ??
        (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(baseColor, highlightColor, _animation.value),
            borderRadius: widget.borderRadius ??
                BorderRadius.circular(AppRadius.cardRadius),
          ),
        );
      },
    );
  }
}

// Skeleton variants
class AppSkeletonText extends StatelessWidget {
  final int lines;
  final double? width;
  final double lineHeight;
  final double spacing;

  const AppSkeletonText({
    super.key,
    this.lines = 3,
    this.width,
    this.lineHeight = 16,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lines, (index) {
        final isLast = index == lines - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
          child: AppSkeleton(
            width: isLast && width != null ? width! * 0.6 : width,
            height: lineHeight,
            borderRadius: BorderRadius.circular(AppRadius.buttonSmallRadius),
          ),
        );
      }),
    );
  }
}

class AppSkeletonCard extends StatelessWidget {
  final double? width;
  final double? height;
  final bool showAvatar;
  final bool showAction;
  final int textLines;

  const AppSkeletonCard({
    super.key,
    this.width,
    this.height,
    this.showAvatar = true,
    this.showAction = false,
    this.textLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: AppSpacing.cardPaddingInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (showAvatar)
                AppSkeleton(
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
                ),
              if (showAvatar) SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: 120, height: 16),
                    SizedBox(height: AppSpacing.xs),
                    AppSkeleton(width: 80, height: 12),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          AppSkeletonText(lines: textLines),
          if (showAction) ...[
            SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                AppSkeleton(
                  width: 100,
                  height: 36,
                  borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                ),
                SizedBox(width: AppSpacing.sm),
                AppSkeleton(
                  width: 100,
                  height: 36,
                  borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class AppSkeletonChatMessage extends StatelessWidget {
  final bool isUser;

  const AppSkeletonChatMessage({super.key, this.isUser = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.chatMessagePaddingInsets,
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            AppSkeleton(
              width: 32,
              height: 32,
              borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
            ),
            SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                AppSkeleton(
                  width: 180,
                  height: 20,
                  borderRadius: BorderRadius.circular(
                    AppRadius.buttonSmallRadius,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                AppSkeletonText(lines: 3),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: AppSpacing.sm),
            AppSkeleton(
              width: 32,
              height: 32,
              borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
            ),
          ],
        ],
      ),
    );
  }
}

class AppSkeletonList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final bool showAvatar;
  final int textLines;

  const AppSkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.showAvatar = true,
    this.textLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) =>
          AppSkeletonCard(showAvatar: showAvatar, textLines: textLines),
    );
  }
}

// ============================================================================
// APP LOADING INDICATOR
// ============================================================================

class AppLoadingIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? backgroundColor;
  final double value; // For determinate progress (0.0 to 1.0)

  const AppLoadingIndicator({
    super.key,
    this.size = 24,
    this.strokeWidth = 3,
    this.color,
    this.backgroundColor,
    this.value = -1, // -1 = indeterminate
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    if (value >= 0) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value.clamp(0.0, 1.0),
          strokeWidth: strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? cs.primary),
          backgroundColor: backgroundColor ?? cs.surfaceContainerHighest,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? cs.primary),
        backgroundColor: backgroundColor ?? cs.surfaceContainerHighest,
      ),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? barrierColor;

  const AppLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.barrierColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: barrierColor ?? cs.surface.withValues(alpha: 0.7),
              child: Center(
                child: AppCard(
                  padding: EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppLoadingIndicator(size: 40, strokeWidth: 4),
                      if (message != null) ...[
                        SizedBox(height: AppSpacing.lg),
                        Text(
                          message!,
                          style: AppTypography.body.copyWith(
                            color: cs.onSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================================
// APP ERROR STATE
// ============================================================================

class AppErrorState extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? icon;
  final VoidCallback? onRetry;
  final String? retryLabel;
  final EdgeInsetsGeometry? padding;

  const AppErrorState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.onRetry,
    this.retryLabel = 'Try Again',
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppEmptyState(
      icon: icon ??
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: cs.errorContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
            ),
            child: Icon(Icons.error_outline_rounded, size: 40, color: cs.error),
          ),
      title: title,
      message: message,
      action: onRetry != null
          ? AppButton(
              label: retryLabel,
              variant: AppButtonVariant.primary,
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 18),
            )
          : null,
      padding: padding,
    );
  }
}

// ============================================================================
// APP SUCCESS STATE
// ============================================================================

class AppSuccessState extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? icon;
  final Widget? action;
  final EdgeInsetsGeometry? padding;

  const AppSuccessState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.action,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppEmptyState(
      icon: icon ??
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: cs.tertiaryContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
            ),
            child: Icon(
              Icons.check_circle_rounded,
              size: 40,
              color: cs.tertiary,
            ),
          ),
      title: title,
      message: message,
      action: action,
      padding: padding,
    );
  }
}

// ============================================================================
// APP OFFLINE STATE
// ============================================================================

class AppOfflineState extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final EdgeInsetsGeometry? padding;

  const AppOfflineState({super.key, this.message, this.onRetry, this.padding});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AppEmptyState(
      icon: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: cs.secondaryContainer.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.avatarRadius),
        ),
        child: Icon(Icons.wifi_off_rounded, size: 40, color: cs.secondary),
      ),
      title: 'You\'re Offline',
      message: message ??
          'No internet connection. Some features may be unavailable.',
      action: onRetry != null
          ? AppButton(
              label: 'Retry Connection',
              variant: AppButtonVariant.primary,
              onPressed: onRetry,
              icon: const Icon(Icons.wifi_rounded, size: 18),
            )
          : null,
      padding: padding,
    );
  }
}
