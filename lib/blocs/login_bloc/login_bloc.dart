import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:FootballApp/resources/repositories/auth_repository.dart';
import 'package:FootballApp/resources/repositories/users_repository.dart';
import 'package:FootballApp/utils/get_error_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationRepository _authenticationRepository;
  final UsersRepository _usersRepository;
  LoginBloc({
    required AuthenticationBloc authenticationBloc,
    required AuthenticationRepository authenticationRepository,
    required UsersRepository usersRepository,
  })  : _authenticationBloc = authenticationBloc,
        _authenticationRepository = authenticationRepository,
        _usersRepository = usersRepository,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SigInWithEmailAndPassword) {
      yield LoginLoading();
      yield* mapSignInWithEmailAndPasswordToState(
          email: event.email, password: event.password);
    } else if (event is SigInWithGoogle) {
      yield LoginLoading();
      yield* mapSignInWithGoogleToState();
    }
  }

  Stream<LoginState> mapSignInWithEmailAndPasswordToState({
    required String email,
    required String password,
  }) async* {
    try {
      await _authenticationRepository.signInWithEmailAndPassword(
          email: email, password: password);
      yield LoginSuccess();
      _authenticationBloc.add(LoggedInAuthentication());
    } on FirebaseAuthException catch (e) {
      String _errorMessage = getErrorMessage(e.code);
      yield LoginFailure(errorMessage: _errorMessage);
    }
  }

  Stream<LoginState> mapSignInWithGoogleToState() async* {
    try {
      await _authenticationRepository.signInWithGoogle();
      User? _currentUser = _authenticationBloc.getCurrentUser();
      if (_currentUser != null) {
        if (!await _usersRepository.userExists(userID: _currentUser.uid)) {
          await _usersRepository.createUser(
              userID: _currentUser.uid, userName: _currentUser.displayName!);
          if (_currentUser.photoURL != null) {
            await _authenticationRepository.removeUserPhoto();
          }
        }
        _authenticationBloc.add(LoggedInAuthentication());
        yield LoginSuccess();
      }
    } catch (e) {
      yield LoginFailure(
        errorMessage: getErrorMessage((e as Map)['code']),
      );
    }
  }
}
