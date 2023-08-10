import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/login/screens/create_account_team.screen.dart';

void main() {
  group('CreateAccountTeamScreen widget tests', () {
    final materialApp = ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(home: CreateAccountTeamScreen());
      },
    );
    testWidgets('Renders all required widgets', (WidgetTester tester) async {
      await tester.pumpWidget(materialApp);

      expect(find.text('Create a team'), findsOneWidget);
      expect(find.byType(TATypography), findsWidgets);
      expect(find.byType(TAPrimaryButton), findsOneWidget);
      expect(find.byType(TAPrimaryInput), findsNWidgets(3));
      expect(find.byType(TADropdown), findsNWidgets(3));
    });
  });
}
