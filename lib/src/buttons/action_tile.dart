import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';
import '../theme/app_tokens.dart';

class WayPayActionTile extends StatelessWidget {
  const WayPayActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.card),
      onTap: onTap,
      child: Ink(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7F8),
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 21, color: const Color(AppColors.primary)),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.manrope(size: 11, weight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
