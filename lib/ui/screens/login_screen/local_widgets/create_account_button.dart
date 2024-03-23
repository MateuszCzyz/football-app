import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FootballApp/ui/screens/register_screen/register_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateAccountButton extends StatelessWidget {
  final LoginFormValidationBloc loginFormValidationBloc;
  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  CreateAccountButton({
    required this.loginFormValidationBloc,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: InkWell(
        child: Text('Create a new account',
            style: GoogleFonts.nunito(color: HexColor('888888'))),
        onTap: () {
          _clearLoginForm(context);
        },
      ),
    );
  }

  _clearLoginForm(context) {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
    loginFormValidationBloc.clearForm();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}
