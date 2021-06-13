import 'package:coffsy_movie_app/ui/setting/setting_screen.dart';

class Menu {
  const Menu({required this.route, required this.title});

  final String route;
  final String title;
}

const List<Menu> menus = const <Menu>[
  const Menu(
    route: SettingScreen.routeName,
    title: 'Setting',
  ),
];
