part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateNewAccount extends RegisterEvent {
  final String email;
  final String password;

  CreateNewAccount({this.email, this.password});
}
