import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:odoo_inventory/features/authentication/presentation/providers/auth_provider.dart';
import 'package:odoo_inventory/features/home/presentation/widgets/home_app_bar.dart';
import 'package:odoo_inventory/features/home/presentation/widgets/login_session_view.dart';

class HomePage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authProvider);

    return Scaffold(
      appBar: HomeAppBar(
        onLogout: () {
          ref.read(authProvider.notifier).logout();

          context.go('/login');
        },
      ),
      body: LoginSessionView(qrData: session?.qrdata),
    );
  }
}
