import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pay_pilot_plus/core/utils/extensions/context_extension.dart';

class AppSliverTabbedAppBar extends StatefulWidget {
  const AppSliverTabbedAppBar({
    required this.title,
    required this.infoWidget,
    required this.tabs,
    this.flexibleSpaceBackgroundColor,
    this.pinnedAppBarColor,
    this.expandedInfoHeight,
    this.actions,
    super.key,
  });

  final String title;
  final Widget infoWidget;
  final List<Widget>? tabs;
  final Color? flexibleSpaceBackgroundColor;
  final Color? pinnedAppBarColor;
  final double? expandedInfoHeight;
  final List<Widget>? actions;

  @override
  State<AppSliverTabbedAppBar> createState() => _AppSliverTabbedAppBarState();
}

class _AppSliverTabbedAppBarState extends State<AppSliverTabbedAppBar> {
  final GlobalKey _bannerKey = GlobalKey();
  double _bannerHeight = 120.0; // Fallback initial height
  bool _isHeightCalculated = false;

  void _updateBannerHeight() {
    final context = _bannerKey.currentContext;
    if (context != null && !_isHeightCalculated) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null && renderBox.hasSize) {
        final height = renderBox.size.height;
        if (height > 0 && height != _bannerHeight) {
          setState(() {
            _bannerHeight = height;
            _isHeightCalculated = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    context.onPostFrame(() {
      if (widget.expandedInfoHeight != null) return;
      _updateBannerHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.expandedInfoHeight != null) return;
      _updateBannerHeight();
    });

    final ThemeData theme = Theme.of(context);
    final Color effectiveFlexibleBg =
        widget.flexibleSpaceBackgroundColor ??
        theme.colorScheme.surfaceContainer;
    final Color effectivePinnedBg =
        widget.pinnedAppBarColor ?? theme.colorScheme.surface;

    // Calculates total expanded height: Toolbar + Expanded Info + TabBar
    final double totalExpandedHeight =
        kToolbarHeight +
        (widget.expandedInfoHeight ?? _bannerHeight) +
        (widget.tabs == null
            ? 0
            : (widget.tabs == null ? 0 : kMinInteractiveDimension));

    return SliverAppBar(
      pinned: false,
      floating: true,
      snap: true,
      backgroundColor: effectivePinnedBg,
      surfaceTintColor: Colors.transparent,
      expandedHeight: totalExpandedHeight,
      actions: widget.actions,
      title: Text(
        widget.title,
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
              padding: EdgeInsets.only(
                top: kToolbarHeight,
                bottom: (widget.tabs == null ? 0 : kMinInteractiveDimension),
                // left: 16.0,
                // right: 16.0,
              ),
              child: OverflowBox(
                minHeight: 0.0,
                maxHeight: widget.expandedInfoHeight,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: KeyedSubtree(
                    key: _bannerKey,
                    child: widget.infoWidget,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottom: widget.tabs == null
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kMinInteractiveDimension),
              child: Material(
                color: effectivePinnedBg,
                child: TabBar(
                  tabs: widget.tabs!,
                  indicatorColor: theme.colorScheme.primary,
                  labelColor: theme.colorScheme.onSurface,
                  unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
    );
  }
}
