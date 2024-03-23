import 'package:formz/formz.dart';

class Password extends FormzInput<String, String> {
  const Password.pure([String value = '']) : super.pure(value);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isNotEmpty) {
      if (value.length >= 6) {
        return null;
      } else {
        return 'Entered value must have 6 chars';
      }
    } else {
      return 'password cannot be empty';
    }
  }
}
