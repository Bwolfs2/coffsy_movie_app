import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class NoInternetWidget extends StatelessWidget {
  final String message;
  final Function onPressed;

  const NoInternetWidget({Key? key, required this.message, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.dp12(context),
          ),
        ),
        SizedBox(height: Sizes.dp10(context)),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dp10(context)),
            ),
          ),
          icon: Icon(Icons.wifi),
          onPressed: () => onPressed,
          label: Text('Reload'),
        ),
      ],
    );
  }
}
