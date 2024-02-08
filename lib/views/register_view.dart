import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../widgets/widget.dart';
import '../utils/app_themes.dart';
import 'view.dart';

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
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _asyncCall,
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

  Future<void> onRegisterHandle() async {
    final email = _emailCtr.text;
    final password = _passCtr.text;
    if (_formKey.currentState!.validate()) {
      try {
        /// set bloc access: start
        setState(() {
          _asyncCall = true;
        });
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);

        /// set bloc access: start
        setState(() {
          _asyncCall = false;
        });

        /// clear text fields
        _emailCtr.clear();
        _passCtr.clear();

        if (!context.mounted) return;
        if (userCredential.user?.emailVerified ?? false) {
          Navigator.of(context).pushNamedAndRemoveUntil(HomeView.route, (value) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(VerifyEmailView.route, (value) => false);
        }
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException::$e');
      } finally {
        /// set bloc access: stop
        setState(() {
          _asyncCall = false;
        });
      }
    }
  }
}
