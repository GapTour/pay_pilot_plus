import 'package:flutter/material.dart';

class AppSliverTabbedAppBar extends StatelessWidget {
  const AppSliverTabbedAppBar({
    required this.title,
    required this.infoWidget,
    required this.tabs,
    this.flexibleSpaceBackgroundColor,
    this.pinnedAppBarColor,
    this.expandedInfoHeight = 120.0,
    this.actions,
    super.key,
  });

  final String title;
  final Widget infoWidget;
  final List<Widget> tabs;
  final Color? flexibleSpaceBackgroundColor;
  final Color? pinnedAppBarColor;
  final double expandedInfoHeight;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color effectiveFlexibleBg =
        flexibleSpaceBackgroundColor ?? theme.colorScheme.surfaceContainer;
    final Color effectivePinnedBg =
        pinnedAppBarColor ?? theme.colorScheme.surface;

    // Calculates total expanded height: Toolbar + Expanded Info + TabBar
    final double totalExpandedHeight =
        kToolbarHeight + expandedInfoHeight + kMinInteractiveDimension;

    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      backgroundColor: effectivePinnedBg,
      surfaceTintColor: Colors.transparent,
      expandedHeight: totalExpandedHeight,
      actions: actions,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: ColoredBox(
          color: effectiveFlexibleBg,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(
                top: kToolbarHeight,
                bottom: kMinInteractiveDimension,
                // left: 16.0,
                // right: 16.0,
              ),
              child: OverflowBox(
                minHeight: 0.0,
                maxHeight: expandedInfoHeight,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: infoWidget,
                ),
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kMinInteractiveDimension),
        child: Material(
          color: effectivePinnedBg,
          child: TabBar(
            tabs: tabs,
            indicatorColor: theme.colorScheme.primary,
            labelColor: theme.colorScheme.onPrimary.withAlpha(100),
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
