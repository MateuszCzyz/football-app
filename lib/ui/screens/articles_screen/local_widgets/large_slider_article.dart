import 'package:FootballApp/ui/screens/article_detail_screen/article_detail_screen.dart';
import 'package:FootballApp/utils/calculate_time.dart';
import 'package:FootballApp/ui/global_widgets/share_icon.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:FootballApp/ui/global_widgets/animated_bookmark_article_icon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FootballApp/models/article.dart';

class LargeArticle extends StatefulWidget {
  final Article article;
  final Key? key;

  LargeArticle({required this.article, this.key}) : super(key: key);

  @override
  State<LargeArticle> createState() => _LargeArticleState();
}

class _LargeArticleState extends State<LargeArticle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: HexColor('C8C5C5'), blurRadius: 5, spreadRadius: 0)
              ],
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: CachedNetworkImageProvider(widget.article.image!)),
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArticleIcons(
                article: widget.article,
              ),
              ArticleInformation(
                title: widget.article.title!,
                date: widget.article.date!,
              )
            ],
          ),
          height: 205,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ArticleDetailScreen(
                  article: widget.article,
                )));
      },
    );
  }
}

class ArticleIcons extends StatelessWidget {
  final Article article;

  ArticleIcons({required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ShareIcon(
            shareTitle: article.title!,
            shareURL: article.url!,
            iconColor: Colors.white,
          ),
          SizedBox(width: 5),
          AnimatedBookmarkArticleIcon(
            iconSize: 23,
            iconColor: Colors.white,
            article: article,
            key: ValueKey(article.id),
          )
        ],
      ),
    );
  }
}

class ArticleInformation extends StatelessWidget {
  final String title;
  final String date;

  ArticleInformation({required this.date, required this.title});

  @override
  Widget build(BuildContext context) {
    Map<String, String> articleTime = calculateTime(date: date);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                articleTime['timeSincePublished']!,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: HexColor('56DD8C'),
              ),
            ),
            SizedBox(height: 7),
            Text(
              title,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 17),
            ),
            SizedBox(height: 7),
            Text(articleTime['date']!,
                style: GoogleFonts.roboto(color: HexColor('D7D7D7')))
          ],
        ),
      ),
    );
  }
}
