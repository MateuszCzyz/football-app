import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FootballApp/ui/global_widgets/header_widget.dart';
import 'package:FootballApp/utils/dialogs_functions.dart';
import 'single_setting.dart';

class AccountSettingsSection extends StatelessWidget {
  final User user;

  AccountSettingsSection({this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(horizontalPadding: 0, label: 'Account'),
        SizedBox(height: 20),
        SingleSetting(
          isEnabled:
              user.providerData[0].providerId != 'google.com' ? true : false,
          label: 'Change an account email',
          settingFunction: changeEmailFunction,
        ),
        SingleSetting(
          isEnabled:
              user.providerData[0].providerId != 'google.com' ? true : false,
          label: 'Set a new password',
          settingFunction: changePasswordFunction,
        ),
        SingleSetting(
          isEnabled: true,
          label: 'Set a new nickname',
          settingFunction: changeNicknameFunction,
        )
      ],
    );
  }
}

class ImageSettingsSection extends StatelessWidget {
  final User user;

  ImageSettingsSection({this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(horizontalPadding: 0, label: 'Image'),
        SizedBox(height: 20),
        SingleSetting(
          isEnabled: true,
          label: 'Take a camera photo',
          settingFunction: takeCameraPhotoFunction,
        ),
        SingleSetting(
          isEnabled: true,
          label: 'Take photo from the gallery',
          settingFunction: takeGalleryPhotoFunction,
        ),
        SingleSetting(
          isEnabled: user.photoURL != null ? true : false,
          label: 'Remove a current photo',
          settingFunction: removeCurrentPhotoFunction,
        ),
      ],
    );
  }
}

class OtherSettingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(horizontalPadding: 0, label: 'Operations'),
        SizedBox(height: 20),
        SingleSetting(
          isEnabled: true,
          label: 'Delete account',
          settingFunction: deleteAccountFunction,
        ),
        SingleSetting(
          isEnabled: true,
          label: 'Log out',
          settingFunction: logOutFunction,
        ),
      ],
    );
  }
}
