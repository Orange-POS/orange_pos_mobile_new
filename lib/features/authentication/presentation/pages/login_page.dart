import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:odoo_inventory/features/authentication/presentation/widgets/login_header.dart';
import 'package:odoo_inventory/features/authentication/presentation/widgets/qr_login_button.dart';

class LoginPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginHeader(),

            const SizedBox(height: 24),

            QrLoginButton(
              onPressed: () async {
                await context.push<void>('/login/qr');
              },
            ),
          ],
        ),
      ),
    );
  }
}
