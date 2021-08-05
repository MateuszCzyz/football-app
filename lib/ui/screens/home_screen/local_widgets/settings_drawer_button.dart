import 'package:FootballApp/ui/screens/account_settings_screen/account_settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsDrawerButton extends StatelessWidget {
  final User user;

  SettingsDrawerButton({this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              color: HexColor('888888'),
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'Account settings',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 15, color: HexColor('666666')),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AccountSettingsScreen(
                  user: user,
                )));
      },
    );
  }
}
