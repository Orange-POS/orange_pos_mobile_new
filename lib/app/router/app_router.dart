import 'package:go_router/go_router.dart';
import 'package:odoo_inventory/features/authentication/presentation/pages/login_page.dart';
import 'package:odoo_inventory/features/authentication/presentation/pages/qr_scanner_page.dart';
import 'package:odoo_inventory/features/home/presentation/pages/home_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
      routes: [
        GoRoute(
          path: 'qr',
          builder: (context, state) {
            return const QrScannerPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);
