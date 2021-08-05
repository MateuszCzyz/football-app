import 'package:FootballApp/blocs/article_list_bloc/article_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/ui/screens/articles_screen/local_widgets/another_articles.dart';
import 'package:FootballApp/ui/screens/articles_screen/local_widgets/slider.dart';
import 'package:FootballApp/ui/global_widgets/custom_error_widget.dart';

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with AutomaticKeepAliveClientMixin<ArticleScreen> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          BlocProvider.of<ArticleListBloc>(context).add(FetchNextPage());
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleListBloc, ArticleListState>(
      buildWhen: _buildWhenFunction,
      builder: (context, state) {
        if (state is SuccessFetchedFirstPage) {
          return Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              controller: _scrollController,
              children: [
                SliderWidget(
                  articles: state.articles.getRange(0, 5).toList(),
                ),
                AnotherArticles(
                  initialArticles: state.articles
                      .getRange(6, state.articles.length - 1)
                      .toList(),
                ),
              ],
            ),
          );
        } else if (state is FailureFetchedFirstPage) {
          return CustomErrorWidget(
            title: 'Something went wrong',
            description:
                'There is no any articles, check your network conectivity or try it later',
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  bool _buildWhenFunction(previousState, state) {
    if (state is SuccessFetchedFirstPage || state is FailureFetchedFirstPage) {
      return true;
    } else {
      return false;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
