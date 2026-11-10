import 'package:flutter/material.dart';

import '../layout/surface_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';
import 'entity_tile.dart';
import 'info_item.dart';

class WayPayCardAction {
  const WayPayCardAction({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final bool isDestructive;
}

class WayPayIconBadge extends StatelessWidget {
  const WayPayIconBadge({
    super.key,
    required this.icon,
    this.foregroundColor = const Color(AppColors.primary),
    this.backgroundColor = const Color(0xFFE6F5F3),
  });

  final IconData icon;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: SizedBox.square(
        dimension: 44,
        child: Icon(icon, size: 22, color: foregroundColor),
      ),
    );
  }
}

class WayPayEntityCard extends StatelessWidget {
  const WayPayEntityCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.details = const [],
    this.detailColumns = 2,
    this.actions = const [],
    this.onTap,
    this.backgroundColor = const Color(AppColors.white),
    this.showShadow = true,
  }) : assert(detailColumns > 0);

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget> details;
  final int detailColumns;
  final List<WayPayCardAction> actions;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      showShadow: showShadow,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WayPayEntityTile(
                    title: title,
                    subtitle: subtitle,
                    leading: leading,
                    trailing: trailing,
                    showChevron: onTap != null && trailing == null,
                    padding: EdgeInsets.zero,
                  ),
                  if (details.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.lg),
                    WayPayInfoGrid(columns: detailColumns, children: details),
                  ],
                ],
              ),
            ),
          ),
          if (actions.isNotEmpty) ...[
            const Divider(height: 1, color: Color(0xFFEEF1F4)),
            Row(
              children: [
                for (var index = 0; index < actions.length; index++) ...[
                  if (index > 0)
                    const SizedBox(
                      width: 1,
                      height: 24,
                      child: ColoredBox(color: Color(0xFFEEF1F4)),
                    ),
                  Expanded(child: _WayPayCardActionButton(actions[index])),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _WayPayCardActionButton extends StatelessWidget {
  const _WayPayCardActionButton(this.action);

  final WayPayCardAction action;

  @override
  Widget build(BuildContext context) {
    final color = action.isDestructive
        ? const Color(AppColors.red)
        : const Color(AppColors.primary);
    return TextButton(
      onPressed: action.onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(action.icon, size: 18),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              action.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
