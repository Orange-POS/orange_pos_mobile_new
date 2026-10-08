import 'package:odoo_inventory/features/authentication/domain/entities/login_session.dart';

class LoginWithQr {
  LoginSession call(String qrData) {
    return LoginSession(qrdata: qrData);
  }
}
