class Menu {
  const Menu({required this.route, required this.title});

  final String route;
  final String title;
}

const List<Menu> menus = <Menu>[
  Menu(
    route: '/theme',
    title: 'Setting',
  ),
];
