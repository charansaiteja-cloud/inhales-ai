/// InhaleSkill AI — Premium Shared Layouts
/// Responsive layout shells for Desktop, Tablet, and Mobile
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/inhale_colors.dart';
import '../../core/theme/inhale_tokens.dart';
import '../widgets/app_sidebar.dart';

// ============================================================================
// RESPONSIVE BREAKPOINTS (mirroring existing responsive.dart)
// ============================================================================

const double _mobileBreakpoint = 720;
const double _tabletBreakpoint = 1100;

// ============================================================================
// LAYOUT BUILDER PROVIDER
// ============================================================================

class LayoutInfo {
  final double width;
  final double height;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;
  final bool isLandscape;

  const LayoutInfo({
    required this.width,
    required this.height,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
    required this.isLandscape,
  });

  static LayoutInfo fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    final isMobile = width < _mobileBreakpoint;
    final isTablet = width >= _mobileBreakpoint && width < _tabletBreakpoint;
    final isDesktop = width >= _tabletBreakpoint;
    final isLandscape = width > height;

    return LayoutInfo(
      width: width,
      height: height,
      isMobile: isMobile,
      isTablet: isTablet,
      isDesktop: isDesktop,
      isLandscape: isLandscape,
    );
  }
}

// ============================================================================
// RESPONSIVE LAYOUT WRAPPER
// ============================================================================

class ResponsiveLayout extends ConsumerWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget? mobileLandscape;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.mobileLandscape,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = LayoutInfo.fromConstraints(constraints);

        if (info.isDesktop) {
          return desktop;
        }
        if (info.isTablet) {
          return tablet ?? desktop;
        }
        if (info.isLandscape && mobileLandscape != null) {
          return mobileLandscape!;
        }
        return mobile;
      },
    );
  }
}

// ============================================================================
// DESKTOP LAYOUT (Sidebar + Content)
// ============================================================================

class DesktopLayout extends ConsumerStatefulWidget {
  final Widget child;
  final List<SidebarItem>? sidebarItems;
  final int selectedIndex;
  final ValueChanged<int>? onSidebarItemSelected;
  final bool sidebarCollapsed;
  final VoidCallback? onSidebarToggle;
  final Widget? header;
  final Widget? footer;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const DesktopLayout({
    super.key,
    required this.child,
    this.sidebarItems,
    this.selectedIndex = 0,
    this.onSidebarItemSelected,
    this.sidebarCollapsed = false,
    this.onSidebarToggle,
    this.header,
    this.footer,
    this.appBar,
    this.backgroundColor,
  });

