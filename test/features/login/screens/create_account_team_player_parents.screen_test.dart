import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/design_system/design_system.dart';
import 'package:team_aid/features/login/screens/create_account_team_player_parents.screen.dart';

void main() {
  group('CreateAccountTeamPlayerScreen widget tests', () {
    final materialApp = ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(home: CreateAccountParentsScreen());
      },
    );
    testWidgets('Renders all required widgets', (WidgetTester tester) async {
      await tester.pumpWidget(materialApp);

      expect(find.byType(TATypography), findsAtLeastNWidgets(2));
      expect(find.byType(TAPrimaryButton), findsOneWidget);
      expect(find.byType(TAPrimaryInput), findsNWidgets(5));
    });
  });
}
