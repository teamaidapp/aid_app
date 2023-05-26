import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/features/login/login.screen.dart';

void main() {
  group('LoginScreen widget tests', () {
    final materialApp = ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(home: LoginScreen());
      },
    );
    testWidgets('Renders all required widgets', (WidgetTester tester) async {
      await tester.pumpWidget(materialApp);

      expect(find.text('Grow your team'), findsOneWidget);
    });
  });
}
