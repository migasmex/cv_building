part of 'logout_bloc.dart';

abstract class LogoutEvent {
  List<Object?> get props => <Object?>[];
}

class LogoutRequestedEvent extends LogoutEvent {
  LogoutRequestedEvent();

  @override
  List<Object?> get props => <Object?>[];
}
