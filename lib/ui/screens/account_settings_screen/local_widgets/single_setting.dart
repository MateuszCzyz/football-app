import 'package:flutter/material.dart';

class SingleSetting extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final Function settingFunction;

  SingleSetting({
    required this.label,
    required this.isEnabled,
    required this.settingFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          enableFeedback: isEnabled,
          child: Text(label,
              style: isEnabled
                  ? TextStyle(fontSize: 15)
                  : TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough)),
          onTap: () {
            settingFunction(context);
          },
        ),
        Divider(),
        SizedBox(height: 5)
      ],
    );
  }
}
