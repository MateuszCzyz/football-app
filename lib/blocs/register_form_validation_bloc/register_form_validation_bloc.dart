import 'package:FootballApp/resources/repositories/form_repository.dart';
import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterFormValidationBloc {
  final FormRepository _formRepository = FormRepository();
  final RegisterBloc registerBloc;
  late BehaviorSubject<String> _emailErrorStream;
  late BehaviorSubject<String> _passwordErrorStream;
  late BehaviorSubject<String> _secondPasswordErrorStream;
  late BehaviorSubject<String> _emailValueStream;
  late BehaviorSubject<String> _passwordValueStream;
  late BehaviorSubject<String> _secondPasswordValueStream;
  late BehaviorSubject<bool> _registerFormValidation;

  RegisterFormValidationBloc({required this.registerBloc}) {
    _emailErrorStream = BehaviorSubject<String>();
    _passwordErrorStream = BehaviorSubject<String>();
    _secondPasswordErrorStream = BehaviorSubject<String>();
    _emailValueStream = BehaviorSubject<String>();
    _passwordValueStream = BehaviorSubject<String>();
    _secondPasswordValueStream = BehaviorSubject<String>();
    _registerFormValidation = BehaviorSubject<bool>()..add(false);

    _emailValueStream.listen((email) {
      _emailErrorStream.add(_formRepository.emailValidation(email: email));
      _checkRegisterFormStatus();
    });

    _passwordValueStream.listen((password) {
      _passwordErrorStream
          .add(_formRepository.passwordValidation(password: password));
      _checkRegisterFormStatus();
    });

    _secondPasswordValueStream.listen((secondPassword) {
      _secondPasswordErrorStream.add(_formRepository.secondPasswordValidation(
          firstPassword: _passwordValueStream.value,
          secondPassword: secondPassword));
      _checkRegisterFormStatus();
    });
  }

  Stream<String> get getEmailErrorStream => _emailErrorStream.stream;
  Stream<String> get getPasswordErrorStream => _passwordErrorStream.stream;
  Stream<String> get getSecondPasswordErrorStream =>
      _secondPasswordErrorStream.stream;

  Function(String) get setEmailValue => _emailValueStream.sink.add;
  Function(String) get setPasswordValue => _passwordValueStream.sink.add;
  Function(String) get setSecondPasswordValue =>
      _secondPasswordValueStream.sink.add;

  _checkRegisterFormStatus() {
    _registerFormValidation.add(_formRepository.registerFormIsValid(
        email: _emailValueStream.value,
        firstPassword: _passwordValueStream.value,
        secondPassword: _secondPasswordValueStream.value));
  }

  createAccountWithValidate() {
    if (_registerFormValidation.value) {
      registerBloc.add(CreateNewAccount(
          email: _emailValueStream.value,
          password: _passwordValueStream.value));
    }
  }
}
