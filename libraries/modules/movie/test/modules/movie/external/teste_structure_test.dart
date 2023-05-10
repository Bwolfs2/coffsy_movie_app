import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';
import 'package:movie/src/modules/movie/domain/entities/movie.dart';

class MockHttpClient extends Mock implements IHttpClient {}

void main() {
  late IHttpClient dioInstance;
  late MovieDataSource movieDataSource;

  setUpAll(() {
    dioInstance = MockHttpClient();
    movieDataSource = MovieDataSourceImpl(dioInstance);
  });

  group('Movie DataSource - getMovieNowPlaying', () {
    test('Should return a list of Movies', () async {
      //Arrange - Preparaçao
      when(
        () => dioInstance.get(any(), queryParameters: any(named: 'queryParameters')),
      ).thenAnswer(
        (invocation) async => HttpClientResponse(data: _responseJson, statusCode: 200),
      );

      //Act - Ação
      final result = await movieDataSource.getMovieNowPlaying();

      //Assert - Efeito esperado
      expect(result, isA<List<Movie>>());
      expect(result.length, 1);
    });
  });
}

var _responseJson = {
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
};
