import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  late SharedPreferences shared;

  setUp(() async {
    SharedPreferences.setMockInitialValues({'Teste': 'TEste'});

    shared = await SharedPreferences.getInstance();
  });
  group('get data from SharedPreference', () {
    test('show get all', () async {
      var result = shared.getString('Teste');

      expect(result, 'TEste');
    });
  });
}
