import 'package:flutter/material.dart';
import 'package:pay_pilot_plus/core/widgets/app_elevated_button.dart';

/// دکمه منو با آیکن و عنوان؛ برای شبکه‌های صفحه اصلی و تنظیمات
class AppMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool isSelected;
  const AppMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // AppElevatedButton یک GestureDetector است و نقش دکمه را اعلام نمی‌کند
    return Semantics(
      button: true,
      enabled: onTap != null && !isSelected,
      label: title,
      excludeSemantics: true,
      child: AppElevatedButton(
        onTap: onTap,
        isSelected: isSelected,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 8,
            children: [
              Icon(icon, size: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// عنوان یک گروه و شبکه دکمه‌هایش
class AppMenuSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const AppMenuSection({
    required this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            // کمی بلندتر از مربع تا عنوان‌های دوخطی جا شوند
            childAspectRatio: 0.85,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: children,
        ),
      ],
    );
  }
}
