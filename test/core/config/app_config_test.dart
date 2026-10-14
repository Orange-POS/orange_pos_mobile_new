import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odoo_inventory/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('uses default timeout values', () {
      final config = AppConfig(flavor: AppFlavor.development);

      expect(config.flavor, AppFlavor.development);
      expect(config.connectTimeout, const Duration(seconds: 15));
      expect(config.receiveTimeout, const Duration(seconds: 30));
    });

    test('accepts custom timeout values', () {
      final config = AppConfig(
        flavor: AppFlavor.staging,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      );

      expect(config.connectTimeout, const Duration(seconds: 10));
      expect(config.receiveTimeout, const Duration(seconds: 20));
    });

    test('rejects invalid connect timeout', () {
      expect(
        () => AppConfig(
          flavor: AppFlavor.development,
          connectTimeout: Duration.zero,
        ),
        throwsArgumentError,
      );
    });

    test('rejects invalid receive timeout', () {
      expect(
        () => AppConfig(
          flavor: AppFlavor.production,
          receiveTimeout: const Duration(seconds: -1),
        ),
        throwsArgumentError,
      );
    });

    test('appConfigProvider supports dependency override', () {
      final config = AppConfig(flavor: AppFlavor.staging);

      final container = ProviderContainer(
        overrides: [appConfigProvider.overrideWithValue(config)],
      );

      addTearDown(container.dispose);

      expect(container.read(appConfigProvider), same(config));
    });

    test('throws when configuration is not injected', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        () => container.read(appConfigProvider),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'error message',
            contains('AppConfig must be provided during application bootstrap'),
          ),
        ),
      );
    });
  });
}
