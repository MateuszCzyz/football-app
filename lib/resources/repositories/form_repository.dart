import 'package:FootballApp/models/email_validator.dart';
import 'package:FootballApp/models/nickname_validator.dart';
import 'package:FootballApp/models/password_validator.dart';
import 'package:FootballApp/models/second_password_validator.dart';
import 'package:formz/formz.dart';

class FormRepository {
  emailValidation({required String email}) {
    return Email.dirty(email).error;
  }

  passwordValidation({required String password}) {
    return Password.dirty(password).error;
  }

  secondPasswordValidation(
      {required String firstPassword, required String secondPassword}) {
    SecondPassword _secondPassword = SecondPassword.dirty(secondPassword);
    _secondPassword.setFirstPassword = Password.dirty(firstPassword);
    return _secondPassword.error;
  }

  nicknameValidation({required String nickname}) {
    return Nickname.dirty(nickname).error;
  }

  bool loginFormIsValid({required String email, required String password}) {
    return Formz.validate([
      Email.dirty(email),
      Password.dirty(password),
    ]);
  }

  bool registerFormIsValid({
    required String email,
    required String firstPassword,
    required String secondPassword,
  }) {
    return Formz.validate([
      Email.dirty(email),
      Password.dirty(firstPassword),
      SecondPassword.dirty(secondPassword)
    ]);
  }
}
