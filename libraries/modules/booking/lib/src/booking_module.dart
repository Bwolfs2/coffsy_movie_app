import 'package:flutter_modular/flutter_modular.dart';

import 'booking_page.dart';

class BookingModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BookingPage(arguments: args.data)),
  ];
}
