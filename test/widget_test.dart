import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:evrak/main.dart';

void main() {
  testWidgets('EVRAK shows the onboarding/login screen on first launch',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const EvrakApp());
    await tester.pump();
    await tester.pump();

    expect(find.text('Giriş Yap'), findsWidgets);
  });
}
