import 'package:FootballApp/blocs/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/models/article_detail.dart';
import '../../global_widgets/share_icon.dart';
import 'package:FootballApp/ui/global_widgets/animated_bookmark_article_icon.dart';
import 'local_widgets/additional_information_widget.dart';
import 'local_widgets/article_content_widget.dart';
import 'package:FootballApp/models/article.dart';
import 'dart:io';

class BookmarkArticleDetailScreen extends StatefulWidget {
  final Article article;

  BookmarkArticleDetailScreen({this.article});

  @override
  State<BookmarkArticleDetailScreen> createState() =>
      _BookmarkArticleDetailScreenState();
}

class _BookmarkArticleDetailScreenState
    extends State<BookmarkArticleDetailScreen> {
  ArticleDetail articleDetail;

  @override
  void initState() {
    super.initState();
    articleDetail = BlocProvider.of<BookmarkArticleBloc>(context)
        .getBookmarkedArticleDetail(articleID: widget.article.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.grey[50],
          expandedHeight: 350,
          flexibleSpace: _getFlexibleSpaceBar(),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          ArticleContent(
              articleList: articleDetail.content,
              numberOfLines: articleDetail.content.length,
              title: widget.article.title),
          AdditionalInformation(
              author: articleDetail.author, date: widget.article.date),
        ]))
      ],
    )));
  }

  FlexibleSpaceBar _getFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      title: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShareIcon(
                iconColor: Colors.white,
                shareTitle: widget.article.title,
                shareURL: widget.article.url,
              ),
              SizedBox(width: 3),
              AnimatedBookmarkArticleIcon(
                iconSize: 23,
                iconColor: Colors.white,
                article: widget.article,
                key: ValueKey(widget.article.id),
              ),
              SizedBox(
                width: 3,
              )
            ],
          )),
      background: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: FileImage(File(widget.article.image)))),
      ),
    );
  }
}
