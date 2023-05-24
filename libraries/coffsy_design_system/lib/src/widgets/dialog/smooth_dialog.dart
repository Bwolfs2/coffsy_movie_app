import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../coffsy_design_system.dart';

enum SmoothMode { lottie, network, asset }

class ButtonConfig {
  final String dialogDone, dialogCancel;
  Color? buttonCancelColor, buttonDoneColor, labelCancelColor, labelDoneColor;

  ButtonConfig({this.dialogDone = 'Done', this.dialogCancel = 'Cancel', this.buttonCancelColor, this.buttonDoneColor}) {
    buttonCancelColor ??= ColorPalettes.white;
    buttonDoneColor ??= ColorPalettes.darkAccent;
    labelCancelColor ??= ColorPalettes.black;
    labelDoneColor ??= ColorPalettes.white;
  }
}

class SmoothDialog {
  final String path;
  final String title;
  final String content;
  final double dialogHeight;
  final double imageHeight;
  final double imageWidth;
  final Function submit;
  final BuildContext context;

  ButtonConfig? buttonConfig;
  SmoothMode mode = SmoothMode.lottie;

  SmoothDialog({
    required this.context,
    required this.path,
    required this.title,
    required this.content,
    required this.submit,
    required this.mode,
    this.buttonConfig,
    this.imageHeight = 150,
    this.imageWidth = 150,
    this.dialogHeight = 310,
  }) {
    buttonConfig ??= ButtonConfig();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Sizes.dp16(context),
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              content: SizedBox(
                width: double.maxFinite,
                height: dialogHeight,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: Sizes.dp16(context),
                    ),
                    if (mode == SmoothMode.lottie) ...[
                      Center(
                        child: Lottie.asset(
                          path,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                      ),
                    ] else if (mode == SmoothMode.asset) ...[
                      Center(
                        child: Image.asset(
                          path,
                          width: imageWidth,
                          height: imageHeight,
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: path,
                          width: imageWidth,
                          height: imageHeight,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ],
                    SizedBox(
                      height: Sizes.dp8(context),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: Sizes.dp20(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: Sizes.dp8(context),
                    ),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.dp13(context),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: Sizes.dp10(context),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Sizes.dp12(context),
                                          horizontal: Sizes.dp22(context),
                                        ),
                                        decoration: BoxDecoration(
                                          color: buttonConfig?.buttonCancelColor,
                                          borderRadius: BorderRadius.circular(
                                            Sizes.dp16(context),
                                          ),
                                        ),
                                        child: Text(
                                          '${buttonConfig?.dialogCancel}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: Sizes.dp13(context),
                                            fontWeight: FontWeight.bold,
                                            color: buttonConfig?.labelCancelColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Sizes.dp4(context),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        submit();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: Sizes.dp12(context),
                                          horizontal: Sizes.dp26(context),
                                        ),
                                        decoration: BoxDecoration(
                                          color: buttonConfig?.buttonDoneColor,
                                          borderRadius: BorderRadius.circular(
                                            Sizes.dp16(context),
                                          ),
                                        ),
                                        child: Text(
                                          '${buttonConfig?.dialogDone}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: Sizes.dp13(context),
                                            fontWeight: FontWeight.bold,
                                            color: buttonConfig?.labelDoneColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
