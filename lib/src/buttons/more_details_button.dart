import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class MoreDetailsButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final bool showArrow;

  const MoreDetailsButton({
    super.key,
    this.text = 'Подробнее',
    required this.onPressed,
    this.color = const Color(AppColors.primary),
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.textStyle,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle labelStyle = (textStyle ?? AppStyle.medium16).copyWith(
      color: color,
    );

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: color,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          padding: padding,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: labelStyle),
            if (showArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: color, size: 14),
            ],
          ],
        ),
      ),
    );
  }
}
