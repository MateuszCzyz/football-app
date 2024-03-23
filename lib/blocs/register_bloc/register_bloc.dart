import 'dart:async';

import 'package:FootballApp/resources/repositories/image_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:FootballApp/resources/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FootballApp/utils/get_error_message.dart';
import 'package:FootballApp/resources/repositories/users_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;
  final UsersRepository usersRepository;
  ImageRepository? imageRepository;
  RegisterBloc({
    required this.authenticationRepository,
    required this.usersRepository,
    this.imageRepository,
  }) : super(RegisterStarted());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is CreateNewAccount) {
      yield* mapCreateNewAccountToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> mapCreateNewAccountToState({
    required String email,
    required String password,
  }) async* {
    yield RegisterLoading();
    try {
      await authenticationRepository.createUserWithEmailAndPassoword(
          email: email, password: password);
      authenticationRepository.updateUserName(displayName: email.split('@')[0]);
      await authenticationRepository.reloadAccount();
      User? _currentUser = authenticationRepository.getCurrentUser();
      if (_currentUser != null) {
        await usersRepository.createUser(
            userID: _currentUser.uid, userName: _currentUser.displayName!);
        authenticationRepository.signOut();
        yield SuccessRegistration();
      }
    } on FirebaseAuthException catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield FailureRegistration(errorMessage: _errorMessage);
    }
  }
}
