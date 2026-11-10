import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

void main() {
  testWidgets('keeps the default suffix icon centered and inset', (
    tester,
  ) async {
    final controller = TextEditingController(text: '01.01.0001');
    addTearDown(controller.dispose);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: ModalTextField(
                controller: controller,
                label: 'Дата окончания договора',
                suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
              ),
            ),
          ),
        ),
      ),
    );

    final fieldRect = tester.getRect(find.byType(TextField));
    final iconRect = tester.getRect(find.byIcon(Icons.calendar_today_outlined));

    expect(iconRect.center.dy, closeTo(fieldRect.center.dy, 1));
    expect(fieldRect.right - iconRect.right, greaterThanOrEqualTo(12));
  });
}
