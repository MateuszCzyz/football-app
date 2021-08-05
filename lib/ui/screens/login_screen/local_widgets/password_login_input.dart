import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordLoginInput extends StatelessWidget {
  final TextEditingController passwordTextEditingController;
  final LoginFormValidationBloc loginFormValidationBloc;
  final FocusNode passwordFocusNode;

  PasswordLoginInput(
      {this.loginFormValidationBloc,
      this.passwordTextEditingController,
      this.passwordFocusNode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: loginFormValidationBloc.getPasswordErrorStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          width: 300,
          child: TextFormField(
            focusNode: passwordFocusNode,
            controller: passwordTextEditingController,
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
              loginFormValidationBloc.setPasswordValue(value);
            },
          ),
        );
      },
    );
  }
}
