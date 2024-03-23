import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';
import 'package:FootballApp/utils/show_snackbar.dart';
import 'settings_sections.dart';

class AccountSettingsPanel extends StatelessWidget {
  final User user;
  late List<Widget> _settings;

  AccountSettingsPanel({required this.user}) {
    _settings = [
      AccountSettingsSection(user: user),
      ImageSettingsSection(user: user),
      OtherSettingsSection()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountDetailBloc, AccountDetailState>(
      listener: _accountDetailBlocListener,
      builder: (context, state) {
        if (state is LoadingAccountData) {
          return Container(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _settings);
        }
      },
    );
  }

  _accountDetailBlocListener(context, state) {
    if (state is SuccessUpdatedAccountData) {
      showSuccessSnackBar(
          context: context,
          message: 'An account data has been successfully updated');
    } else if (state is FailureUpdatedAccountData) {
      showFailureSnakcBar(context: context, message: state.errorMessage);
    }
  }
}
