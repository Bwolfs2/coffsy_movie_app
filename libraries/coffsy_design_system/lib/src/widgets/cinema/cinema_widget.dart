import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';
import '../../common/utils/chair_constant.dart';

class CinemaWidget extends StatefulWidget {
  final String movieBackground;

  const CinemaWidget({Key? key, required this.movieBackground}) : super(key: key);

  @override
  _CinemaWidgetState createState() => _CinemaWidgetState();
}

class _CinemaWidgetState extends State<CinemaWidget> with TickerProviderStateMixin {
  late final _cinemaChairAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
  late final _cinemaChairTween = Tween<double>(begin: -1, end: 0).chain(CurveTween(curve: Curves.ease)).animate(_cinemaChairAc);
  late final _cinemaScreenAc = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  late final _cinemaScreenTween = Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeInOutQuart)).animate(_cinemaScreenAc);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 800), _cinemaScreenAc.forward);
    Future.delayed(const Duration(milliseconds: 1200), _cinemaChairAc.forward);
  }

  @override
  void dispose() {
    _cinemaChairAc.dispose();
    _cinemaScreenAc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: _cinemaScreenAc,
          builder: (ctx, child) {
            final perspective = 0.004 * _cinemaScreenTween.value;
            return Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, perspective)
                ..rotateX(_cinemaScreenTween.value),
              child: child,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dp10(context)),
            child: CachedNetworkImage(
              imageUrl: widget.movieBackground.imageOriginal,
              width: Sizes.width(context),
              fit: BoxFit.fill,
              placeholder: (context, url) => LoadingIndicator(),
              errorWidget: (context, url, error) => ErrorImage(),
            ),
          ),
        ),
        SizedBox(height: Sizes.dp20(context)),
        AnimatedBuilder(
          animation: _cinemaChairAc,
          builder: (ctx, child) {
            return Transform.translate(
              offset: Offset(0, _cinemaChairTween.value * 100),
              child: Opacity(opacity: _cinemaChairTween.value + 1, child: child),
            );
          },
          child: Container(
            width: Sizes.width(context),
            child: ChairList(),
          ),
        ),
      ],
    );
  }
}

class ChairList extends StatefulWidget {
  // 0 is null
  // 1 is free
  // 2 is reserved
  // 3 is not available
  // 4 is yours

  @override
  State<ChairList> createState() => _ChairListState();
}

class _ChairListState extends State<ChairList> {
  bool _isDarkTheme = false;

  final _chairStatus = [
    [0, 3, 2, 1, 2, 2, 0],
    [2, 2, 2, 2, 1, 2, 2],
    [1, 1, 2, 2, 2, 2, 2],
    [0, 2, 1, 1, 1, 2, 0],
    [2, 2, 2, 2, 2, 2, 2],
    [0, 3, 3, 2, 1, 1, 0]
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isDarkTheme = Theme.of(context).appBarTheme.backgroundColor == null;
    return Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(top: i == 3 ? Sizes.dp20(context) : 0),
            child: Row(
              children: <Widget>[
                for (int x = 0; x < 9; x++)
                  Expanded(
                    flex: x == 0 || x == 8 ? 2 : 1,
                    child: x == 0 ||
                            x == 8 ||
                            (i == 0 && x == 1) ||
                            (i == 0 && x == 7) ||
                            (i == 3 && x == 1) ||
                            (i == 3 && x == 7) ||
                            (i == 5 && x == 1) ||
                            (i == 5 && x == 7)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (_chairStatus[i][x - 1] == 1) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 4;
                                });
                              } else if (_chairStatus[i][x - 1] == 4) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 1;
                                });
                              }
                            },
                            child: Container(
                              height: Sizes.width(context) / 11 - 10,
                              margin: EdgeInsets.all(Sizes.dp5(context)),
                              child: _chairStatus[i][x - 1] == 1
                                  ? ChairConstant.white(isDarkTheme: _isDarkTheme)
                                  : _chairStatus[i][x - 1] == 2
                                      ? ChairConstant.grey
                                      : _chairStatus[i][x - 1] == 3
                                          ? ChairConstant.red
                                          : ChairConstant.orange,
                            ),
                          ),
                  ),
              ],
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: Sizes.dp20(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ChairCategory(ColorPalettes.white, 'FREE', isWhite: true, isDarkTheme: _isDarkTheme),
              ChairCategory(ColorPalettes.darkAccent, 'YOURS', isWhite: false, isDarkTheme: _isDarkTheme),
              ChairCategory(Colors.grey[700] ?? Colors.grey, 'RESERVED', isWhite: false, isDarkTheme: _isDarkTheme),
              ChairCategory(Colors.red[800] ?? Colors.red, 'NOT AVAILABLE', isWhite: false, isDarkTheme: _isDarkTheme),
            ],
          ),
        ),
      ],
    );
  }
}

class ChairCategory extends StatelessWidget {
  final Color color;
  final String category;
  final bool isWhite;
  final bool isDarkTheme;

  const ChairCategory(
    this.color,
    this.category, {
    Key? key,
    this.isDarkTheme = false,
    this.isWhite = false,
  }) : super(key: key);

  Color _borderColor(bool isWhite) {
    if (!isDarkTheme) {
      return ColorPalettes.transparent;
    } else {
      if (isWhite) {
        return ColorPalettes.grey;
      } else {
        return ColorPalettes.transparent;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor(isWhite)),
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        Text(
          category,
          style: TextStyle(fontSize: 12, color: ColorPalettes.grey),
        ),
      ],
    );
  }
}
