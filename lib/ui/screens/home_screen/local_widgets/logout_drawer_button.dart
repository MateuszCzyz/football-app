import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class LogoutDrawerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('898989'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(LogoutAuthentication());
          },
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
