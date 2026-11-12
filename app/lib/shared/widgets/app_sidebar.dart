/// InhaleSkill AI — Premium Shared Widgets
/// Sidebar, Header, Navigation components
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../../core/theme/inhale_typography.dart';
import '../../core/routing/app_router.dart';
import 'app_card.dart';

// ============================================================================
// APP SIDEBAR
// ============================================================================

class AppSidebar extends ConsumerStatefulWidget {
  final Widget? header;
  final Widget? footer;
  final List<SidebarItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final bool isCollapsed;
  final VoidCallback? onToggleCollapse;
  final double width;
  final double collapsedWidth;
  final Color? backgroundColor;
  final Color? dividerColor;

  const AppSidebar({
    super.key,
    this.header,
    this.footer,
    required this.items,
    required this.selectedIndex,
    this.onItemSelected,
    this.isCollapsed = false,
    this.onToggleCollapse,
    this.width = AppSpacing.sidebarWidth,
    this.collapsedWidth = AppSpacing.sidebarWidthCollapsed,
    this.backgroundColor,
    this.dividerColor,
  });

  @override
  ConsumerState<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends ConsumerState<AppSidebar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _widthAnimation = Tween<double>(
      begin: widget.collapsedWidth,
      end: widget.width,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );

    if (!widget.isCollapsed) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant AppSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCollapsed != oldWidget.isCollapsed) {
      if (widget.isCollapsed) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final currentWidth = _widthAnimation.value;
        final showLabels = _animationController.value > 0.5;

        return Container(
          width: currentWidth,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? cs.surface,
            border: Border(
              right: BorderSide(
                color: widget.dividerColor ?? cs.outlineVariant,
                width: 1,
              ),
            ),
            boxShadow: isDark ? AppShadows.darkDrawer : AppShadows.drawer,
          ),
          child: Column(
            children: [
              // Header
              _buildHeader(currentWidth, showLabels, cs, isDark),
              // Navigation items
              Expanded(
                child: _buildNavigationItems(currentWidth, showLabels, cs),
              ),
              // Footer
              _buildFooter(currentWidth, showLabels, cs),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    double width,
    bool showLabels,
    ColorScheme cs,
    bool isDark,
  ) {
    if (widget.header != null) {
      return SizedBox(width: width, child: widget.header!);
    }

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: isDark
                  ? AppColors.primaryGradientDark
                  : AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
            ),
            child: const Center(
              child: Icon(
                Icons.psychology_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          if (showLabels) ...[
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'InhaleSkill AI',
                    style: AppTypography.titleMedium.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Your AI Workspace',
                    style: AppTypography.labelSmall.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
          if (!widget.isCollapsed && widget.onToggleCollapse != null)
            IconButton(
              icon: Icon(
                widget.isCollapsed
                    ? Icons.chevron_right_rounded
                    : Icons.chevron_left_rounded,
                size: 20,
                color: cs.onSurfaceVariant,
              ),
              onPressed: widget.onToggleCollapse,
              tooltip:
                  widget.isCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
            ),
        ],
      ),
    );
  }

  Widget _buildNavigationItems(double width, bool showLabels, ColorScheme cs) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: widget.items.length,
      separatorBuilder: (context, index) => SizedBox(height: AppSpacing.xs),
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = widget.selectedIndex == index;
        return _SidebarItemTile(
          item: item,
          isSelected: isSelected,
          showLabel: showLabels,
          width: width,
          onTap: () => widget.onItemSelected?.call(index),
        );
      },
    );
  }

  Widget _buildFooter(double width, bool showLabels, ColorScheme cs) {
    if (widget.footer != null) {
      return SizedBox(width: width, child: widget.footer!);
    }

    return Container(
      width: width,
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: cs.outlineVariant, width: 1)),
      ),
      child: Column(
        children: [
          // Collapse toggle
          if (widget.onToggleCollapse != null)
            InkWell(
              onTap: widget.onToggleCollapse,
              borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isCollapsed
                          ? Icons.chevron_right_rounded
                          : Icons.chevron_left_rounded,
                      size: 20,
                      color: cs.onSurfaceVariant,
                    ),
                    if (showLabels) ...[
                      SizedBox(width: AppSpacing.md),
                      Text(
                        widget.isCollapsed ? 'Expand' : 'Collapse',
                        style: AppTypography.bodyMedium.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          // Settings link
          if (showLabels) ...[
            SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: () => context.go('/settings'),
              borderRadius: BorderRadius.circular(AppRadius.buttonRadius),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_rounded,
                      size: 20,
                      color: cs.onSurfaceVariant,
                    ),
                    SizedBox(width: AppSpacing.md),
                    Text(
                      'Settings',
                      style: AppTypography.bodyMedium.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarItemTile extends StatelessWidget {
  final SidebarItem item;
  final bool isSelected;
  final bool showLabel;
  final double width;
  final VoidCallback onTap;

  const _SidebarItemTile({
    required this.item,
    required this.isSelected,
    required this.showLabel,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sidebarItemRadius),
      splashColor: cs.primary.withValues(alpha: 0.08),
      highlightColor: cs.primary.withValues(alpha: 0.04),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primaryContainer.withValues(alpha: 0.5)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sidebarItemRadius),
          border: isSelected
              ? Border.all(
                  color: cs.primary.withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          children: [
            IconTheme(
              data: IconThemeData(
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
                size: 22,
              ),
              child: item.icon,
            ),
            if (showLabel) ...[
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  item.label,
                  style: AppTypography.bodyMedium.copyWith(
                    color: isSelected ? cs.primary : cs.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.badge != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.badgeRadius),
                  ),
                  child: Text(
                    item.badge!,
                    style: AppTypography.labelSmall.copyWith(
                      color: cs.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class SidebarItem {
  final String label;
  final Widget icon;
  final String? badge;
  final String? route;

  const SidebarItem({
    required this.label,
    required this.icon,
    this.badge,
    this.route,
  });
}

// ============================================================================
// APP HEADER (Top App Bar)
// ============================================================================

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final double elevation;
  final bool centerTitle;
  final bool showSearch;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchTap;
  final String? searchHint;
  final TextEditingController? searchController;
  final bool automaticallyImplyLeading;

  const AppHeader({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.backgroundColor,
    this.surfaceTintColor,
    this.elevation = 0,
    this.centerTitle = false,
    this.showSearch = false,
    this.onSearchChanged,
    this.onSearchTap,
    this.searchHint,
    this.searchController,
    this.automaticallyImplyLeading = true,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;
    final router = ref.watch(appRouterProvider);
    final effectiveLeading = leading ??
        (automaticallyImplyLeading && router.canPop()
            ? IconButton(
                icon: Icon(Icons.arrow_back_rounded, color: cs.onSurface),
                onPressed: () => router.pop(),
                tooltip: 'Back',
              )
            : null);

    final effectiveActions = <Widget>[
      if (showSearch) ...[
        SizedBox(
          width: 280,
          child: AppSearchField(
            controller: searchController,
            hint: searchHint ?? 'Search...',
            onChanged: onSearchChanged,
            onTap: onSearchTap,
            onSubmitted: onSearchChanged,
            leadingIcon: Icon(
              Icons.search_rounded,
              size: 20,
              color: cs.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
        ),
        SizedBox(width: AppSpacing.md),
      ],
      if (actions != null) ...actions!,
    ];

    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: AppTypography.titleLarge.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
      leading: effectiveLeading,
      actions: effectiveActions,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      backgroundColor: backgroundColor ?? cs.surface,
      surfaceTintColor: surfaceTintColor ?? Colors.transparent,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: AppSpacing.headerHeight,
      scrolledUnderElevation: 1,
      shadowColor: isDark ? AppColors.darkShadow : AppColors.lightShadow,
    );
  }
}

// ============================================================================
// APP BOTTOM NAVIGATION BAR
// ============================================================================

class AppBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double height;
  final double elevation;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.height = AppSpacing.bottomNavHeight,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? cs.surface,
        border: Border(top: BorderSide(color: cs.outlineVariant, width: 1)),
        boxShadow: isDark ? AppShadows.darkLevel2 : AppShadows.level2,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = currentIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                splashColor: cs.primary.withValues(alpha: 0.08),
                highlightColor: cs.primary.withValues(alpha: 0.04),
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          color: isSelected
                              ? (selectedItemColor ?? cs.primary)
                              : (unselectedItemColor ?? cs.onSurfaceVariant),
                          size: 24,
                        ),
                        child: isSelected
                            ? item.activeIcon ?? item.icon
                            : item.icon,
                      ),
                      SizedBox(height: AppSpacing.xs),
                      Text(
                        item.label,
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected
                              ? (selectedItemColor ?? cs.primary)
                              : (unselectedItemColor ?? cs.onSurfaceVariant),
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String label;
  final Widget icon;
  final Widget? activeIcon;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}

// ============================================================================
// APP NAVIGATION DRAWER (Mobile)
// ============================================================================

class AppNavigationDrawer extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<SidebarItem> items;
  final Widget? header;
  final Widget? footer;
  final double width;

  const AppNavigationDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
    this.header,
    this.footer,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cs = theme.colorScheme;

    return Drawer(
      width: width,
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            header ??
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: cs.outlineVariant, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: isDark
                              ? AppColors.primaryGradientDark
                              : AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(
                            AppRadius.buttonRadius,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.psychology_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'InhaleSkill AI',
                              style: AppTypography.titleLarge.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Your AI Workspace',
                              style: AppTypography.bodySmall.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            // Navigation items
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                itemCount: items.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedIndex == index;
                  return ListTile(
                    leading: IconTheme(
                      data: IconThemeData(
                        color: isSelected ? cs.primary : cs.onSurfaceVariant,
                        size: 24,
                      ),
                      child: item.icon,
                    ),
                    title: Text(
                      item.label,
                      style: AppTypography.bodyMedium.copyWith(
                        color: isSelected ? cs.primary : cs.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                    trailing: item.badge != null
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: cs.primaryContainer,
                              borderRadius: BorderRadius.circular(
                                AppRadius.badgeRadius,
                              ),
                            ),
                            child: Text(
                              item.badge!,
                              style: AppTypography.labelSmall.copyWith(
                                color: cs.onPrimaryContainer,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : null,
                    selected: isSelected,
                    selectedTileColor: cs.primaryContainer.withValues(
                      alpha: 0.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppRadius.sidebarItemRadius,
                      ),
                    ),
                    onTap: () {
                      onItemSelected(index);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            // Footer
            footer ??
                Container(
                  padding: EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: cs.outlineVariant, width: 1),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings_rounded,
                      color: cs.onSurfaceVariant,
                    ),
                    title: Text(
                      'Settings',
                      style: AppTypography.bodyMedium.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      context.go('/settings');
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
