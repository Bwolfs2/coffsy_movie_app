class Menu {
  const Menu({required this.route, required this.title});

  final String route;
  final String title;
}

const List<Menu> menus = const <Menu>[
  const Menu(
    route: '/theme',
    title: 'Setting',
  ),
];
