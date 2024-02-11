import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  const AuthUser(
    this.isEmailVerified,
    this.email,
  );

  final bool isEmailVerified;
  final String? email;

  factory AuthUser.fromFirebase(User user) => AuthUser(
        user.emailVerified,
        user.email,
      );
}
