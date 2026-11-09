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
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleContent = Column(
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
        );

        if (!constraints.hasBoundedWidth) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(fit: FlexFit.loose, child: titleContent),
              if (action != null) ...[const SizedBox(width: 12), action!],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: titleContent),
            if (action != null) ...[const SizedBox(width: 12), action!],
          ],
        );
      },
    );
  }
}
