import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

void main() {
  testWidgets('scrollable tabs fit four long labels on a narrow screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: Builder(
              builder: (context) => SizedBox(
                width: 320,
                child: CustomTabSwitcher(
                  controller: DefaultTabController.of(context),
                  isScrollable: true,
                  tabs: const [
                    'Выплаты',
                    'Договоры',
                    'Инвестиции',
                    'Реинвестиции',
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Реинвестиции'), findsOneWidget);
  });

  testWidgets('overflow button opens the shared action sheet', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WayPayOverflowMenuButton<String>(
            items: const [
              WayPayActionSheetItem(
                value: 'edit',
                label: 'Редактировать',
                icon: Icons.edit_outlined,
              ),
              WayPayActionSheetItem(
                value: 'delete',
                label: 'Удалить',
                icon: Icons.delete_outline,
                isDestructive: true,
              ),
            ],
            onSelected: (_) {},
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.more_horiz));
    await tester.pumpAndSettle();

    expect(find.text('Действия'), findsOneWidget);
    expect(find.text('Редактировать'), findsOneWidget);
    expect(find.text('Удалить'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
