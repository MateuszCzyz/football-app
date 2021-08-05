import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'package:FootballApp/blocs/register_form_validation_bloc/register_form_validation_bloc.dart';
import 'package:FootballApp/models/app_data.dart';
import 'package:flutter/material.dart';
import 'register_button_builder.dart';
import 'email_register_input.dart';
import 'register_nav_bar.dart';
import 'password_register_input.dart';
import 'second_register_password_input.dart';

class RegistrationForm extends StatelessWidget {
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final RegisterFormValidationBloc _registerFormValidationBloc =
        RegisterFormValidationBloc(
            registerBloc: BlocProvider.of<RegisterBloc>(context));

    return Builder(
      builder: (context) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RegisterNavBar(
                  title: AppData.registerFormTitle,
                  description: AppData.registerFormDescription),
              EmailRegisterInput(
                registerFormValidationBloc: _registerFormValidationBloc,
              ),
              PasswordRegisterInput(
                registerFormValidationBloc: _registerFormValidationBloc,
              ),
              SecondRegisterPasswordInput(
                registerFormValidationBloc: _registerFormValidationBloc,
              ),
              RegisterButtonBuilder(
                registerFormValidationBloc: _registerFormValidationBloc,
              )
            ],
          ),
        );
      },
    );
  }
}
