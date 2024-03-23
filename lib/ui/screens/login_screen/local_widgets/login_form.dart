import 'package:FootballApp/blocs/login_form_validation_bloc/login_form_validation_bloc.dart';
import 'package:flutter/material.dart';
import 'email_login_input.dart';
import 'package:FootballApp/ui/global_widgets/authentication_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:FootballApp/models/app_data.dart';
import 'buttons_builder.dart';
import 'password_login_input.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final LoginFormValidationBloc _loginFormValidationBloc =
        LoginFormValidationBloc(loginBloc: BlocProvider.of<LoginBloc>(context));
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthenticationNavBar(
                  title: AppData.loginFormTitle,
                  description: AppData.loginFormDescription),
              EmailLoginInput(
                emailFocusNode: _emailFocusNode,
                emailTextEditingController: _emailTextEditingController,
                loginFormValidationBloc: _loginFormValidationBloc,
              ),
              PasswordLoginInput(
                passwordFocusNode: _passwordFocusNode,
                passwordTextEditingController: _passwordTextEditingController,
                loginFormValidationBloc: _loginFormValidationBloc,
              ),
              ButtonsBuilder(
                emailFocusNode: _emailFocusNode,
                passwordFocusNode: _passwordFocusNode,
                emailTextEditingController: _emailTextEditingController,
                passwordTextEditingController: _passwordTextEditingController,
                loginFormValidationBloc: _loginFormValidationBloc,
              )
            ],
          ),
        ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }
}
