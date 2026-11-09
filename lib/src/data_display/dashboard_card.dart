import 'package:flutter/material.dart';

import '../layout/surface_card.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayDashboardCard extends StatelessWidget {
  const WayPayDashboardCard({
    super.key,
    required this.title,
    required this.value,
    this.valueColor = const Color(AppColors.primary),
    this.description,
    this.additionalValue,
    this.backgroundColor = const Color(AppColors.white),
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 6),
    this.onTap,
  });

  final String title;
  final String value;
  final Color valueColor;
  final String? description;
  final String? additionalValue;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return WayPaySurfaceCard(
      onTap: onTap,
      margin: margin,
      padding: padding,
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppStyle.manrope(
              size: 16,
              weight: FontWeight.w500,
              color: const Color(AppColors.uiBorder),
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 6),
            Text(
              description!,
              style: AppStyle.manrope(
                size: 14,
                weight: FontWeight.w400,
                color: const Color(AppColors.uiBorder),
              ),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.manrope(
                    size: 24,
                    weight: FontWeight.w600,
                    color: valueColor,
                  ),
                ),
              ),
              if (additionalValue != null) ...[
                const SizedBox(width: 8),
                Text(
                  additionalValue!,
                  style: AppStyle.manrope(size: 14, weight: FontWeight.w400),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
