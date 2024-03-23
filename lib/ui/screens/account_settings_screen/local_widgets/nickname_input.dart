import 'package:FootballApp/blocs/account_detail_input_bloc/account_detail_input_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class NicknameInput extends StatelessWidget {
  final AccountDetailInputBloc accountDetailInputBloc;

  NicknameInput({required this.accountDetailInputBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountDetailInputBloc.getNicknameErrorStream,
      builder: (context, snapshot) {
        return Container(
          width: 300,
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('DDDDDD'), width: 1)),
                labelStyle: GoogleFonts.nunito(),
                labelText: 'New nickname',
                contentPadding: EdgeInsets.all(10),
                errorText: snapshot.data as String?,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                )),
            onChanged: (value) async {
              accountDetailInputBloc.setNicknameValue(value);
            },
          ),
        );
      },
    );
  }
}
