import 'package:flutter/foundation.dart' show immutable;

import 'package:equatable/equatable.dart';

import '../auth_user.dart';

@immutable
abstract class AuthState {
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });

  final bool isLoading;
  final String? loadingText;
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  const AuthStateRegistering({
    this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  final Exception? exception;
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);

  final AuthUser user;
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;

  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  const AuthStateLoggedOut({
    this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );

  final Exception? exception;

  @override
  List<Object?> get props => [exception, isLoading];
}
