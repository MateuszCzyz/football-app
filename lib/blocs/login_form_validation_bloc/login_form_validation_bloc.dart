import 'package:FootballApp/resources/repositories/form_repository.dart';
import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginFormValidationBloc {
  final FormRepository formRepository = FormRepository();
  final LoginBloc loginBloc;
  BehaviorSubject<String> _emailErrorStream;
  BehaviorSubject<String> _passwordErrorStream;
  BehaviorSubject<String> _emailValueStream;
  BehaviorSubject<String> _passwordValueStream;
  BehaviorSubject<bool> _loginFormValidationStream;

  LoginFormValidationBloc({this.loginBloc}) {
    _emailErrorStream = BehaviorSubject<String>();
    _passwordErrorStream = BehaviorSubject<String>();
    _emailValueStream = BehaviorSubject<String>();
    _passwordValueStream = BehaviorSubject<String>();
    _loginFormValidationStream = BehaviorSubject<bool>()..add(false);

    _emailValueStream.listen((email) {
      _emailErrorStream.add(formRepository.emailValidation(email: email));
      _checkLoginFormStatus();
    });

    _passwordValueStream.listen((password) {
      _passwordErrorStream
          .add(formRepository.passwordValidation(password: password));
      _checkLoginFormStatus();
    });
  }

  Stream<String> get getEmailErrorStream => _emailErrorStream.stream;
  Stream<String> get getPasswordErrorStream => _passwordErrorStream.stream;

  Function(String) get setEmailValue => _emailValueStream.sink.add;
  Function(String) get setPasswordValue => _passwordValueStream.sink.add;

  _checkLoginFormStatus() {
    _loginFormValidationStream.add(formRepository.loginFormIsValid(
        email: _emailValueStream.value, password: _passwordValueStream.value));
  }

  signInWithValidate() {
    if (_loginFormValidationStream.value) {
      loginBloc.add(SigInWithEmailAndPassword(
          email: _emailValueStream.value,
          password: _passwordValueStream.value));
    }
  }

  clearForm() {
    setEmailValue(null);
    setPasswordValue(null);
    _emailErrorStream.add(null);
    _passwordErrorStream.add(null);
  }
}
