part of 'sign_in_bloc.dart';

enum SignInStatus { loading, success, failure }

class SignInState {
  const SignInState({
    this.status = SignInStatus.loading,
    this.error,
  });

  final SignInStatus status;
  final String? error;

  SignInState copyWith({
    SignInStatus? status,
    String? error,
  }) {
    return SignInState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}