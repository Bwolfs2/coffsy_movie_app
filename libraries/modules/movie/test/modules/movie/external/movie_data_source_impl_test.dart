import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/src/modules/movie/domain/entities/movie.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dioInstance;
  late MovieDataSource movieDataSource;

  setUpAll(() {
    dioInstance = MockDio();
    movieDataSource = MovieDataSourceImpl(dioInstance, ApiConfigurations());
    registerFallbackValue(RequestOptions(path: ''));
  });

  group('Movie DataSource - getMovieNowPlaying', () {
    test('Should return a list of Movies', () async {
      when(
        () => dioInstance.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (invocation) async => Response(
          data: {
            'results': [
              {
                'id': 1,
                'name': 'filme x',
                'overview': 'overvvvuhuh',
                'genre_ids': [1],
                'vote_average': 0,
                'popularity': 1,
                'backdrop_path': 'backdrop_path',
                'tv_name': 'tv_name',
                'tv_release': 'tv_release',
              }
            ]
          },
          requestOptions: RequestOptions(path: ''),
        ),
      );

      var result = await movieDataSource.getMovieNowPlaying();

      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
    });
  });
}
