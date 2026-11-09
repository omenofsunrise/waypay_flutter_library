import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import '../theme/app_tokens.dart';

enum WayPayStatusTone { neutral, success, warning, danger, info }

class WayPayStatusBadge extends StatelessWidget {
  const WayPayStatusBadge({
    super.key,
    required this.text,
    this.tone = WayPayStatusTone.neutral,
  });

  final String text;
  final WayPayStatusTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = switch (tone) {
      WayPayStatusTone.success => (
        const Color(0xFFE2F7EC),
        const Color(0xFF0B8F4D),
      ),
      WayPayStatusTone.warning => (
        const Color(0xFFFFF2DE),
        const Color(0xFFB56800),
      ),
      WayPayStatusTone.danger => (
        const Color(0xFFFFE8E8),
        const Color(AppColors.red),
      ),
      WayPayStatusTone.info => (
        const Color(0xFFE4F4F1),
        const Color(AppColors.primary),
      ),
      WayPayStatusTone.neutral => (
        const Color(0xFFF0F2F4),
        const Color(AppColors.uiBorder),
      ),
    };
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.$1,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.manrope(
            size: 12,
            weight: FontWeight.w600,
            color: colors.$2,
          ),
        ),
      ),
    );
  }
}
