import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FootballApp/ui/global_widgets/animated_bookmark_article_icon.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../global_widgets/share_icon.dart';
import '../../../blocs/article_detail_bloc/article_detail_bloc.dart';
import 'local_widgets/article_detail_widget.dart';
import 'package:FootballApp/resources/repositories/users_repository.dart';
import 'package:FootballApp/models/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  ArticleDetailScreen({this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: BlocProvider<ArticleDetailBloc>(
      create: (context) => ArticleDetailBloc(
        articleRepository: RepositoryProvider.of<ArticleRepository>(context),
        usersRepository: RepositoryProvider.of<UsersRepository>(context),
      )..add(FetchDetail(slug: article.slug, articleID: article.id)),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.grey[50],
            expandedHeight: 350,
            flexibleSpace: _getFlexibleSpaceBar(),
          ),
          ArticleDetail(
            date: article.date,
            title: article.title,
            articleID: article.id,
          )
        ],
      ),
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
                shareTitle: article.title,
                shareURL: article.url,
              ),
              SizedBox(width: 3),
              AnimatedBookmarkArticleIcon(
                iconColor: Colors.white,
                iconSize: 23,
                article: article,
                key: ValueKey(article.id),
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
                image: CachedNetworkImageProvider(
                  article.image,
                ))),
      ),
    );
  }
}
