import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:team_aid/features/home/screens/add_player.screen.dart';

void main() {
  group('AddPlayerScreen widget tests', () {
    testWidgets('Renders all required widgets', (WidgetTester tester) async {
      final materialApp = ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return const MaterialApp(home: AddPlayerScreen());
        },
      );

      await tester.pumpWidget(materialApp);

      expect(find.byKey(const Key('add_player_title')), findsOneWidget);
      expect(find.byKey(const Key('add_player')), findsOneWidget);
      expect(find.byKey(const Key('search_player')), findsOneWidget);
    });
  });
}
