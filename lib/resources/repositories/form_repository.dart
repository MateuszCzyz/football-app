import 'package:FootballApp/models/email_validator.dart';
import 'package:FootballApp/models/nickname_validator.dart';
import 'package:FootballApp/models/password_validator.dart';
import 'package:FootballApp/models/second_password_validator.dart';
import 'package:formz/formz.dart';

class FormRepository {
  emailValidation({String email}) {
    return Email.dirty(email).error;
  }

  passwordValidation({String password}) {
    return Password.dirty(password).error;
  }

  secondPasswordValidation({String firstPassword, String secondPassword}) {
    SecondPassword _secondPassword = SecondPassword.dirty(secondPassword);
    _secondPassword.setFirstPassword = Password.dirty(firstPassword);
    return _secondPassword.error;
  }

  nicknameValidation({String nickname}) {
    return Nickname.dirty(nickname).error;
  }

  bool loginFormIsValid({String email, String password}) {
    return Formz.validate([
      Email.dirty(email),
      Password.dirty(password),
    ]).isValid;
  }

  bool registerFormIsValid(
      {String email, String firstPassword, String secondPassword}) {
    return Formz.validate([
      Email.dirty(email),
      Password.dirty(firstPassword),
      SecondPassword.dirty(secondPassword)
    ]).isValid;
  }
}
