import 'package:FootballApp/blocs/register_form_validation_bloc/register_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SecondRegisterPasswordInput extends StatelessWidget {
  final RegisterFormValidationBloc registerFormValidationBloc;

  SecondRegisterPasswordInput({this.registerFormValidationBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: registerFormValidationBloc.getSecondPasswordErrorStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          width: 300,
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('DDDDDD'), width: 1)),
                labelStyle: GoogleFonts.nunito(),
                labelText: 'Repeat password',
                errorText: snapshot.data,
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide:
                        BorderSide(width: 0.5, color: HexColor('FBFBFB')))),
            onChanged: (value) {
              registerFormValidationBloc.setSecondPasswordValue(value);
            },
          ),
        );
      },
    );
  }
}
