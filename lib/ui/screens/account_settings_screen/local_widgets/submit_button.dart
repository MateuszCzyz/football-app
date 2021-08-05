import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final void Function() buttonFucntion;

  SubmitButton({this.label, this.buttonFucntion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: HexColor('6798B4'),
          ),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
            child: Text(label, textAlign: TextAlign.center),
          ),
          onPressed: buttonFucntion),
    );
  }
}
