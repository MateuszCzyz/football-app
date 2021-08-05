import 'local_widgets/bookmark_articles_builder.dart';
import 'local_widgets/bookmark_videos_builder.dart';
import 'package:flutter/material.dart';
import 'package:FootballApp/ui/global_widgets/header_widget.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Header(
          label: 'Bookmarked articles',
          horizontalPadding: 10,
        ),
        BookmarkArticlesBuilder(),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10), child: Divider()),
        Header(
          label: 'Bookmarked videos',
          horizontalPadding: 10,
        ),
        BookmarkVideosBuilder(),
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10), child: Divider()),
      ],
    );
  }
}
