import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with TickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
  late final _animationTween =
      Tween<double>(begin: -1, end: 0).chain(CurveTween(curve: Curves.easeInOutQuart)).animate(_animationController);

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 800), () => _animationController.forward);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) {
        double opacity() {
          if (_animationTween.value + 1 < 0.2) {
            return (_animationTween.value + 1) * 5;
          }
          return 1;
        }

        return Transform.translate(
          offset: Offset(0, _animationTween.value * 200),
          child: Opacity(opacity: opacity(), child: child),
        );
      },
      child: Container(
        width: Sizes.width(context) * .9,
        height: Sizes.width(context) / 7,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: ColorPalettes.darkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                Sizes.dp10(context),
              ),
              side: BorderSide(
                color: ColorPalettes.darkAccent,
              ),
            ),
          ),
          onPressed: () {
            widget.onPressed();
          },
          child: Text(
            widget.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.dp18(context),
            ),
          ),
        ),
      ),
    );
  }
}
