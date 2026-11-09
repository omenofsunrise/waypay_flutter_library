import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_style.dart';

class WayPayModal extends StatelessWidget {
  const WayPayModal({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.onClose,
    this.onPrimary,
    this.primaryText = 'Сохранить',
    this.primaryEnabled = true,
    this.isSubmitting = false,
    this.submittingText = 'Сохранение...',
    this.showPrimaryButton = true,
    this.showCancelButton = true,
    this.cancelText = 'Отмена',
    this.maxWidth = 500,
    this.primaryColor,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onClose;
  final VoidCallback? onPrimary;
  final String primaryText;
  final bool primaryEnabled;
  final bool isSubmitting;
  final String submittingText;
  final bool showPrimaryButton;
  final bool showCancelButton;
  final String cancelText;
  final double maxWidth;
  final Color? primaryColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontalPadding = size.width < 420 ? 24.0 : 32.0;
    final showFooter = showCancelButton || showPrimaryButton;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          maxHeight: size.height * .9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppStyle.manrope(
                            size: 22,
                            weight: FontWeight.w700,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 5),
                          Text(
                            subtitle!,
                            style: AppStyle.manrope(
                              size: 14,
                              weight: FontWeight.w400,
                              color: const Color(AppColors.uiBorder),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Закрыть',
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  6,
                  horizontalPadding,
                  showFooter ? 20 : 28,
                ),
                child: child,
              ),
            ),
            if (showFooter) ...[
              const Divider(height: 1),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  16,
                  horizontalPadding,
                  20,
                ),
                child: Row(
                  children: [
                    if (showCancelButton)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onClose,
                          child: Text(cancelText),
                        ),
                      ),
                    if (showCancelButton && showPrimaryButton)
                      const SizedBox(width: 12),
                    if (showPrimaryButton)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: primaryEnabled && !isSubmitting
                              ? onPrimary
                              : null,
                          style: primaryColor == null
                              ? null
                              : ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                ),
                          child: Text(
                            isSubmitting ? submittingText : primaryText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class WayPayConfirmDialog extends StatelessWidget {
  const WayPayConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Подтвердить',
    this.cancelText = 'Отмена',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return WayPayModal(
      title: title,
      onClose: () => Navigator.of(context).pop(false),
      onPrimary: () => Navigator.of(context).pop(true),
      primaryText: confirmText,
      cancelText: cancelText,
      primaryColor: isDestructive ? const Color(AppColors.red) : null,
      child: Text(
        message,
        style: AppStyle.manrope(size: 15, weight: FontWeight.w400),
      ),
    );
  }
}

Future<bool> showWayPayConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmText = 'Подтвердить',
  String cancelText = 'Отмена',
  bool isDestructive = false,
}) async {
  return await showDialog<bool>(
        context: context,
        builder: (_) => WayPayConfirmDialog(
          title: title,
          message: message,
          confirmText: confirmText,
          cancelText: cancelText,
          isDestructive: isDestructive,
        ),
      ) ??
      false;
}
