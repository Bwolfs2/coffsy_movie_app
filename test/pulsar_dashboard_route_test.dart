import 'package:coffsy_movie_app/app/app_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulsar/pulsar.dart';
import 'package:pulsar/src/domain/dtos/route_dto.dart';
import 'package:pulsar/src/domain/services/route_service.dart';
import 'package:pulsar/src/presenter/navigation/pulsar_route_information_parser.dart';
import 'package:pulsar/src/pulsar_module.dart';

void main() {
  tearDown(cleanGlobals);

  test('nested dashboard + movie_module yields shell + leaf for RouterOutlet', () async {
    modularTracker.runApp(AppModule());
    final routeService = injector.get<RouteService>();
    final parser = injector.get<PulsarRouteInformationParser>();

    const path = '/dashboard/movie_module/';
    final leaf = await routeService.getRoute(const RouteParmsDTO(url: path));
    leaf.fold(
      (e) => fail('getRoute failed: $e'),
      (route) {
        expect(route.parent, '/dashboard/', reason: 'leaf must nest under dashboard shell');
      },
    );

    final book = await parser.selectBook(path);
    expect(book.routes.length, 2, reason: 'dashboard shell + tab content');
    final shell = book.routes.firstWhere((r) => r.schema == '');
    final inner = book.routes.firstWhere((r) => r.schema != '');
    expect(inner.schema, shell.uri.toString());
  });
}
