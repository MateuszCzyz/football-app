import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FootballApp/ui/global_widgets/account_image_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountData extends StatelessWidget {
  final User user;

  AccountData({this.user});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountImage(
              size: 60,
              heroTag: 'account_setting_image',
              displayName: user.displayName,
              userHasImage: user.photoURL != null ? true : false,
              imagePath: user.photoURL,
              fontSize: 20,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: GoogleFonts.nunito(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  user.email,
                  style: GoogleFonts.nunito(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
        Divider()
      ],
    );
  }
}
