import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:odoo_inventory/features/authentication/presentation/providers/auth_provider.dart';
import 'package:odoo_inventory/features/authentication/presentation/widgets/qr_scanner_view.dart';

class QrScannerPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<QrScannerPage> createState() {
    return _QrScannerPageState();
  }
}

class _QrScannerPageState extends ConsumerState<QrScannerPage> {
  bool _hasScanned = false;

  void _handleQrDetected(String qrData) {
    if (_hasScanned) {
      return;
    }

    _hasScanned = true;

    ref.read(authProvider.notifier).loginWithQr(qrData);

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: QrScannerView(onQrDetected: _handleQrDetected),
    );
  }
}
