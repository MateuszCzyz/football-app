import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';
import 'package:FootballApp/blocs/account_detail_input_bloc/account_detail_input_bloc.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/local_widgets/email_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../local_widgets/submit_button.dart';

void showEmailDialog({required BuildContext context}) {
  final AccountDetailInputBloc _accountDetailInputBloc = AccountDetailInputBloc(
      accountDetailBloc: BlocProvider.of<AccountDetailBloc>(context));

  _accountDetailInputBloc.emailInputSubmitStatus.listen((inputIsSubmited) {
    if (inputIsSubmited) {
      Navigator.of(context).pop();
    }
  });

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Insert your new email', textAlign: TextAlign.center),
          content: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                SizedBox(height: 10),
                EmailInput(accountDetailInputBloc: _accountDetailInputBloc),
                SubmitButton(
                  label: 'Submit',
                  buttonFucntion: () {
                    _accountDetailInputBloc.submitEmailInput();
                  },
                )
              ],
            ),
          )));
}
