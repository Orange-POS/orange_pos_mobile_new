import 'package:odoo_inventory/app/app.dart';
import 'package:odoo_inventory/bootstrap.dart';
import 'package:odoo_inventory/core/config/app_config.dart';

Future<void> main() async {
  await bootstrap(
    () => const App(),
    config: AppConfig(flavor: AppFlavor.production),
  );
}
