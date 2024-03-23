import 'package:flutter/material.dart';
import 'package:FootballApp/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/bookmark_article_bloc/bookmark_article_bloc.dart';

class BookmarkArticleIcon extends StatefulWidget {
  final Color iconColor;
  final double iconSize;
  final Article article;
  final ValueKey key;

  BookmarkArticleIcon({
    required this.iconColor,
    required this.iconSize,
    required this.article,
    required this.key,
  }) : super(key: key);

  @override
  _AnimatedBookmarkArticleIconState createState() =>
      _AnimatedBookmarkArticleIconState();
}

class _AnimatedBookmarkArticleIconState extends State<BookmarkArticleIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Icon(
          Icons.bookmark,
          color: widget.iconColor,
          size: widget.iconSize,
        ),
        onTap: () {
          BlocProvider.of<BookmarkArticleBloc>(context).add(
            RemoveBookmarkedArticle(article: widget.article),
          );
        });
  }
}
