import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'floatActionButton',
        onPressed: () {
          Modular.to.pushNamed('/discover_movie', forRoot: true);
        },
        child: Icon(
          Icons.location_searching,
          color: ColorPalettes.white,
        ),
      ),
      bottomNavigationBar: const CustomNavigatorBar(),
    );
  }
}

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final analytics = Modular.get<CoffsyFirebaseAnalytics>();

  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    Modular.to.addListener(onChangeRoute);
  }

  void onChangeRoute() {
    final path = Modular.to.path;
    if (path.contains('movie_module')) {
      setState(() {
        selectedPage = 0;
      });
    }

    if (path.contains('tv_show')) {
      setState(() {
        selectedPage = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => BottomAppBar(
        shape: AutomaticNotchedShape(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        notchMargin: Sizes.dp8(context),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              tooltip: 'movie',
              color: selectedPage == 0 ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
              icon: const Icon(Icons.movie_creation),
              onPressed: () {
                Modular.to.navigate('/dashboard/movie_module/');
              },
            ),
            IconButton(
              tooltip: 'tv_show',
              color: selectedPage == 1 ? ColorPalettes.darkAccent : ColorPalettes.grey,
              icon: const Icon(Icons.live_tv),
              onPressed: () {
                Modular.to.navigate('/dashboard/tv_show/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNavigatorBar extends StatefulWidget {
  const CustomNavigatorBar({super.key});

  @override
  State<CustomNavigatorBar> createState() => _CustomNavigatorBarState();
}

class _CustomNavigatorBarState extends State<CustomNavigatorBar> {
  final analytics = Modular.get<CoffsyFirebaseAnalytics>();

  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    Modular.to.addListener(onChangeRoute);
  }

  void onChangeRoute() {
    final path = Modular.to.path;
    if (path.contains('movie_module')) {
      setState(() {
        selectedPage = 0;
      });
    }

    if (path.contains('tv_show')) {
      setState(() {
        selectedPage = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.movie_creation), label: 'Movie'),
          NavigationDestination(icon: Icon(Icons.live_tv), label: 'Tv Show'),
        ],
        selectedIndex: selectedPage,
        onDestinationSelected: (value) {
          if (value == 0) {
            Modular.to.navigate('/dashboard/movie_module/');
          }

          if (value == 1) {
            Modular.to.navigate('/dashboard/tv_show/');
          }
        },
      ),
    );
  }
}
