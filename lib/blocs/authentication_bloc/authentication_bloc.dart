import 'dart:async';
import 'package:FootballApp/resources/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc({AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationStarted());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    yield LoadingAuthentication();
    if (event is CheckAuthenticationStatus) {
      yield* mapCheckAuthStatusToState();
    } else if (event is LoggedInAuthentication) {
      yield SuccesAuthentication(
          user: _authenticationRepository.getCurrentUser());
    } else if (event is LogoutAuthentication) {
      yield* mapSignOutToState();
    } else if (event is UpdatingAccountData) {
      yield* mapUpdatingAccountDataToState();
    }
  }

  Stream<AuthenticationState> mapCheckAuthStatusToState() async* {
    if (_authenticationRepository.isSignedIn()) {
      yield SuccesAuthentication(
          user: _authenticationRepository.getCurrentUser());
    } else {
      yield FailureAuthentication();
    }
  }

  Stream<AuthenticationState> mapSignOutToState() async* {
    await _authenticationRepository.signOut();
    yield FailureAuthentication();
  }

  Stream<AuthenticationState> mapUpdatingAccountDataToState() async* {
    yield LoadingAuthentication();
  }

  User getCurrentUser() => _authenticationRepository.getCurrentUser();
}
