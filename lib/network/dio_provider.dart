import 'package:dio/dio.dart';
import 'package:odoo_inventory/core/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);

  final client = Dio(
    BaseOptions(
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
    ),
  );

  ref.onDispose(() {
    client.close(force: true);
  });

  return client;
}
