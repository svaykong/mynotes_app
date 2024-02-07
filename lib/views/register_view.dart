import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailCtr;
  late TextEditingController _passCtr;
  bool _obscure = true;
  late FocusNode _emailFocusNode;
  late FocusNode _passFocusNode;

  @override
  void initState() {
    super.initState();
    _emailCtr = TextEditingController();
    _passCtr = TextEditingController();
    _emailFocusNode = FocusNode();
    _passFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailCtr.dispose();
    _passCtr.dispose();
    _emailFocusNode.dispose();
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: _emailFocusNode,
                  controller: _emailCtr,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: "Enter your email",
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  enableSuggestions: false,
                  onTapOutside: (e) {
                    if (_emailFocusNode.hasFocus) {
                      _emailFocusNode.unfocus();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  focusNode: _passFocusNode,
                  obscureText: _obscure,
                  controller: _passCtr,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key),
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                      icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  onTapOutside: (e) {
                    if (_passFocusNode.hasFocus) {
                      _passFocusNode.unfocus();
                    }
                  },
                ),
              ),
              TextButton(
                onPressed: onRegisterChange,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onRegisterChange() async {
    final email = _emailCtr.text;
    final password = _passCtr.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuthException::$e');
      }
    }
  }
}
