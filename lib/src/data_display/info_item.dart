import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayInfoItem extends StatelessWidget {
  const WayPayInfoItem({
    super.key,
    required this.label,
    required this.value,
    this.horizontal = false,
    this.valueColor,
    this.onTap,
    this.alignRight = false,
    this.maxLines,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final bool horizontal;
  final Color? valueColor;
  final VoidCallback? onTap;
  final bool alignRight;
  final int? maxLines;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    final labelWidget = Text(
      label,
      style:
          labelStyle ??
          AppStyle.manrope(
            size: horizontal ? 14 : 13,
            weight: FontWeight.w400,
            color: const Color(AppColors.uiBorder),
          ),
    );
    final valueWidget = Text(
      value,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      textAlign: horizontal || alignRight ? TextAlign.right : TextAlign.left,
      style:
          valueStyle ??
          AppStyle.manrope(
            size: 16,
            weight: FontWeight.w600,
            color:
                valueColor ??
                (onTap == null
                    ? const Color(AppColors.black)
                    : const Color(AppColors.primary)),
          ),
    );
    final content = horizontal
        ? Row(
            children: [
              Expanded(child: labelWidget),
              const SizedBox(width: 12),
              valueWidget,
            ],
          )
        : Column(
            crossAxisAlignment: alignRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [labelWidget, const SizedBox(height: 4), valueWidget],
          );
    return onTap == null ? content : InkWell(onTap: onTap, child: content);
  }
}

class WayPayInfoGrid extends StatelessWidget {
  const WayPayInfoGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.spacing = 16,
    this.runSpacing = 16,
  }) : assert(columns > 0);

  final List<Widget> children;
  final int columns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children
              .map((child) => SizedBox(width: width, child: child))
              .toList(),
        );
      },
    );
  }
}
