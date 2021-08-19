class Menu {
  const Menu({
    required this.route,
    required this.title,
    this.isFeedBack = false,
  });

  final String route;
  final String title;
  final bool isFeedBack;
}

const List<Menu> menus = <Menu>[
  Menu(
    route: '/theme',
    title: 'Setting',
  ),
  Menu(
    route: '',
    title: 'Feedback',
    isFeedBack: true,
  ),
];
