import 'package:coffsy_movie_app/app/app_module.dart';
import 'package:coffsy_movie_app/main.dart' as app;
import 'package:core/core.dart';
import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:movie/movie.dart';
import 'package:movie/src/modules/movie/domain/entities/movie.dart';

class MockGetMovieNowPlaying extends Mock implements IGetMovieNowPlaying {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  late IGetMovieNowPlaying mockGetMovieNowPlaying;

  setUpAll(() {
    mockGetMovieNowPlaying = MockGetMovieNowPlaying();

    initModule(AppModule(), replaceBinds: [
      Bind.singleton<IGetMovieNowPlaying>((_) => mockGetMovieNowPlaying),
    ]);

    when(() => mockGetMovieNowPlaying.call()).thenAnswer((_) async => right(<Movie>[]));
  });

  group('Widget Test', () {
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
