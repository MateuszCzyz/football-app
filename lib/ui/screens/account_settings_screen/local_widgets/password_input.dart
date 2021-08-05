import 'package:FootballApp/blocs/account_detail_input_bloc/account_detail_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordInput extends StatelessWidget {
  final AccountDetailInputBloc accountDetailInputBloc;

  PasswordInput({this.accountDetailInputBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountDetailInputBloc.getPasswordErrorStream,
      builder: (context, snapshot) {
        return Container(
          width: 300,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('DDDDDD'), width: 1)),
                labelStyle: GoogleFonts.nunito(),
                labelText: 'Password',
                errorText: snapshot.data,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide:
                        BorderSide(width: 0.5, color: HexColor('FBFBFB')))),
            onChanged: (value) {
              accountDetailInputBloc.setPasswordValue(value);
            },
          ),
        );
      },
    );
  }
}
