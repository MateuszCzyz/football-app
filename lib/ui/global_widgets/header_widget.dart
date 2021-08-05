import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String label;
  final double horizontalPadding;

  Header({this.label, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: 10,
          bottom: 5),
      child: Text(label,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 22)),
    );
  }
}
