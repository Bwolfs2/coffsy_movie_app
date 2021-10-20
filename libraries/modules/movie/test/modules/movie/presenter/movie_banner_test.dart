import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:movie/movie.dart';
import 'package:movie/src/modules/movie/domain/entities/movie.dart';
import 'package:movie/src/modules/movie/domain/errors/movie_failures.dart';
import 'package:movie/src/modules/movie/presenter/widgets/movie_banner/movie_banner.dart';
import 'package:coffsy_design_system/coffsy_design_system.dart';

class MockGetMovieNowPlaying extends Mock implements IGetMovieNowPlaying {}

void main() {
  late IGetMovieNowPlaying mockGetMovieNowPlaying;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockGetMovieNowPlaying = MockGetMovieNowPlaying();

    initModules([
      MovieModule(),
    ], replaceBinds: [
      Bind.lazySingleton<IGetMovieNowPlaying>((_) => mockGetMovieNowPlaying),
    ]);
  });
  group('Module Movie', () {
    testWidgets('banner widget', (tester) async {
      when(() => mockGetMovieNowPlaying.call()).thenAnswer((_) async {
        return right(<Movie>[]);
      });

      await tester.pumpWidget(const MaterialApp(
        home: MovieBanner(),
      ));

      //Por causa do Timer dentro da Store
      await tester.pump(const Duration(milliseconds: 50));
      var widget = find.byKey(ValueKey('NothingFound'));
      expect(widget, findsOneWidget);
    });

    testWidgets('banner widget can`t find a SizedBox', (tester) async {
      when(() => mockGetMovieNowPlaying.call()).thenAnswer((_) async {
        return right(<Movie>[
          Movie(0, 'Title', '', '', [0], 0.0, 0.0, '', '', '', '')
        ]);
      });

      // await tester.pumpWidget(
      //     const MaterialApp(
      //       home: MovieBanner(),
      //     ),
      //     const Duration(milliseconds: 400));

      await tester.pumpFrames(
          const MaterialApp(
            home: MovieBanner(),
          ),
          const Duration(milliseconds: 400));

      //Por causa do Timer dentro da Store

      //await tester.pumpAndSettle(const Duration(seconds: 5));
      // print(DateTime.now());
      // await tester.runAsync(() => Future.delayed(Duration(seconds: 1)));
      // print(DateTime.now());

      var widget = find.byKey(const ValueKey('NothingFound'));

      expect(widget, findsNothing);

      expect(find.byKey(const ValueKey('NothingFound2')), findsOneWidget);
    });

    testWidgets('banner widget erro test', (tester) async {
      when(() => mockGetMovieNowPlaying.call()).thenAnswer((_) async {
        return left(MovieNowPlayingNoInternetConnection());
      });

      await tester.pumpFrames(
          const MaterialApp(
            home: MovieBanner(),
          ),
          const Duration(milliseconds: 400));

      var widget = find.byKey(const ValueKey('NothingFound'));

      expect(widget, findsNothing);

      expect(find.byKey(const ValueKey('NothingFound2')), findsNothing);

      expect(find.byType(NoInternetWidget), findsOneWidget);
    });
  });
}
