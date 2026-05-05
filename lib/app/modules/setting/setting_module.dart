import 'package:pulsar/pulsar.dart';

import 'pages/setting_page.dart';

class SettingModule extends Module {
  @override
  final List<PulsarRoute> routes = [
    ChildRoute('/', child: (_, args) => const SettingPage()),
  ];
}
