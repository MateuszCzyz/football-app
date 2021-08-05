import 'package:formz/formz.dart';

class Email extends FormzInput<String, String> {
  const Email.pure([String value = '']) : super.pure(value);
  const Email.dirty([String value = '']) : super.dirty(value);

  static final _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');

  @override
  String validator(String value) {
    if (value.isNotEmpty) {
      if (value.length >= 6) {
        if (_emailRegExp.hasMatch(value)) {
          return null;
        } else {
          return 'Entered value is not e-mail';
        }
      } else {
        return 'This e-mail is too short, must have 6 chars';
      }
    } else {
      return 'E-mail cannot be empty';
    }
  }
}
