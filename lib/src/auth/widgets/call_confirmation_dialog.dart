import 'package:flutter/material.dart';
import 'package:waypay_styles/waypay_styles.dart';

class CallConfirmationDialog extends StatelessWidget {
  const CallConfirmationDialog({
    super.key,
    required this.callPhone,
    required this.checkId,
    required this.phone,
  });

  final String callPhone;
  final String checkId;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Подтверждение\nавторизации', style: AppStyle.medium20.copyWith(height: 1.2), textAlign: TextAlign.center,),
          const SizedBox(height: 10),
          Text(
            'Для завершения авторизации позвоните на номер:',
            style: AppStyle.regular14,
            textAlign: TextAlign.center,
          ),
           SizedBox(height: 10),
          Text(
            '8(499) 555-5555',
            style: TextStyle(fontSize: 30, color: Color(AppColors.primary)),
          ),
          SizedBox(height: 10),
          Text(
            'После звонка проверка будет проходить автоматически',
            textAlign: TextAlign.center,
            style: AppStyle.regular14,
          ),
        ],
      ),
    );
  }
}
