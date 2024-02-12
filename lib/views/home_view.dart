import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/loading/loading_screen.dart';
import '../views/view.dart';
import '../services/auth/bloc/auth_state.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

enum MenuAction { logout }

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        /// produce some side affect tasks
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else {
          return const NotesView();
        }
      },
    );
  }
}
