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
        RadioGroup<bool>(
          groupValue: groupValue,
          onChanged: (bool? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Radio<bool>(value: true),
                    Text('Dark'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Radio<bool>(value: false),
                    Text('Light'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
