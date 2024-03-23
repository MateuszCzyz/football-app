import 'package:FootballApp/ui/screens/about_application_screen/about_application_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

class AboutApplicationDrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline,
              color: HexColor('888888'),
              size: 20,
            ),
            SizedBox(width: 5),
            Text(
              'About application',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 15,
                    color: HexColor('666666'),
                  ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AboutApplicationScreen()));
      },
    );
  }
}
