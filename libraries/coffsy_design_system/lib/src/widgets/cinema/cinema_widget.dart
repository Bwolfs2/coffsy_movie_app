import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';
import '../../common/utils/chair_constant.dart';

class CinemaWidget extends StatefulWidget {
  final String movieBackground;

  const CinemaWidget({
    Key? key,
    required this.movieBackground,
  }) : super(key: key);

  @override
  State<CinemaWidget> createState() => _CinemaWidgetState();
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
    final width = MediaQuery.sizeOf(context).width;

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
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: widget.movieBackground.imageOriginal,
              width: width,
              fit: BoxFit.fill,
              errorWidget: (context, url, error) => const ErrorImage(),
            ),
          ),
        ),
        const SizedBox(height: 20),
        AnimatedBuilder(
          animation: _cinemaChairAc,
          builder: (ctx, child) {
            return Transform.translate(
              offset: Offset(0, _cinemaChairTween.value * 100),
              child: Opacity(opacity: _cinemaChairTween.value + 1, child: child),
            );
          },
          child: SizedBox(
            width: width,
            child: const ChairList(),
          ),
        ),
      ],
    );
  }
}

class ChairList extends StatefulWidget {
  const ChairList({Key? key}) : super(key: key);

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
    [0, 3, 3, 2, 1, 1, 0],
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
        for (int index = 0; index < 6; index++)
          Container(
            margin: EdgeInsets.only(top: index == 3 ? 20 : 0),
            child: Row(
              children: <Widget>[
                for (int indexx = 0; indexx < 9; indexx++)
                  Expanded(
                    flex: indexx == 0 || indexx == 8 ? 2 : 1,
                    child: indexx == 0 ||
                            indexx == 8 ||
                            (index == 0 && indexx == 1) ||
                            (index == 0 && indexx == 7) ||
                            (index == 3 && indexx == 1) ||
                            (index == 3 && indexx == 7) ||
                            (index == 5 && indexx == 1) ||
                            (index == 5 && indexx == 7)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (_chairStatus[index][indexx - 1] == 1) {
                                setState(() {
                                  _chairStatus[index][indexx - 1] = 4;
                                });
                              } else if (_chairStatus[index][indexx - 1] == 4) {
                                setState(() {
                                  _chairStatus[index][indexx - 1] = 1;
                                });
                              }
                            },
                            child: Container(
                              height: MediaQuery.sizeOf(context).width / 11 - 10,
                              margin: const EdgeInsets.all(5),
                              child: _chairStatus[index][indexx - 1] == 1
                                  ? ChairConstant.white(isDarkTheme: _isDarkTheme)
                                  : _chairStatus[index][indexx - 1] == 2
                                      ? ChairConstant.grey
                                      : _chairStatus[index][indexx - 1] == 3
                                          ? ChairConstant.red
                                          : ChairConstant.orange,
                            ),
                          ),
                  ),
              ],
            ),
          ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ChairCategory(ColorPalettes.white, 'FREE', isWhite: true, isDarkTheme: _isDarkTheme),
              ChairCategory(ColorPalettes.darkAccent, 'YOURS', isDarkTheme: _isDarkTheme),
              ChairCategory(Colors.grey[700] ?? Colors.grey, 'RESERVED', isDarkTheme: _isDarkTheme),
              ChairCategory(Colors.red[800] ?? Colors.red, 'NOT AVAILABLE', isDarkTheme: _isDarkTheme),
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

  Color _borderColor(bool isWhite) => !isDarkTheme
      ? ColorPalettes.transparent
      : isWhite
          ? ColorPalettes.grey
          : ColorPalettes.transparent;

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
            borderRadius: const BorderRadius.all(Radius.circular(2)),
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
