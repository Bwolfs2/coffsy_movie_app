import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:dartz/dartz.dart' hide Bind;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUpAll(() {
    //
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Golden - Design System', () {
    testGoldens('Custom Button Test', (tester) async {
      //Arrange
      await loadAppFonts();

      //Act
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomButton(
              onPressed: () {},
              text: 'Custom Button Test',
            ),
          ),
        ),
      );

      tester.pump(
        const Duration(milliseconds: 800),
      );

      //Assert
      await screenMatchesGolden(tester, 'movie_banner');
    });

    testGoldens('Custom Button Test', (tester) async {
      //Arrange
      await loadAppFonts();

      //Act
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: CustomButton(
              onPressed: () {},
              text: 'Custom Button Test',
            ),
          ),
        ),
      );

      tester.pump(
        const Duration(milliseconds: 800),
      );

      //Assert
      await screenMatchesGolden(tester, 'movie_banner_new');
    });
  });
}
