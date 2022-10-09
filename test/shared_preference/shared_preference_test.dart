import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: type_annotate_public_apis
void main() {
  late SharedPreferences shared;

  setUp(() async {
    SharedPreferences.setMockInitialValues({'Teste': 'TEste'});

    shared = await SharedPreferences.getInstance();
  });
  group('get data from SharedPreference', () {
    test('show get all', () async {
      final result = shared.getString('Teste');

      expect(result, 'TEste');
    });
  });
}
