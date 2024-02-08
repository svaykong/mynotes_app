import 'package:flutter/material.dart';

import 'view.dart';
import '../utils/app_routes.dart';

class RootView extends StatelessWidget {
  const RootView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VerifyEmailView(),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
    );
  }
}

