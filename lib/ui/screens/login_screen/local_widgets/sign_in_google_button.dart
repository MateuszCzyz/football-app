import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          primary: HexColor('F0F0F0'),
          elevation: 0.5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15),
            SvgPicture.asset('assets/images/google.svg', width: 20, height: 20),
            SizedBox(width: 10),
            Text(
              'Sign in with google',
              style: GoogleFonts.nunito(
                  color: Colors.black54, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(SigInWithGoogle());
        },
      ),
    );
  }
}
