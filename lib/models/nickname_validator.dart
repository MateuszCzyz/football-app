import 'package:formz/formz.dart';

class Nickname extends FormzInput<String, String> {
  const Nickname.pure([String value = '']) : super.pure(value);
  const Nickname.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    if (value.isNotEmpty) {
      if (value.length >= 6) {
        return null;
      } else {
        return 'Entered value must have 6 chars';
      }
    } else {
      return 'Nickname cannot be empty';
    }
  }
}
