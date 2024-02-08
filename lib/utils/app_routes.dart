import 'package:flutter/material.dart';

import '../views/view.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> get routes => {
        LoginView.route: (_) => const LoginView(),
        HomeView.route: (_) => const HomeView(),
      };
}
