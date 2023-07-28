import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(left: 10),
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
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
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
