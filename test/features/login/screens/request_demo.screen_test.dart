import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/login/screens/request_demo.screen.dart';

void main() {
  group('RequestDemoScreen widget tests', () {
    final materialApp = ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(home: RequestDemoScreen());
      },
    );
    testWidgets('Renders all required widgets', (WidgetTester tester) async {
      await tester.pumpWidget(materialApp);

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.byType(TATypography), findsWidgets);
      expect(find.byType(TAPrimaryButton), findsOneWidget);
      expect(find.byType(TAPrimaryInput), findsWidgets);
    });
  });
}
