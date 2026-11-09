import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:waypay_flutter_library/waypay_styles.dart';

void main() {
  testWidgets('renders inside a Row with unbounded child width', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              WayPaySectionHeader(title: 'Финансы'),
              Spacer(),
              Text('Подробнее'),
            ],
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('Финансы'), findsOneWidget);
  });
}
