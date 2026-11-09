import 'package:flutter/material.dart';

import '../buttons/default_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayLoadingState extends StatelessWidget {
  const WayPayLoadingState({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (label != null) ...[
            const SizedBox(height: 12),
            Text(
              label!,
              style: AppStyle.manrope(size: 14, weight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }
}

class WayPayEmptyState extends StatelessWidget {
  const WayPayEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.actionText,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => _WayPayStateView(
    icon: icon,
    title: title,
    message: message,
    actionText: actionText,
    onAction: onAction,
  );
}

class WayPayErrorState extends StatelessWidget {
  const WayPayErrorState({
    super.key,
    this.title = 'Не удалось загрузить данные',
    this.message,
    this.onRetry,
  });

  final String title;
  final String? message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => _WayPayStateView(
    icon: Icons.error_outline,
    iconColor: const Color(AppColors.red),
    title: title,
    message: message,
    actionText: onRetry == null ? null : 'Повторить',
    onAction: onRetry,
  );
}

class _WayPayStateView extends StatelessWidget {
  const _WayPayStateView({
    required this.title,
    this.message,
    this.icon,
    this.iconColor,
    this.actionText,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 40,
                color: iconColor ?? const Color(AppColors.uiBorder),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyle.manrope(size: 16, weight: FontWeight.w600),
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppStyle.manrope(
                  size: 13,
                  weight: FontWeight.w400,
                  color: const Color(AppColors.uiBorder),
                ),
              ),
            ],
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: 180,
                child: DefaultButton(
                  text: actionText!,
                  isPrimary: true,
                  onPressed: onAction,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
