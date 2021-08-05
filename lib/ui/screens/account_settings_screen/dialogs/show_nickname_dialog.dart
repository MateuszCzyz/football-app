import 'package:flutter/material.dart';
import '../local_widgets/submit_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/account_detail_input_bloc/account_detail_input_bloc.dart';
import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/local_widgets/nickname_input.dart';

void showNicknameDialog({BuildContext context}) {
  final AccountDetailInputBloc _accountDetailInputBloc = AccountDetailInputBloc(
      accountDetailBloc: BlocProvider.of<AccountDetailBloc>(context));

  _accountDetailInputBloc.nicknameInputSubmitStatus.listen((inputIsSubmited) {
    if (inputIsSubmited) {
      Navigator.of(context).pop();
    }
  });

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Insert your new nickname', textAlign: TextAlign.center),
          content: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                SizedBox(height: 10),
                NicknameInput(
                  accountDetailInputBloc: _accountDetailInputBloc,
                ),
                SubmitButton(
                  label: 'Submit',
                  buttonFucntion: () {
                    _accountDetailInputBloc.submitNicknameInput();
                  },
                )
              ],
            ),
          )));
}
