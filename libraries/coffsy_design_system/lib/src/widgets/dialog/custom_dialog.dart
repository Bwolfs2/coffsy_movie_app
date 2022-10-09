import 'package:flutter/material.dart';

import '../../../coffsy_design_system.dart';

class CustomDialog extends StatelessWidget {
  final bool isDark, groupValue;
  final ValueChanged<bool> onChanged;

  const CustomDialog({Key? key, required this.isDark, required this.groupValue, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Switch Theme'),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: Row(
            children: <Widget>[
              Radio<bool>(
                value: true,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value ?? false),
              ),
              const Text('Dark'),
            ],
          ),
        ),
        SizedBox(
          height: Sizes.dp10(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: Row(
            children: <Widget>[
              Radio<bool>(
                value: false,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value ?? false),
              ),
              const Text('Light'),
            ],
          ),
        ),
      ],
    );
  }
}
