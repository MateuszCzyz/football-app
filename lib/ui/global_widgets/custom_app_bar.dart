import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey[100],
      elevation: 1.0,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
      title: Text(
        'FootballApp',
        style: GoogleFonts.mogra(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }

  get preferredSize => new Size.fromHeight(50);
}
