// import 'package:coffsy_design_system/coffsy_design_system.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:golden_toolkit/golden_toolkit.dart';

// void main() {
//   // ignore: unnecessary_lambdas
//   setUpAll(() {
//     TestWidgetsFlutterBinding.ensureInitialized();
//   });
//   group('Golden - Design System', () {
//     testGoldens('Custom Button Test', (tester) async {
//       //Arrange
//       await loadAppFonts();

//       //Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Center(
//             child: CustomButton(
//               onPressed: () {},
//               text: 'Custom Button Test 3',
//             ),
//           ),
//         ),
//       );

//       tester.pump(
//         const Duration(milliseconds: 800),
//       );

//       //Assert
//       await screenMatchesGolden(tester, 'movie_banner');
//     });

//     testGoldens('Custom Button Test', (tester) async {
//       //Arrange
//       await loadAppFonts();

//       //Act
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Center(
//             child: CustomButton(
//               onPressed: () {},
//               text: 'Custom Button Test New',
//             ),
//           ),
//         ),
//       );

//       tester.pump(
//         const Duration(milliseconds: 800),
//       );

//       //Assert
//       await screenMatchesGolden(tester, 'movie_banner_new');
//     });
//   });
// }
