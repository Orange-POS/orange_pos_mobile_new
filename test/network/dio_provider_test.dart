import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odoo_inventory/core/config/app_config.dart';
import 'package:odoo_inventory/network/dio_provider.dart';

void main() {
  group('Dio Provider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(
            AppConfig(
              flavor: AppFlavor.development,
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 20),
            ),
          ),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('creates Dio with AppConfig timeout values', () {
      final dio = container.read(dioProvider);

      expect(dio.options.connectTimeout, const Duration(seconds: 10));
      expect(dio.options.receiveTimeout, const Duration(seconds: 20));
    });

    test('does not configure a static backend URL', () {
      final dio = container.read(dioProvider);

      expect(dio.options.baseUrl, isEmpty);
    });

    test('reuses the same Dio instance', () {
      final first = container.read(dioProvider);
      final second = container.read(dioProvider);

      expect(identical(first, second), isTrue);
    });

    test('creates independent Dio instances per container', () {
      final otherContainer = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(
            AppConfig(flavor: AppFlavor.staging),
          ),
        ],
      );
      addTearDown(otherContainer.dispose);

      final first = container.read(dioProvider);
      final second = otherContainer.read(dioProvider);

      expect(identical(first, second), isFalse);
      expect(second.options.connectTimeout, const Duration(seconds: 15));
      expect(second.options.receiveTimeout, const Duration(seconds: 30));
    });

    test('supports overriding Dio with a fake client', () {
      final fakeDio = Dio();

      final testContainer = ProviderContainer(
        overrides: [dioProvider.overrideWithValue(fakeDio)],
      );
      addTearDown(testContainer.dispose);
      addTearDown(() => fakeDio.close(force: true));

      final result = testContainer.read(dioProvider);

      expect(identical(result, fakeDio), isTrue);
    });

    test('closes Dio when provider container is disposed', () {
      final testContainer = ProviderContainer(
        overrides: [
          appConfigProvider.overrideWithValue(
            AppConfig(flavor: AppFlavor.development),
          ),
        ],
      );

      final dio = testContainer.read(dioProvider);

      // Dio's adapter can be replaced with a test adapter
      // that records whether close() was called.
      final adapter = _TrackingHttpClientAdapter();
      dio.httpClientAdapter = adapter;

      expect(adapter.closed, isFalse);

      testContainer.dispose();

      expect(adapter.closed, isTrue);
    });

    test('fails when AppConfig is not injected', () {
      final testContainer = ProviderContainer();
      addTearDown(testContainer.dispose);

      expect(
        () => testContainer.read(dioProvider),
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

class _TrackingHttpClientAdapter implements HttpClientAdapter {
  bool closed = false;

  @override
  void close({bool force = false}) {
    closed = true;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw UnimplementedError('Network requests are not used in this test.');
  }
}
