import 'auth_user.dart';
import 'firebase_auth_provider.dart';
import 'auth_provider.dart';

class AuthService implements AuthProvider {
  const AuthService(this.provider);

  final AuthProvider provider;

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({required String email, required String password}) async {
    return await provider.createUser(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({required String email, required String password}) async {
    return await provider.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await provider.logout();
  }

  @override
  Future<void> sendEmailVerification() async {
    await provider.sendEmailVerification();
  }

  @override
  Future<void> initialize() async {
    await provider.initialize();
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) => provider.sendPasswordReset(toEmail: toEmail);
}
