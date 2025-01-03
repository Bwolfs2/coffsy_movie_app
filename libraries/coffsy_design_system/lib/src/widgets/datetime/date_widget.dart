import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> with TickerProviderStateMixin {
  final _dateSelectorAcList = <AnimationController>[];
  final _dateSelectorTweenList = <Animation<double>>[];

  late final _dateBackgroundAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  late final _dateBackgroundTween =
      Tween<double>(begin: 1000, end: 0).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_dateBackgroundAc);

  final _currentDate = DateTime.now();
  var _dateIndexSelected = 1;
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    for (var index = 0; index < 7; index++) {
      _dateSelectorAcList.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 500)));
      _dateSelectorTweenList
          .add(Tween<double>(begin: 1000, end: 0).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_dateSelectorAcList[index]));
      Future.delayed(Duration(milliseconds: index * 50 + 170), () {
        _dateSelectorAcList[index].forward();
      });
    }

    // initialize dateSelector Background

    Future.delayed(const Duration(milliseconds: 150), () => _dateBackgroundAc.forward);
  }

  Color _textDateColor(int index) => !_isDarkTheme
      ? index == _dateIndexSelected
          ? ColorPalettes.black
          : ColorPalettes.white
      : index == _dateIndexSelected
          ? ColorPalettes.white
          : ColorPalettes.black;

  Color _backgroundColor() => !_isDarkTheme ? ColorPalettes.white.withAlpha(25) : ColorPalettes.black.withAlpha(25);

  @override
  void dispose() {
    _dateBackgroundAc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    _isDarkTheme = themeData.appBarTheme.backgroundColor == null;

    return SizedBox(
      height: MediaQuery.sizeOf(context).width / 3.5,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          AnimatedBuilder(
            animation: _dateBackgroundAc,
            builder: (ctx, child) {
              return Transform.translate(
                offset: Offset(_dateBackgroundTween.value, 0),
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: _backgroundColor(),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final date = _currentDate.add(Duration(days: index));

              return AnimatedBuilder(
                animation: _dateSelectorAcList[index],
                builder: (ctx, child) {
                  return Transform.translate(
                    offset: Offset(_dateSelectorTweenList[index].value, 0),
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _dateIndexSelected = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 25,
                      left: 10,
                      right: 10,
                      bottom: 25,
                    ),
                    width: MediaQuery.sizeOf(context).width / 10,
                    decoration: BoxDecoration(
                      color: _dateIndexSelected == index ? ColorPalettes.darkAccent : Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateTimeFormat.day(date.weekday),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _textDateColor(index),
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: _textDateColor(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
