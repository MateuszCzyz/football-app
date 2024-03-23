import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:FootballApp/blocs/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'bookmarked_article.dart';
import 'package:FootballApp/models/article.dart';

class BookmarkArticlesBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Box _articlesBox =
        BlocProvider.of<BookmarkArticleBloc>(context).getArticlesBox;
    return ValueListenableBuilder(
        valueListenable: _articlesBox.listenable(),
        builder: (context, box, widget) {
          if (_articlesBox.length > 0) {
            return Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: ListView.builder(
                physics: ScrollPhysics(),
                addAutomaticKeepAlives: false,
                shrinkWrap: true,
                itemCount: _articlesBox.length,
                itemBuilder: (context, index) {
                  return BookmarkedArticle(
                    article: Article.fromMap(
                      (box as Box).getAt(index),
                    ),
                  );
                },
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Text('There is no any bookmarked articles',
                  style: TextStyle(color: Colors.black54)),
            );
          }
        });
  }
}
