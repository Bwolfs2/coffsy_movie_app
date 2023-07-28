import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const NoInternetWidget({
    Key? key,
    required this.message,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          icon: const Icon(Icons.wifi),
          onPressed: onPressed,
          label: const Text('Reload'),
        ),
      ],
    );
  }
}
