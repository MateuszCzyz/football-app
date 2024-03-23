import 'package:flutter/material.dart';
import 'header_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String description;

  CustomErrorWidget({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Header(
              horizontalPadding: 0,
              label: title,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
    );
  }
}
