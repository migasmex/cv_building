part of 'check_auth_bloc.dart';

enum SplashStatus { authenticated, unauthenticated, loading } // TODO: add failure

class SplashState {
  final SplashStatus status;
  final String? userId;

  const SplashState({
    this.status = SplashStatus.loading,
    this.userId,
  });

  SplashState copyWith({
    SplashStatus? status,
    String? userId,
  }) {
    return SplashState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
    );
  }
}