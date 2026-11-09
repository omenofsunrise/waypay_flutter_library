import 'package:flutter/material.dart';

import '../layout/surface_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayEntityHeaderCard extends StatelessWidget {
  const WayPayEntityHeaderCard({
    super.key,
    required this.title,
    required this.icon,
    required this.metricLabel,
    required this.metricValue,
    this.subtitle,
    this.badge,
  });

  final String title;
  final String? subtitle;
  final Widget icon;
  final String metricLabel;
  final String metricValue;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      padding: const EdgeInsets.all(18),
      showBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F4F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(child: icon),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.manrope(
                        size: 19,
                        weight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty) ...[
                      const SizedBox(height: 2),
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
            ],
          ),
          const SizedBox(height: 24),
          Text(
            metricLabel,
            style: AppStyle.manrope(
              size: 13,
              weight: FontWeight.w400,
              color: const Color(AppColors.uiBorder),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            metricValue,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.manrope(size: 28, weight: FontWeight.w700),
          ),
          if (badge != null) ...[const SizedBox(height: 16), badge!],
        ],
      ),
    );
  }
}
