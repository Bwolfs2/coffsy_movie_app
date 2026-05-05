import 'package:pulsar/pulsar.dart';

import 'ui/pages/about_page.dart';

class AboutModule extends Module {
  @override
  final List<PulsarRoute> routes = [
    ChildRoute('/', child: (_, args) => const AboutPage()),
  ];
}
