import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  ValueNotifier<int> selectedPageValueNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    Modular.to.addListener(onChangeRoute);
  }

  void onChangeRoute() {
    if (Modular.to.localPath.contains('movie_module')) {
      selectedPageValueNotifier.value = 0;
    }

    if (Modular.to.localPath.contains('tv_show')) {
      selectedPageValueNotifier.value = 1;
    }
  }

  @override
  void dispose() {
    Modular.to.removeListener(onChangeRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Modular.to.pushNamed('/discover_movie'),
        child: Icon(
          Icons.location_searching,
          color: ColorPalettes.white,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: ColorPalettes.setActive),
              ),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: Sizes.dp8(context),
            child: ValueListenableBuilder(
              valueListenable: selectedPageValueNotifier,
              builder: (context, selectedPage, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: selectedPage == 0 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                    icon: Icon(Icons.movie_creation),
                    onPressed: () {
                      Modular.to.navigate('/dashboard/movie_module/');
                    },
                  ),
                  IconButton(
                    color: selectedPage == 1 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                    icon: Icon(Icons.live_tv),
                    onPressed: () {
                      Modular.to.navigate('/dashboard/tv_show/');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
