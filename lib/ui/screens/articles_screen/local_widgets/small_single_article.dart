import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:FootballApp/utils/calculate_time.dart';
import 'package:FootballApp/models/article.dart';
import 'package:FootballApp/ui/global_widgets/animated_bookmark_article_icon.dart';
import 'package:FootballApp/ui/global_widgets/time_widget.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/article_detail_screen.dart';

class LittleArticle extends StatelessWidget {
  final Article article;

  LittleArticle({required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 170,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: HexColor('D9D6D6'), blurRadius: 5, spreadRadius: 0)
            ]),
        child: Row(
          children: [
            ArticleImage(
              article: article,
            ),
            ArticleData(
              article: article,
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ArticleDetailScreen(
                  article: article,
                )));
      },
    );
  }
}

class ArticleData extends StatelessWidget {
  final Article article;

  ArticleData({required this.article});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 7,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainInformation(
                  article: article,
                ),
                BottomInformation(
                  article: article,
                )
              ],
            )));
  }
}

class ArticleImage extends StatelessWidget {
  final Article article;

  ArticleImage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: CachedNetworkImageProvider(
                  article.image!,
                ))),
      ),
    );
  }
}

class MainInformation extends StatelessWidget {
  final Article article;
  final Map<String, String> articleTime;

  MainInformation({required this.article})
      : articleTime = calculateTime(date: article.date);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TimeWidget(
            timeSincePublished: articleTime['timeSincePublished']!,
            color: '888888',
          ),
          SizedBox(height: 10),
          AutoSizeText(
            article.title!,
            maxLines: 3,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}

class BottomInformation extends StatelessWidget {
  final Article article;
  final Map<String, String> articleTime;

  BottomInformation({required this.article})
      : articleTime = calculateTime(date: article.date);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              articleTime['date']!,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: HexColor('373737'), fontSize: 12),
            ),
            AnimatedBookmarkArticleIcon(
              iconSize: 23,
              iconColor: HexColor('676767'),
              article: article,
              key: ValueKey(article.id),
            )
          ],
        )
      ],
    );
  }
}
