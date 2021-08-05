import 'package:formz/formz.dart';
import '../models/password_validator.dart';

class SecondPassword extends FormzInput<String, String> {
  const SecondPassword.pure([String value = '']) : super.pure(value);
  const SecondPassword.dirty([String value = '']) : super.dirty(value);
  static Password _firstPassword;

  set setFirstPassword(Password firstPassword) {
    _firstPassword = firstPassword;
  }

  @override
  String validator(String value) {
    if (value.isNotEmpty) {
      if (_firstPassword.valid) {
        if (value.length >= 6) {
          if (value == _firstPassword.value) {
            return null;
          } else {
            return 'The enterer password is not equal with previous password';
          }
        } else {
          return 'Entered value must have 6 chars';
        }
      } else {
        return 'First you have to enter the correct previous password';
      }
    } else {
      return 'Second password cannot be empty';
    }
  }
}
