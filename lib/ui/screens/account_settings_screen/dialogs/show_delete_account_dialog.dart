import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';

void showDeleteAccountDialog({BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Deleting account', textAlign: TextAlign.center),
            content: Text('Are you sure to delete your account?'),
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<AccountDetailBloc>(context)
                        .add(DeleteAccount());
                    Navigator.of(context)..pop()..pop();
                  },
                  child: Text(
                    'Yes',
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No', style: TextStyle(color: Colors.grey))),
            ],
          ));
}
