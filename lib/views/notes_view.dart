import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/loading/loading_screen.dart';
import '../services/auth/bloc/auth_state.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes Page'),
        actions: [
          IconButton(
            onPressed: () async {
              final res = await showLogoutDialog(context);
              if (res) {
                if (!context.mounted) return;
                context.read<AuthBloc>().add(const AuthEventLogOut());
              }
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
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
        child: Container(),
      ),
    );
  }

  Future<bool> showLogoutDialog(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
