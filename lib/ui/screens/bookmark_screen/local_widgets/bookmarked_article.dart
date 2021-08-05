import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:FootballApp/utils/calculate_time.dart';
import 'package:FootballApp/ui/screens/bookmark_article_detail_screen/bookmark_article_detail_screen.dart';
import 'bookmark_article_icon.dart';
import 'package:FootballApp/models/article.dart';
import '../../../global_widgets/time_widget.dart';
import 'dart:io';

class BookmarkedArticle extends StatefulWidget {
  final Article article;

  BookmarkedArticle({this.article, Key key}) : super(key: key);

  @override
  State<BookmarkedArticle> createState() => _BookmarkedArticleState();
}

class _BookmarkedArticleState extends State<BookmarkedArticle> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> articleTime = calculateTime(date: widget.article.date);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => BookmarkArticleDetailScreen(
                  article: widget.article,
                )));
      },
      child: Container(
        height: 170,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: HexColor('D9D6D6'), blurRadius: 5, spreadRadius: 0)
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: FileImage(File(widget.article.image)))),
              ),
            ),
            Expanded(
                flex: 7,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TimeWidget(
                                timeSincePublished:
                                    articleTime['timeSincePublished'],
                                color: '888888',
                              ),
                              SizedBox(height: 10),
                              AutoSizeText(
                                widget.article.title,
                                maxLines: 3,
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  articleTime['date'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: HexColor('373737'),
                                          fontSize: 12),
                                ),
                                BookmarkArticleIcon(
                                  iconSize: 23,
                                  iconColor: HexColor('676767'),
                                  article: widget.article,
                                  key: ValueKey(widget.article.id),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
