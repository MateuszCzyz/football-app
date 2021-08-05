import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'local_widgets/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/show_snackbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: HexColor('FBFBFB'),
          body: SingleChildScrollView(
            child: BlocListener<RegisterBloc, RegisterState>(
                listener: _registerBlocListener, child: RegistrationForm()),
          )),
    );
  }

  _registerBlocListener(context, state) {
    if (state is FailureRegistration) {
      showFailureSnakcBar(context: context, message: state.errorMessage);
    } else if (state is SuccessRegistration) {
      Navigator.of(context).pop();
    }
  }
}
