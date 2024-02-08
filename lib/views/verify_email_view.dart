import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text('Please verify your email address:'),
              TextButton(
                onPressed: onEmailVerificationHandle,
                child: const Text('Send email verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onEmailVerificationHandle() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification();
  }
}
