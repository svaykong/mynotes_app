import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/bloc/auth_state.dart';
import '../services/auth/bloc/auth_event.dart';
import '../services/auth/auth_exception.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../utils/show_error_dialog.dart';
import '../widgets/widget.dart';
import '../views/view.dart';
import '../utils/app_themes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const route = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailCtr;
  late TextEditingController _passCtr;
  late FocusNode _passFocusNode;

  @override
  void initState() {
    super.initState();
    _emailCtr = TextEditingController();
    _passCtr = TextEditingController();
    _passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthStateLoggedOut) {
              if (state.exception is UserNotFoundAuthException) {
                await showErrorDialog(
                  context,
                  "User not found",
                );
              } else if (state.exception is WrongPasswordAuthException) {
                await showErrorDialog(
                  context,
                  "Wrong Credentials",
                );
              } else if (state.exception is GenericAuthException) {
                await showErrorDialog(
                  context,
                  "Login Error Auth Error",
                );
              }
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    EmailTextField(emailCtr: _emailCtr),
                    PasswordTextField(passCtr: _passCtr),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: onLoginHandle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemes.deepBlue,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: AppThemes.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have account! ',
                            style: TextStyle(
                              color: AppThemes.black,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(RegisterView.route);
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onLoginHandle() async {
    final email = _emailCtr.text;
    final password = _passCtr.text;
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthEventLogIn(email, password));

      /// clear text fields
      // _emailCtr.clear();
      // _passCtr.clear();
    }
  }
}
