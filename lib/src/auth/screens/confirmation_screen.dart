import 'package:flutter/material.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
    required this.phone,
    this.onContinue,
    this.delay = const Duration(seconds: 2),
  });

  final String phone;
  final VoidCallback? onContinue;
  final Duration delay;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted && widget.onContinue != null) {
        widget.onContinue!.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(AppColors.background),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'Подтверждение авторизации',
              style: AppStyle.inter(
                size: 24,
                weight: FontWeight.w600,
                color: const Color(AppColors.black),
              ),
            ),
            const SizedBox(height: 12),
            Text(widget.phone, style: AppStyle.manrope16),
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 64),
                  const SizedBox(height: 16),
                  Text(
                    'Авторизация успешно подтверждена!',
                    style: AppStyle.inter(
                      size: 18,
                      weight: FontWeight.w600,
                      color: const Color(AppColors.black),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  DefaultButton(
                    text: 'Продолжить',
                    isPrimary: true,
                    onPressed: () {
                      if (widget.onContinue != null) {
                        widget.onContinue!.call();
                      } else {
                        Navigator.of(context).maybePop();
                      }
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
