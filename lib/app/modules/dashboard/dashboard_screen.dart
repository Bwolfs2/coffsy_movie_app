import 'package:coffsy_design_system/coffsy_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _page = 0;
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
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Theme.of(context).accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: ColorPalettes.setActive),
              ),
        ),
        child: StatefulBuilder(
          builder: (context, setState) => BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: Sizes.dp8(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: _page == 0 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                  icon: Icon(Icons.movie_creation),
                  onPressed: () {
                    Modular.to.navigate("/dashboard/movie_module/");
                    setState(() {
                      _page = 0;
                    });
                  },
                ),
                IconButton(
                  color: _page == 1 ? ColorPalettes.darkAccent : ColorPalettes.grey,
                  icon: Icon(Icons.live_tv),
                  onPressed: () {
                    Modular.to.navigate("/dashboard/tv_show/");
                    setState(() {
                      _page = 1;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
