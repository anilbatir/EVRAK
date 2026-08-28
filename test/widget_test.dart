import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:evrak/main.dart';

void main() {
  testWidgets('EVRAK home screen shows title and add button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const EvrakApp());
    await tester.pump();

    expect(find.text('EVRAK'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
