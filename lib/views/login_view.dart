import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  bool _asyncCall = false;

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
        child: Center(
          child: ModalProgressHUD(
            inAsyncCall: _asyncCall,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: EmailTextField(emailCtr: _emailCtr),
                  ),
                  Flexible(
                    child: PasswordTextField(passCtr: _passCtr),
                  ),
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
                ],
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
      try {
        /// set bloc access: start
        setState(() {
          _asyncCall = true;
        });
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if (kDebugMode) print(userCredential);

        /// clear text fields
        _emailCtr.clear();
        _passCtr.clear();

        if (!context.mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil(HomeView.route, (value) => false);
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) print('FirebaseAuthException::$e');
      } finally {
        /// set bloc access: stop
        setState(() {
          _asyncCall = false;
        });
      }
    }
  }
}
