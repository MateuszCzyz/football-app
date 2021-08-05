import 'package:FootballApp/ui/global_widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:FootballApp/ui/global_widgets/custom_app_bar.dart';
import 'package:FootballApp/models/app_data.dart';

class AboutApplicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(),
            body: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(
                      label: 'About application',
                      horizontalPadding: 0,
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppData.aboutApplicationContent,
                    ),
                    SizedBox(height: 20),
                    Text(AppData.firstApiLink),
                    SizedBox(height: 20),
                    Text(AppData.secondApiLink)
                  ],
                ))));
  }
}
