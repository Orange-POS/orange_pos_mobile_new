import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odoo_inventory/core/config/app_config.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  required AppConfig config,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final app = await builder();

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: app,
    ),
  );
}
