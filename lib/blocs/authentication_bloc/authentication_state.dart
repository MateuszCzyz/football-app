part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationState {}

class SuccesAuthentication extends AuthenticationState {
  final User? user;
  SuccesAuthentication({required this.user});
  @override
  List<Object> get props => user != null ? [user!] : [];
}

class FailureAuthentication extends AuthenticationState {}

class LoadingAuthentication extends AuthenticationState {}
