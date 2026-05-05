import 'package:pulsar/pulsar.dart';

import 'booking_page.dart';

class BookingModule extends Module {
  @override
  final List<PulsarRoute> routes = [
    ChildRoute('/', child: (_, args) => BookingPage(arguments: args.data)),
  ];
}
