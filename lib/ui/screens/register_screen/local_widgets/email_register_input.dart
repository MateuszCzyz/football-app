import 'package:FootballApp/blocs/register_form_validation_bloc/register_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailRegisterInput extends StatelessWidget {
  final RegisterFormValidationBloc registerFormValidationBloc;

  EmailRegisterInput({required this.registerFormValidationBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: registerFormValidationBloc.getEmailErrorStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(top: 50),
          width: 300,
          child: TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor('DDDDDD'), width: 1)),
                labelStyle: GoogleFonts.nunito(),
                labelText: 'Email',
                contentPadding: EdgeInsets.all(10),
                errorText: snapshot.data as String?,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                )),
            onChanged: (value) {
              registerFormValidationBloc.setEmailValue(value);
            },
          ),
        );
      },
    );
  }
}
