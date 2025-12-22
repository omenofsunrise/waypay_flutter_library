import 'package:flutter/material.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

class CallConfirmationDialog extends StatelessWidget {
  const CallConfirmationDialog({
    super.key,
    required this.callPhone,
    required this.checkId,
    required this.phone,
    required this.onTryConfirm,
  });

  final String callPhone;
  final String checkId;
  final String phone;
  final Future<void> Function() onTryConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.call, color: Color(AppColors.primary), size: 40),
          const SizedBox(height: 12),
          Text(
            'Подтверждение звонком',
            style: AppStyle.medium20.copyWith(
              color: const Color(AppColors.black),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Мы позвонили на номер $callPhone\n(чек: $checkId).\n'
            'Если звонок получен, нажмите «Подтвердить».',
            style: AppStyle.regular14.copyWith(
              color: const Color(AppColors.black),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          DefaultButton(
            text: 'Подтвердить',
            isPrimary: true,
            onPressed: () async {
              await onTryConfirm();
            },
          ),
          const SizedBox(height: 8),
          DefaultButton(
            text: 'Отмена',
            isPrimary: false,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
