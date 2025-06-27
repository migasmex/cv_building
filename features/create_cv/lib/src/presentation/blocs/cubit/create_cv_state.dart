part of 'create_cv_cubit.dart';

sealed class CreateCvState {}

final class CreateCvInitial extends CreateCvState {}

final class CreateCvSuccess extends CreateCvState {}

final class CreateCvError extends CreateCvState {
  final String message;

  CreateCvError({
    required this.message,
  });
}
