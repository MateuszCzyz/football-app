import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailLoginInput extends StatelessWidget {
  final TextEditingController emailTextEditingController;
  final LoginFormValidationBloc loginFormValidationBloc;
  final FocusNode emailFocusNode;

  EmailLoginInput(
      {this.emailTextEditingController,
      this.loginFormValidationBloc,
      this.emailFocusNode});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: loginFormValidationBloc.getEmailErrorStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 50),
          width: 300,
          child: TextFormField(
            focusNode: emailFocusNode,
            controller: emailTextEditingController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('DDDDDD'), width: 1)),
                labelStyle: GoogleFonts.nunito(),
                labelText: 'Email',
                contentPadding: EdgeInsets.all(10),
                errorText: snapshot.data,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                )),
            onChanged: (value) {
              loginFormValidationBloc.setEmailValue(value);
            },
          ),
        );
      },
    );
  }
}
