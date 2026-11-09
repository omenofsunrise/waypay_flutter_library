import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../layout/surface_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayMetricCard extends StatelessWidget {
  const WayPayMetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconBackground = const Color(0xFFE4F4F1),
    this.valueColor,
    this.onTap,
  });

  WayPayMetricCard.asset({
    super.key,
    required this.title,
    required this.value,
    required String iconAsset,
    Color circleColor = const Color(0xFFE4F4F1),
    this.valueColor,
    this.onTap,
  }) : icon = SvgPicture.asset(iconAsset, width: 18, height: 18),
       iconBackground = circleColor;

  final String title;
  final String value;
  final Widget icon;
  final Color iconBackground;
  final Color? valueColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            child: SizedBox(width: 44, height: 44, child: Center(child: icon)),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.manrope(
              size: 14,
              weight: FontWeight.w500,
              color: const Color(AppColors.uiBorder),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.manrope(
              size: 20,
              weight: FontWeight.w600,
              color: valueColor ?? const Color(AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
