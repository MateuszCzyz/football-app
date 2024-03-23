import 'package:FootballApp/utils/remove_html_tags_from_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleContent extends StatelessWidget {
  final String title;
  final List<dynamic> articleList;
  final int numberOfLines;

  ArticleContent({
    required this.title,
    required this.articleList,
    required this.numberOfLines,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
      child: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          Map<String, dynamic> content = articleList[index];
          String paragraph = removeHtmlTagsFromStrings(content: content['p']);
          return Html(
              data: index == 0
                  ? ('<h2>' + title + '</h2><br><br>' + paragraph)
                  : paragraph
              // renderNewlines: false,
              // defaultTextStyle: GoogleFonts.roboto(fontSize: 16),
              );
        },
        itemCount: (numberOfLines - 1),
      ),
    );
  }
}
