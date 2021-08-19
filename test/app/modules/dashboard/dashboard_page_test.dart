import 'package:coffsy_movie_app/app/modules/dashboard/dashboard_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('dashboard page ...', (tester) async {
    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const DashBoardPage());

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);

      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });
  });
}