  @override
  ConsumerState<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends ConsumerState<DesktopLayout> {
  bool _sidebarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _sidebarCollapsed = widget.sidebarCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final hasSidebar =
        widget.sidebarItems != null && widget.sidebarItems!.isNotEmpty;

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? cs.surface,
      body: Row(
        children: [
          // Sidebar
          if (hasSidebar)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              width: _sidebarCollapsed
                  ? AppSpacing.sidebarWidthCollapsed
                  : AppSpacing.sidebarWidth,
              child: AppSidebar(
                items: widget.sidebarItems!,
                selectedIndex: widget.selectedIndex,
                onItemSelected: widget.onSidebarItemSelected,
                isCollapsed: _sidebarCollapsed,
                onToggleCollapse: () =>
                    setState(() => _sidebarCollapsed = !_sidebarCollapsed),
                header: widget.header,
                footer: widget.footer,
              ),
            ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top App Bar
                if (widget.appBar != null)
                  widget.appBar!
                else
                  _buildDefaultAppBar(context, cs),
                // Content
                Expanded(
                  child: Container(color: cs.surface, child: widget.child),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar(
    BuildContext context,
    ColorScheme cs,
  ) {
    return AppBar(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightShadow
          : AppColors.lightShadow,
      toolbarHeight: AppSpacing.headerHeight,
      title: widget.header,
      actions: [
        if (widget.onSidebarToggle != null)
          IconButton(
            icon: Icon(
              _sidebarCollapsed
                  ? Icons.chevron_right_rounded
                  : Icons.chevron_left_rounded,
              color: cs.onSurfaceVariant,
            ),
            onPressed: widget.onSidebarToggle,
            tooltip: _sidebarCollapsed ? 'Expand sidebar' : 'Collapse sidebar',
          ),
      ],
    );
  }
}

// ============================================================================
// TABLET LAYOUT (Collapsible Sidebar + Content)
// ============================================================================

class TabletLayout extends ConsumerStatefulWidget {
  final Widget child;
  final List<SidebarItem>? sidebarItems;
  final int selectedIndex;
  final ValueChanged<int>? onSidebarItemSelected;
  final bool showSidebar;
  final VoidCallback? onSidebarToggle;
  final Widget? header;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  const TabletLayout({
    super.key,
    required this.child,
    this.sidebarItems,
    this.selectedIndex = 0,
    this.onSidebarItemSelected,
    this.showSidebar = false,
    this.onSidebarToggle,
    this.header,
    this.appBar,
    this.backgroundColor,
  });

  @override
  ConsumerState<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends ConsumerState<TabletLayout> {
  bool _showSidebar = false;

  @override
  void initState() {
    super.initState();
    _showSidebar = widget.showSidebar;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final hasSidebar =
        widget.sidebarItems != null && widget.sidebarItems!.isNotEmpty;

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? cs.surface,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Top App Bar
              if (widget.appBar != null)
                widget.appBar!
              else
                _buildDefaultAppBar(context, cs, hasSidebar),
              // Content
              Expanded(
                child: Container(color: cs.surface, child: widget.child),
              ),
            ],
          ),
          // Overlay Sidebar
          if (hasSidebar && _showSidebar)
            Positioned.fill(
              child: Material(
                color: cs.scrim.withValues(alpha: 0.5),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    AppSidebar(
                      items: widget.sidebarItems!,
                      selectedIndex: widget.selectedIndex,
                      onItemSelected: (index) {
                        widget.onSidebarItemSelected?.call(index);
                        setState(() => _showSidebar = false);
                      },
                      isCollapsed: false,
                      header: widget.header,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildDefaultAppBar(
    BuildContext context,
    ColorScheme cs,
    bool hasSidebar,
  ) {
    return AppBar(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightShadow
          : AppColors.lightShadow,
      toolbarHeight: AppSpacing.headerHeight,
      leading: hasSidebar
          ? IconButton(
              icon: Icon(Icons.menu_rounded, color: cs.onSurface),
              onPressed: () => setState(() => _showSidebar = true),
              tooltip: 'Open menu',
            )
          : null,
      title: widget.header,
      actions: [
        if (widget.onSidebarToggle != null)
          IconButton(
            icon: Icon(
              _showSidebar ? Icons.close_rounded : Icons.menu_rounded,
              color: cs.onSurfaceVariant,
            ),
            onPressed: widget.onSidebarToggle,
          ),
      ],
    );
  }
}

// ============================================================================
// MOBILE LAYOUT (Drawer Navigation + Bottom Nav)
// ============================================================================

class MobileLayout extends ConsumerStatefulWidget {
  final Widget child;
  final List<SidebarItem>? drawerItems;
  final List<BottomNavItem>? bottomNavItems;
  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;
  final int bottomNavIndex;
  final ValueChanged<int>? onBottomNavTap;
  final Widget? header;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool showBottomNav;
  final bool showAppBar;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const MobileLayout({
    super.key,
    required this.child,
    this.drawerItems,
    this.bottomNavItems,
    this.selectedIndex = 0,
    this.onItemSelected,
    this.bottomNavIndex = 0,
    this.onBottomNavTap,
    this.header,
    this.appBar,
    this.backgroundColor,
    this.showBottomNav = true,
    this.showAppBar = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  ConsumerState<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends ConsumerState<MobileLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final hasDrawer =
        widget.drawerItems != null && widget.drawerItems!.isNotEmpty;
    final hasBottomNav = widget.showBottomNav &&
        widget.bottomNavItems != null &&
        widget.bottomNavItems!.isNotEmpty;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: widget.backgroundColor ?? cs.surface,
      appBar: widget.showAppBar
          ? (widget.appBar ??
              _buildDefaultAppBar(context, cs, hasDrawer, widget.header))
          : null,
      drawer: hasDrawer
          ? AppNavigationDrawer(
              selectedIndex: widget.selectedIndex,
              onItemSelected: widget.onItemSelected ?? (_) {},
              items: widget.drawerItems!,
              header: widget.header,
            )
          : null,
      body: Container(color: cs.surface, child: widget.child),
      bottomNavigationBar: hasBottomNav
          ? AppBottomNavigationBar(
              currentIndex: widget.bottomNavIndex,
              onTap: widget.onBottomNavTap ?? (_) {},
              items: widget.bottomNavItems!,
            )
          : null,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation ??
          FloatingActionButtonLocation.endFloat,
    );
  }

  PreferredSizeWidget _buildDefaultAppBar(
    BuildContext context,
    ColorScheme cs,
    bool hasDrawer,
    Widget? header,
  ) {
    return AppBar(
      backgroundColor: cs.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.lightShadow
          : AppColors.lightShadow,
      toolbarHeight: AppSpacing.mobileTopBarHeight,
      leading: hasDrawer
          ? IconButton(
              icon: Icon(Icons.menu_rounded, color: cs.onSurface),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              tooltip: 'Open menu',
            )
          : null,
      title: header,
      centerTitle: false,
    );
  }
}

// ============================================================================
// ADAPTIVE LAYOUT (Automatically selects based on screen size)
// ============================================================================

class AdaptiveLayout extends ConsumerWidget {
  final Widget child;
  final List<SidebarItem>? navigationItems;
  final List<BottomNavItem>? bottomNavItems;
  final int selectedIndex;
  final ValueChanged<int>? onNavigationSelected;
  final int bottomNavIndex;
  final ValueChanged<int>? onBottomNavTap;
  final Widget? header;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final bool showBottomNavOnMobile;
  final FloatingActionButton? floatingActionButton;

  const AdaptiveLayout({
    super.key,
    required this.child,
    this.navigationItems,
    this.bottomNavItems,
    this.selectedIndex = 0,
    this.onNavigationSelected,
    this.bottomNavIndex = 0,
    this.onBottomNavTap,
    this.header,
    this.appBar,
    this.backgroundColor,
    this.showBottomNavOnMobile = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = LayoutInfo.fromConstraints(constraints);

        if (info.isDesktop) {
          return DesktopLayout(
            sidebarItems: navigationItems,
            selectedIndex: selectedIndex,
            onSidebarItemSelected: onNavigationSelected,
            header: header,
            appBar: appBar,
            backgroundColor: backgroundColor,
            child: child,
          );
        }

        if (info.isTablet) {
          return TabletLayout(
            sidebarItems: navigationItems,
            selectedIndex: selectedIndex,
            onSidebarItemSelected: onNavigationSelected,
            header: header,
            appBar: appBar,
            backgroundColor: backgroundColor,
            child: child,
          );
        }

        return MobileLayout(
          drawerItems: navigationItems,
          bottomNavItems: bottomNavItems,
          selectedIndex: selectedIndex,
          onItemSelected: onNavigationSelected,
          bottomNavIndex: bottomNavIndex,
          onBottomNavTap: onBottomNavTap,
          header: header,
          appBar: appBar,
          backgroundColor: backgroundColor,
          showBottomNav: showBottomNavOnMobile,
          floatingActionButton: floatingActionButton,
          child: child,
        );
      },
    );
  }
}

// ============================================================================
// RESPONSIVE GRID
// ============================================================================

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? mobileSpacing;
  final double? tabletSpacing;
  final double? desktopSpacing;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double childAspectRatio;
  final double? maxCrossAxisExtent;
  final EdgeInsetsGeometry? padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileSpacing,
    this.tabletSpacing,
    this.desktopSpacing,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.childAspectRatio = 1.0,
    this.maxCrossAxisExtent,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final info = LayoutInfo.fromConstraints(constraints);

        int crossAxisCount;
        double spacing;
        if (info.isDesktop) {
          crossAxisCount = desktopColumns;
          spacing = desktopSpacing ?? AppSpacing.gridGapLarge;
        } else if (info.isTablet) {
          crossAxisCount = tabletColumns;
          spacing = tabletSpacing ?? AppSpacing.gridGap;
        } else {
          crossAxisCount = mobileColumns;
          spacing = mobileSpacing ?? AppSpacing.gridGap;
        }

        return GridView.builder(
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }
}

// ============================================================================
// RESPONSIVE ROW (Flex layout that wraps)
// ============================================================================

class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final WrapAlignment wrapAlignment;
  final WrapCrossAlignment wrapCrossAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final double? minWidth;
  final double? maxWidth;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.spacing = AppSpacing.md,
    this.runSpacing = AppSpacing.md,
    this.wrapAlignment = WrapAlignment.start,
    this.wrapCrossAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.minWidth,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      crossAxisAlignment: wrapCrossAlignment,
      alignment: wrapAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: children.map((child) {
        if (minWidth != null || maxWidth != null) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: minWidth ?? 0,
              maxWidth: maxWidth ?? double.infinity,
            ),
            child: child,
          );
        }
        return child;
      }).toList(),
    );
  }
}

// ============================================================================
// RESPONSIVE VALUE HELPER
// ============================================================================

T responsiveValue<T>(
  BuildContext context, {
  required T mobile,
  T? tablet,
  required T desktop,
}) {
  final width = MediaQuery.of(context).size.width;
  if (width >= _tabletBreakpoint) return desktop;
  if (width >= _mobileBreakpoint) return tablet ?? desktop;
  return mobile;
}

double responsiveDouble(
  BuildContext context, {
  required double mobile,
  double? tablet,
  required double desktop,
}) {
  return responsiveValue(
    context,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}

EdgeInsets responsivePadding(
  BuildContext context, {
  required EdgeInsets mobile,
  EdgeInsets? tablet,
  required EdgeInsets desktop,
}) {
  return responsiveValue(
    context,
    mobile: mobile,
    tablet: tablet,
    desktop: desktop,
  );
}
