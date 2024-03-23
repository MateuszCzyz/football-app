import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FootballApp/blocs/register_form_validation_bloc/register_form_validation_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordRegisterInput extends StatelessWidget {
  final RegisterFormValidationBloc registerFormValidationBloc;

  PasswordRegisterInput({required this.registerFormValidationBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: registerFormValidationBloc.getPasswordErrorStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 20),
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
              registerFormValidationBloc.setPasswordValue(value);
            },
          ),
        );
      },
    );
  }
}
