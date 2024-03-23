import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';

class SignInWithEmailButton extends StatelessWidget {
  final LoginFormValidationBloc loginFormValidationBloc;

  SignInWithEmailButton({required this.loginFormValidationBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          backgroundColor: HexColor('6798B4'),
        ),
        onPressed: () {
          loginFormValidationBloc.signInWithValidate();
        },
        child: Text(
          'Sign in',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
