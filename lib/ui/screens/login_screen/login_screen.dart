import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'local_widgets/login_form.dart';
import '../../../utils/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor('FBFBFB'),
            body: SingleChildScrollView(
              child: MultiBlocListener(listeners: [
                BlocListener<LoginBloc, LoginState>(
                    listener: _loginBlocListener),
                BlocListener<RegisterBloc, RegisterState>(
                    listener: _registerBlocListener)
              ], child: LoginForm()),
            )));
  }

  _loginBlocListener(context, state) {
    if (state is LoginSuccess) {
      Navigator.of(context).pop();
    } else if (state is LoginFailure) {
      showFailureSnakcBar(context: context, message: state.errorMessage);
    }
  }

  _registerBlocListener(context, state) {
    if (state is SuccessRegistration) {
      showSuccessSnackBar(
          context: context,
          message: 'Your account has been sucessfully created!');
    }
  }
}
