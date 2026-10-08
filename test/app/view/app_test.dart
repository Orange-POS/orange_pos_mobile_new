import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:odoo_inventory/app/app.dart';
import 'package:odoo_inventory/features/authentication/presentation/pages/login_page.dart';

void main() {
  group('App', () {
    testWidgets('renders LoginPage', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: App()));

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}
