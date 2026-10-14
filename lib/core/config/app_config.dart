import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config.g.dart';

enum AppFlavor { development, staging, production }

class AppConfig {
  new({
    required this.flavor,
    this.connectTimeout = const Duration(seconds: 15),
    this.receiveTimeout = const Duration(seconds: 30),
  }) {
    if (connectTimeout <= Duration.zero) {
      throw ArgumentError.value(
        connectTimeout,
        'connectTimeout',
        'Must be greater than zero',
      );
    }

    if (receiveTimeout <= Duration.zero) {
      throw ArgumentError.value(
        receiveTimeout,
        'receiveTimeout',
        'Must be greater than zero',
      );
    }
  }

  final AppFlavor flavor;
  final Duration connectTimeout;
  final Duration receiveTimeout;
}

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) {
  throw StateError('AppConfig must be provided during application bootstrap.');
}
