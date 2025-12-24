
import 'package:flutter/material.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

class CallConfirmationDialog extends StatefulWidget {
  final String callPhone;
  final String checkId;
  final String phone;


  const CallConfirmationDialog({
    super.key,
    required this.callPhone,
    required this.checkId,
    required this.phone,
  });

  @override
  State<CallConfirmationDialog> createState() => _CallConfirmationDialogState();
}

class _CallConfirmationDialogState extends State<CallConfirmationDialog> {


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(AppColors.background),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Подтверждение авторизации',
              style: AppStyle.semiBold20,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Для завершения авторизации позвоните на номер:',
              style: AppStyle.medium16.copyWith(
                color: const Color(AppColors.grey),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              widget.callPhone,
              style: AppStyle.inter(
                size: 20,
                weight: FontWeight.w700,
                color: const Color(AppColors.primary),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'После звонка проверка будет происходить автоматически.',
              style: AppStyle.medium16.copyWith(
                color: const Color(AppColors.grey),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
