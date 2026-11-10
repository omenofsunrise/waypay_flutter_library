import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import '../layout/surface_card.dart';
import 'status_badge.dart';

class WayPayEntityTile extends StatelessWidget {
  const WayPayEntityTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.manrope(size: 16, weight: FontWeight.w600),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.manrope(
                        size: 13,
                        weight: FontWeight.w400,
                        color: const Color(AppColors.uiBorder),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
            if (showChevron) ...[
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Color(AppColors.uiBorder)),
            ],
          ],
        ),
      ),
    );
  }
}

class WayPayIconText extends StatelessWidget {
  const WayPayIconText({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    this.padding = const EdgeInsets.only(bottom: 8),
  });

  final IconData icon;
  final String text;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? const Color(AppColors.uiBorder);
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: effectiveColor),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text.isEmpty ? '—' : text,
              style: AppStyle.manrope(
                size: 14,
                weight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WayPayOperationTile extends StatelessWidget {
  const WayPayOperationTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.status,
    this.statusTone = WayPayStatusTone.info,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String? status;
  final WayPayStatusTone statusTone;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      onTap: onTap,
      showShadow: false,
      showBorder: true,
      padding: const EdgeInsets.all(14),
      child: WayPayEntityTile(
        title: title,
        subtitle: subtitle,
        padding: EdgeInsets.zero,
        trailing: status == null
            ? trailing
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WayPayStatusBadge(text: status!, tone: statusTone),
                  if (trailing != null) ...[
                    const SizedBox(width: 6),
                    trailing!,
                  ],
                ],
              ),
      ),
    );
  }
}
