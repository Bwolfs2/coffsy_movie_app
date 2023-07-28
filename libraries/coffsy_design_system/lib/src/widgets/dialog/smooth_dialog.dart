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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16,
                  ),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              content: SizedBox(
                width: double.maxFinite,
                height: dialogHeight,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 16,
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      content,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
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
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 22,
                                        ),
                                        decoration: BoxDecoration(
                                          color: buttonConfig?.buttonCancelColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              16,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          '${buttonConfig?.dialogCancel}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: buttonConfig?.labelCancelColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        submit();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 26,
                                        ),
                                        decoration: BoxDecoration(
                                          color: buttonConfig?.buttonDoneColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(
                                              16,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          '${buttonConfig?.dialogDone}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13,
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
