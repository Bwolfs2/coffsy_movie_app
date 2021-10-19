import 'package:coffsy_movie_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  group('Widget Test', () {
    testWidgets('tap on the floating action button, and tab BackButton', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      final title = find.text('Movies');
      expect(title, findsOneWidget);

      // Finds the floating action button to tap on.
      final fab = find.byTooltip('floatActionButton');
      expect(fab, findsOneWidget);

      await tester.tap(fab);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Emulate a tap on the floating action button.
      final backAbout = find.byTooltip('backAbout');
      expect(backAbout, findsOneWidget);

      await tester.tap(backAbout);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      final titleNew = find.text('Movies');
      expect(titleNew, findsOneWidget);
    });

    testWidgets('should navigate between tabs', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      final title = find.text('Movies');
      expect(title, findsOneWidget);

      // Finds the floating action button to tap on.
      final tabAction = find.byTooltip('tv_show');
      expect(tabAction, findsOneWidget);

      await tester.tap(tabAction);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      final titleTvShow = find.text('Tv Show');
      expect(titleTvShow, findsOneWidget);

      // Finds the floating action button to tap on.
      final tabActionMovie = find.byTooltip('movie');
      expect(tabActionMovie, findsOneWidget);

      await tester.tap(tabActionMovie);

      // Trigger a frame.
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      final titleNew = find.text('Movies');
      expect(titleNew, findsOneWidget);
    });
  });
}
