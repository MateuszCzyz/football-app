part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterStarted extends RegisterState {}

class RegisterLoading extends RegisterState {}

class SuccessRegistration extends RegisterState {}

class FailureRegistration extends RegisterState {
  final String errorMessage;

  FailureRegistration({this.errorMessage});
}
