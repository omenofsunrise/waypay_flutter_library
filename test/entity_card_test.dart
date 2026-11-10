import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

void main() {
  testWidgets('entity card fits a narrow mobile layout', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: WayPayEntityCard(
                title: 'Инвестиционный пул с длинным названием',
                subtitle: 'Создан 10.11.2026',
                leading: const WayPayIconBadge(
                  icon: Icons.account_balance_outlined,
                ),
                details: const [
                  WayPayInfoItem(label: 'Касса пула', value: '3 094 837 ₽'),
                  WayPayInfoItem(label: 'Активен до', value: '10.11.2027'),
                ],
                actions: [
                  WayPayCardAction(
                    icon: Icons.add_circle_outline,
                    label: 'Добавить инвестицию',
                    onPressed: () {},
                  ),
                  WayPayCardAction(
                    icon: Icons.payments_outlined,
                    label: 'Выплатить',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Касса пула'), findsOneWidget);
    expect(find.text('Выплатить'), findsOneWidget);
  });
}
