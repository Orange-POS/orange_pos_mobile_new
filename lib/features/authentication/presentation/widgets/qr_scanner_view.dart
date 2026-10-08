import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerView extends StatelessWidget {
  const new({required this.onQrDetected, super.key});

  final ValueChanged<String> onQrDetected;

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        final qrData = capture.barcodes.firstOrNull?.rawValue;

        if (qrData == null) {
          return;
        }

        onQrDetected(qrData);
      },
    );
  }
}
