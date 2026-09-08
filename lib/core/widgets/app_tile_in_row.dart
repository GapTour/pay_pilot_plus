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

class _AppTileInRowState extends State<AppTileInRow> {
  bool _isExpanded = false;
  bool _showChild = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: widget.isActive && widget.child != null
          ? () {
              _isExpanded = !_isExpanded;
              if (!_isExpanded) {
                _showChild = false;
              }
              setState(() {});
            }
          : null,
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
            Gap(5),
            Padding(
              padding: widget.padding,
              child: Row(
                children: [
                  Expanded(child: widget.parent),
                  if (widget.onPreview != null)
                    AppElevatedButton(
                      onTap: widget.onPreview,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.menu, size: 16),
                      ),
                    ),
                  if (widget.onEdit != null)
                    AppElevatedButton(
                      onTap: widget.onEdit,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
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
            Gap(5),
            AnimatedContainer(
              height: !_isExpanded ? 0 : 59,
              duration: Duration(milliseconds: 150),
              curve: Curves.linear,
              onEnd: () {
                if (!_showChild && _isExpanded) {
                  _showChild = true;
                  setState(() {});
                }
              },

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_showChild) ...[
                    Gap(5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: widget.child,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
