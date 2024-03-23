import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:FootballApp/ui/screens/login_screen/login_screen.dart';

class LoginDrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('6798B4'), // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text(
            'Sign in',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
