import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  const UserModel({
    required this.userCredential,
  });

  final UserCredential userCredential;
}
