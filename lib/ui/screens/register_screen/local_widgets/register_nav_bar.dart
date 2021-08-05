import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterNavBar extends StatelessWidget {
  final String title;
  final String description;

  RegisterNavBar({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18)),
          SizedBox(height: 5),
          Text(
            description,
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: HexColor('6798B4'),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(90))),
    );
  }
}
