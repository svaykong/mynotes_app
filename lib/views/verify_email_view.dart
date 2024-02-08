import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);
  static const route = '/verify_email_view';

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  bool _asyncCall = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _asyncCall,
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
      ),
    );
  }

  Future<void> onEmailVerificationHandle() async {
    try {
      setState(() {
        _asyncCall = true;
      });
      final user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('onEmailVerificationHandle::$e');
      }
    } finally {
      setState(() {
        _asyncCall = false;
      });
    }
  }
}
