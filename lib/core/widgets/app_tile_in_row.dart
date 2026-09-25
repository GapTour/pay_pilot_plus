import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pay_pilot_plus/core/utils/theme/app_theme.dart';
import 'package:pay_pilot_plus/core/widgets/app_delete_dialog.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

class AppTileInRow extends StatefulWidget {
  final Widget parent;
  final Widget? child;
  final VoidCallback? onPreview;
  final String? previewButtonTitle;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isActive;
  final EdgeInsets padding;

  const AppTileInRow({
    required this.parent,
    this.child,
    this.isActive = true,
    this.onEdit,
    this.onPreview,
    this.previewButtonTitle,
    this.onDelete,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
    super.key,
  });

  @override
  State<AppTileInRow> createState() => _AppTileInRowState();
}

class _AppTileInRowState extends State<AppTileInRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    if (!widget.isActive || widget.child == null) return;

    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.isActive && widget.child != null ? _toggleExpansion : null,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: kPrimaryContainerColor, blurRadius: 1.5),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(5),
            Padding(
              padding: widget.padding,
              child: Row(
                children: [
                  Expanded(child: widget.parent),
                  if (widget.onPreview != null)
                    AppElevatedButton(
                      onTap: widget.onPreview,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.menu, size: 16),
                      ),
                    ),
                  if (widget.onEdit != null)
                    AppElevatedButton(
                      onTap: widget.onEdit,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.edit, size: 16),
                      ),
                    ),
                  if (widget.onDelete != null)
                    AppElevatedButton(
                      onTap: () {
                        AppDeleteDialog.showDefault(
                          context,
                          onDelete: () {
                            widget.onDelete!.call();
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: kErrorColor,
                          size: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Gap(5),
            if (widget.child != null)
              SizeTransition(
                sizeFactor: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12.0,
                        left: 12,
                        bottom: 8,
                      ),
                      child: widget.child!,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
