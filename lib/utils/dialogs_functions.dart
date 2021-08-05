import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/dialogs/show_delete_account_dialog.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/dialogs/show_email_dialog.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/dialogs/show_nickname_dialog.dart';
import 'package:FootballApp/ui/screens/account_settings_screen/dialogs/show_password_dialog.dart';
import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';

changeEmailFunction(BuildContext context) {
  showEmailDialog(context: context);
}

changePasswordFunction(BuildContext context) {
  showPasswordDialog(context: context);
}

changeNicknameFunction(BuildContext context) {
  showNicknameDialog(context: context);
}

takeCameraPhotoFunction(BuildContext context) {
  BlocProvider.of<AccountDetailBloc>(context).add(TakeCameraPhoto());
}

takeGalleryPhotoFunction(BuildContext context) {
  BlocProvider.of<AccountDetailBloc>(context).add(TakeGalleryPhoto());
}

removeCurrentPhotoFunction(BuildContext context) {
  BlocProvider.of<AccountDetailBloc>(context).add(RemoveCurrentPhoto());
}

deleteAccountFunction(BuildContext context) {
  showDeleteAccountDialog(context: context);
}

logOutFunction(BuildContext context) {
  BlocProvider.of<AccountDetailBloc>(context).add(LogOut());
  Navigator.of(context).pop();
}
