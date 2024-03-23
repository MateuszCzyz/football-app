import 'package:flutter/material.dart';
import 'package:FootballApp/utils/calculate_time.dart';

class AdditionalInformation extends StatelessWidget {
  final String author;
  final String date;

  AdditionalInformation({
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, String> _articleTime = calculateTime(date: date);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(author),
          Text(_articleTime['date']!),
        ],
      ),
    );
  }
}
