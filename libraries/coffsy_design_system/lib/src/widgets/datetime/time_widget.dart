import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class TimeWidget extends StatefulWidget {
  const TimeWidget({Key? key}) : super(key: key);

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> with TickerProviderStateMixin {
  final _timeSelectorAcList = <AnimationController>[];
  final _timeSelectorTweenList = <Animation<double>>[];

  final _time = [
    ['01:30', 45],
    ['06:30', 45],
    ['10:30', 45],
  ];
  var _timeIndexSelected = 1;

  @override
  void initState() {
    super.initState();
    // initialize timeSelector List
    for (var index = 0; index < 3; index++) {
      _timeSelectorAcList.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 500)));
      _timeSelectorTweenList
          .add(Tween<double>(begin: 1000, end: 0).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_timeSelectorAcList[index]));
      Future.delayed(Duration(milliseconds: index * 25 + 100), () {
        _timeSelectorAcList[index].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.width(context),
      height: Sizes.width(context) / 5,
      margin: EdgeInsets.symmetric(vertical: Sizes.dp20(context)),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (ctx, index) {
          return AnimatedBuilder(
            animation: _timeSelectorAcList[index],
            builder: (ctx, child) {
              return Transform.translate(
                offset: Offset(_timeSelectorTweenList[index].value, 0),
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _timeIndexSelected = index;
                });
              },
              child: TimeItemWidget(
                _time[index][0] as String,
                _time[index][1] as int,
                active: index == _timeIndexSelected,
              ),
            ),
          );
        },
      ),
    );
  }
}

class TimeItemWidget extends StatefulWidget {
  final String time;
  final int price;
  final bool active;

  const TimeItemWidget(
    this.time,
    this.price, {
    Key? key,
    this.active = false,
  }) : super(key: key);

  @override
  State<TimeItemWidget> createState() => _TimeItemWidgetState();
}

class _TimeItemWidgetState extends State<TimeItemWidget> {
  bool _isDarkTheme = false;

  Color _textTimeColor(bool active) => !_isDarkTheme
      ? active
          ? ColorPalettes.darkAccent
          : ColorPalettes.white
      : active
          ? ColorPalettes.darkAccent
          : ColorPalettes.darkBG;

  @override
  Widget build(BuildContext context) {
    _isDarkTheme = Theme.of(context).appBarTheme.backgroundColor == null;
    final activeColor = _textTimeColor(widget.active);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.dp12(context)),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dp16(context)),
      decoration: BoxDecoration(
        border: Border.all(color: activeColor),
        borderRadius: BorderRadius.circular(Sizes.dp12(context)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: widget.time,
              style: TextStyle(
                fontSize: Sizes.dp20(context),
                fontWeight: FontWeight.w600,
                color: activeColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' PM',
                  style: TextStyle(
                    fontSize: Sizes.dp14(context),
                    fontWeight: FontWeight.w600,
                    color: activeColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'IDR ${widget.price}K',
            style: TextStyle(
              fontSize: Sizes.dp14(context),
              fontWeight: FontWeight.w600,
              color: ColorPalettes.grey,
            ),
          ),
        ],
      ),
    );
  }
}
