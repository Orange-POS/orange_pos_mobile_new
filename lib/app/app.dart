import 'package:flutter/material.dart';
import 'package:odoo_inventory/app/router/app_router.dart';

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
