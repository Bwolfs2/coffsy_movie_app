import 'package:flutter_modular/flutter_modular.dart';

import 'booking_screen.dart';

class BookingModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BookingScreen(arguments: args.data)),
  ];
}
