import 'package:flutter/material.dart';

class QrLoginButton extends StatelessWidget {
  const new({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Scan QR Code'),
    );
  }
}
