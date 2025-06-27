part of 'sign_in_bloc.dart';

abstract class SignInEvent {
  List<Object?> get props => <Object?>[];
}

class SignInRequestedEvent extends SignInEvent {
  SignInRequestedEvent();

  @override
  List<Object?> get props => <Object?>[];
}
