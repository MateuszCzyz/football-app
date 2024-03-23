import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'local_widgets/account_data.dart';
import 'local_widgets/account_settings_panel.dart';
import 'package:FootballApp/ui/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettingsScreen extends StatelessWidget {
  final User user;

  AccountSettingsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: CustomAppBar(), body: BodyBuilder()),
    );
  }
}

class BodyBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is SuccesAuthentication) {
              return ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  AccountData(
                    user: state.user!,
                  ),
                  AccountSettingsPanel(
                    user: state.user!,
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
