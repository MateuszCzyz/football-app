import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'sign_in_email_button.dart';
import 'sign_in_google_button.dart';
import 'create_account_button.dart';

class ButtonsBuilder extends StatelessWidget {
  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final LoginFormValidationBloc loginFormValidationBloc;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  ButtonsBuilder({
    required this.loginFormValidationBloc,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginLoading) {
          return _loadingWidget();
        } else {
          return _buttonsWidget();
        }
      },
    );
  }

  Widget _buttonsWidget() => Container(
        margin: EdgeInsets.only(top: 15),
        child: Column(
          children: [
            SignInWithEmailButton(
              loginFormValidationBloc: loginFormValidationBloc,
            ),
            CreateAccountButton(
              emailFocusNode: emailFocusNode,
              passwordFocusNode: passwordFocusNode,
              emailTextEditingController: emailTextEditingController,
              passwordTextEditingController: passwordTextEditingController,
              loginFormValidationBloc: loginFormValidationBloc,
            ),
            SignInWithGoogleButton()
          ],
        ),
      );

  Widget _loadingWidget() => Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: 40,
          height: 40,
          child: CircularProgressIndicator(),
        ),
      );
}
