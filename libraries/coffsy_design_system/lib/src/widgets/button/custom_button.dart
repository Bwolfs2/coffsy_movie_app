import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CustomButton extends StatefulWidget {
  final Function onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with TickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  late final _animationTween =
      Tween<double>(begin: -1, end: 0).chain(CurveTween(curve: Curves.easeInOutQuart)).animate(_animationController);

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 800), _animationController.forward);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

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
      child: SizedBox(
        width: width * .9,
        height: width / 7,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: ColorPalettes.darkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
