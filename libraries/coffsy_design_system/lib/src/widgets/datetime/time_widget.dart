import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class TimeWidget extends StatefulWidget {
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> with TickerProviderStateMixin {
  final _timeSelectorAcList = <AnimationController>[];
  final _timeSelectorTweenList = <Animation<double>>[];

  final _time = [
    ['01:30', 45],
    ['06:30', 45],
    ['10:30', 45]
  ];
  var _timeIndexSelected = 1;

  @override
  void initState() {
    super.initState();
    // initialize timeSelector List
    for (var i = 0; i < 3; i++) {
      _timeSelectorAcList.add(AnimationController(vsync: this, duration: const Duration(milliseconds: 500)));
      _timeSelectorTweenList
          .add(Tween<double>(begin: 1000, end: 0).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_timeSelectorAcList[i]));
      Future.delayed(Duration(milliseconds: i * 25 + 100), () {
        _timeSelectorAcList[i].forward();
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
        physics: const ClampingScrollPhysics(),
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
                active: index == _timeIndexSelected ? true : false,
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
  _TimeItemWidgetState createState() => _TimeItemWidgetState();
}

class _TimeItemWidgetState extends State<TimeItemWidget> {
  bool _isDarkTheme = false;

  Color _textTimeColor(bool active) {
    if (!_isDarkTheme) {
      if (active) {
        return ColorPalettes.darkAccent;
      } else {
        return ColorPalettes.white;
      }
    } else {
      if (active) {
        return ColorPalettes.darkAccent;
      } else {
        return ColorPalettes.darkBG;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _isDarkTheme = Theme.of(context).appBarTheme.backgroundColor == null;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.dp12(context)),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dp16(context)),
      decoration: BoxDecoration(
        border: Border.all(color: _textTimeColor(widget.active), width: 1),
        borderRadius: BorderRadius.circular(Sizes.dp12(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: widget.time,
              style: TextStyle(
                fontSize: Sizes.dp20(context),
                fontWeight: FontWeight.w600,
                color: _textTimeColor(widget.active),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' PM',
                  style: TextStyle(
                    fontSize: Sizes.dp14(context),
                    fontWeight: FontWeight.w600,
                    color: _textTimeColor(widget.active),
                  ),
                )
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
