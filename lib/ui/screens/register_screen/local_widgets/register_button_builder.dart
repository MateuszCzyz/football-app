import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'package:FootballApp/blocs/register_form_validation_bloc/register_form_validation_bloc.dart';

class RegisterButtonBuilder extends StatelessWidget {
  final RegisterFormValidationBloc registerFormValidationBloc;

  RegisterButtonBuilder({this.registerFormValidationBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        width: 300,
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoading) {
              return _loadingWidget();
            } else {
              return _registerButton();
            }
          },
        ));
  }

  Widget _registerButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          primary: HexColor('6798B4'),
        ),
        child: Text(
          'Create an account',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          registerFormValidationBloc.createAccountWithValidate();
        },
      );

  Widget _loadingWidget() => Center(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          width: 40,
          height: 40,
          child: CircularProgressIndicator(),
        ),
      );
}
