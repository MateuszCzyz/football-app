part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SigInWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  SigInWithEmailAndPassword({this.email, this.password});
}

class SigInWithGoogle extends LoginEvent {}
