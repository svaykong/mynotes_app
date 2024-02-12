import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/auth/bloc/auth_state.dart';
import '../services/auth/auth_exception.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../utils/show_error_dialog.dart';
import '../widgets/widget.dart';
import '../utils/app_themes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const route = '/register';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthStateRegistering) {
              if (state.exception is EmailAlreadyInUseAuthException) {
                await showErrorDialog(
                  context,
                  "Email Already In Use",
                );
              } else if (state.exception is WeakPasswordAuthException) {
                await showErrorDialog(
                  context,
                  "Weak Password",
                );
              } else if (state.exception is InvalidEmailAuthException) {
                await showErrorDialog(
                  context,
                  "Invalid Email",
                );
              } else if (state.exception is GenericAuthException) {
                await showErrorDialog(
                  context,
                  "Auth Error",
                );
              }
            }
            if (state is AuthStateNeedsVerification) {
              /// clear text fields
              _emailCtr.clear();
              _passCtr.clear();
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
                        onPressed: onRegisterHandle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemes.deepBlue,
                        ),
                        child: Text(
                          'Register',
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
                            'Already have account!',
                            style: TextStyle(
                              color: AppThemes.black,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Login',
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

  void onRegisterHandle() {
    final email = _emailCtr.text;
    final password = _passCtr.text;
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthEventRegister(email, password));
    }
  }
}
