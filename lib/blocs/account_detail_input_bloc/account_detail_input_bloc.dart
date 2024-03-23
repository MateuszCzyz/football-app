import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';
import 'package:FootballApp/resources/repositories/form_repository.dart';
import 'package:rxdart/rxdart.dart';

class AccountDetailInputBloc {
  final FormRepository formRepository = FormRepository();
  final AccountDetailBloc accountDetailBloc;
  late BehaviorSubject<String> _nicknameInputValueStream;
  late BehaviorSubject<String> _emailInputValueStream;
  late BehaviorSubject<String> _passwordInputValueStream;
  late BehaviorSubject<String> _nicknameInputErrorStream;
  late BehaviorSubject<String> _emailInputErrorStream;
  late BehaviorSubject<String> _passwordInputErrorStream;
  late BehaviorSubject<bool> _emailInputIsSubmited;
  late BehaviorSubject<bool> _nicknameInputIsSubmited;
  late BehaviorSubject<bool> _passwordInputIsSubmited;

  AccountDetailInputBloc({required this.accountDetailBloc}) {
    _nicknameInputValueStream = BehaviorSubject<String>();
    _emailInputValueStream = BehaviorSubject<String>();
    _passwordInputValueStream = BehaviorSubject<String>();
    _nicknameInputErrorStream = BehaviorSubject<String>();
    _emailInputErrorStream = BehaviorSubject<String>();
    _passwordInputErrorStream = BehaviorSubject<String>();
    _emailInputIsSubmited = BehaviorSubject<bool>()..add(false);
    _nicknameInputIsSubmited = BehaviorSubject<bool>()..add(false);
    _passwordInputIsSubmited = BehaviorSubject<bool>()..add(false);

    _nicknameInputValueStream.listen((value) {
      _nicknameInputErrorStream
          .add(formRepository.nicknameValidation(nickname: value));
    });

    _emailInputValueStream.listen((value) {
      _emailInputErrorStream.add(formRepository.emailValidation(email: value));
    });

    _passwordInputValueStream.listen((value) {
      _passwordInputErrorStream
          .add(formRepository.passwordValidation(password: value));
    });
  }

  Stream<String> get getNicknameErrorStream => _nicknameInputErrorStream.stream;
  Stream<String> get getEmailErrorStream => _emailInputErrorStream.stream;
  Stream<String> get getPasswordErrorStream => _passwordInputErrorStream.stream;
  Stream<bool> get emailInputSubmitStatus => _emailInputIsSubmited.stream;
  Stream<bool> get passwordInputSubmitStatus => _passwordInputIsSubmited.stream;
  Stream<bool> get nicknameInputSubmitStatus => _nicknameInputIsSubmited.stream;

  Function(String) get setNicknameValue => _nicknameInputValueStream.sink.add;
  Function(String) get setPasswordValue => _passwordInputValueStream.sink.add;
  Function(String) get setEmailValue => _emailInputValueStream.sink.add;

  submitPasswordInput() {
    if (_passwordInputErrorStream.value == null &&
        _passwordInputValueStream.value.isNotEmpty) {
      accountDetailBloc
          .add(SetNewPassword(password: _passwordInputValueStream.value));
      _passwordInputIsSubmited.add(true);
    }
  }

  submitEmailInput() {
    if (_emailInputErrorStream?.value == null &&
        _emailInputValueStream.value.isNotEmpty) {
      accountDetailBloc
          .add(ChangeAccountEmail(email: _emailInputValueStream.value));
      _emailInputIsSubmited.add(true);
    }
  }

  submitNicknameInput() {
    if (_nicknameInputErrorStream?.value == null &&
        _nicknameInputValueStream.value.isNotEmpty) {
      accountDetailBloc
          .add(SetNewNickname(nickname: _nicknameInputValueStream.value));
      _nicknameInputIsSubmited.add(true);
    }
  }
}
