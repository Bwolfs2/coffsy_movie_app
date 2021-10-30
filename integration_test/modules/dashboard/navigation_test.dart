import 'package:coffsy_movie_app/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Widget Test', () {
    testWidgets('tap on the floating action button, and tab BackButton', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      final title = find.text('Movies');

      expect(title, findsOneWidget);

      final fab = find.byTooltip('floatActionButton');

      expect(fab, findsOneWidget);

      await tester.tap(fab);

      await tester.pumpAndSettle();

      final backAbout = find.byTooltip('backAbout');

      expect(backAbout, findsOneWidget);

      await tester.tap(backAbout);

      await tester.pumpAndSettle();

      final titleNew = find.text('Movies');

      expect(titleNew, findsOneWidget);
    });

    testWidgets('tap on the floating action button, and tab BackButton2', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      final title = find.text('Movies');

      expect(title, findsOneWidget);

      final fab = find.byTooltip('floatActionButton');

      expect(fab, findsOneWidget);

      await tester.tap(fab);

      await tester.pumpAndSettle();

      final backAbout = find.byTooltip('backAbout');

      expect(backAbout, findsOneWidget);

      await tester.tap(backAbout);

      await tester.pumpAndSettle();

      final titleNew = find.text('Movies');

      expect(titleNew, findsOneWidget);
    });
  });
}
