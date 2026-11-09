import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPaySectionHeader extends StatelessWidget {
  const WayPaySectionHeader({
    super.key,
    required this.title,
    this.action,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyle.manrope(size: 16, weight: FontWeight.w700),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 3),
                Text(
                  subtitle!,
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
        if (action != null) ...[const SizedBox(width: 12), action!],
      ],
    );
  }
}
