import 'package:flutter/material.dart';
import 'package:FootballApp/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/article_list_bloc/article_list_bloc.dart';
import 'package:FootballApp/ui/screens/articles_screen/local_widgets/small_single_article.dart';

class AnotherArticles extends StatefulWidget {
  final List<Article> initialArticles;

  AnotherArticles({this.initialArticles});
  @override
  _AnotherArticlesState createState() => _AnotherArticlesState();
}

class _AnotherArticlesState extends State<AnotherArticles> {
  List<Article> _articles;

  @override
  void initState() {
    super.initState();
    _articles = List.from(widget.initialArticles);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ArticleListBloc, ArticleListState>(
      listener: (context, state) {
        if (state is SuccessFetchedNextPage) {
          _articles.addAll(state.articles);
        }
      },
      builder: (context, state) {
        return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              if (index <= _articles.length) {
                if (index == _articles.length) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return LittleArticle(
                    article: _articles[index],
                  );
                }
              } else {
                return null;
              }
            });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
