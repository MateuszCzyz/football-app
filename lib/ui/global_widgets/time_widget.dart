import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class TimeWidget extends StatelessWidget {
  final String timeSincePublished;
  final String color;

  TimeWidget({this.timeSincePublished, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: HexColor(color), borderRadius: BorderRadius.circular(3)),
      child: Text(
        timeSincePublished,
        style: GoogleFonts.roboto(
            color: Colors.white, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
