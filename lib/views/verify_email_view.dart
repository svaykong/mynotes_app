import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/bloc/auth_state.dart';
import '../helpers/loading/loading_screen.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);
  static const route = '/verify_email_view';

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogOut());
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
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
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Please verify your email address:',
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    onPressed: onEmailVerificationHandle,
                    child: const Text('Send email verification'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onEmailVerificationHandle() {
    context.read<AuthBloc>().add(const AuthEventSendEmailVerification());
  }
}
