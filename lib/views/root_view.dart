import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.dart';
import '../services/auth/firebase_auth_provider.dart';
import '../services/auth/bloc/auth_bloc.dart';
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
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomeView(),
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
    );
  }
}
