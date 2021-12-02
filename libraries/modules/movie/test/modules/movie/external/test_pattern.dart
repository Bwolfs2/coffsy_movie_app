// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    print('Registers a function to be run once before all tests.');
  });

  setUp(() {
    print('Registers a function to be run before tests.');
  });

  tearDown(() {
    print('Registers a function to be run after tests.');
  });

  tearDownAll(() {
    print('Registers a function to be run once after all tests.');
  });

  group('Module Movie', () {
    test('Test One', () {
      print('Make a teste');
    });

    test('Test Two', () {
      print('Make a teste');
    });
  });
}
