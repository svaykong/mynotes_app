import 'package:flutter/material.dart';

import '../views/view.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes => {
        LoginView.route: (_) => const LoginView(),
        RegisterView.route: (_) => const RegisterView(),
        HomeView.route: (_) => const HomeView(),
        VerifyEmailView.route: (_) => const VerifyEmailView(),
      };
}
