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
        child: RaisedButton(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(LogoutAuthentication());
          },
          color: HexColor('898989'),
          child: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
