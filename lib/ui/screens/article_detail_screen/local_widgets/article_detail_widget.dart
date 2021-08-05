import 'package:FootballApp/ui/global_widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/local_widgets/comments_stream_widget.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/local_widgets/add_comment_menu_widget.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/local_widgets/additional_information_widget.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/local_widgets/article_content_widget.dart';

class ArticleDetail extends StatelessWidget {
  final String title;
  final String date;
  final String articleID;

  ArticleDetail({this.date, this.title, this.articleID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
      builder: (context, state) {
        if (state is SuccessFetchedDetail) {
          return SliverList(
              delegate: SliverChildListDelegate([
            ArticleContent(
              articleList: state.articleDetail.content,
              numberOfLines: state.articleDetail.content.length,
              title: title,
            ),
            AdditionalInformation(
              author: state.articleDetail.author,
              date: date,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
            CommentsStream(
              commentsStream: state.commentsSnapshot,
            ),
            AddCommentMenu(
              articleID: articleID,
            )
          ]));
        } else if (state is FailureFetchedDetail) {
          return SliverFillRemaining(
            child: Center(
              child: CustomErrorWidget(
                title: 'Something went wrong',
                description:
                    'There is no detail data of this article, something went wrong with database or your network conectivity',
              ),
            ),
          );
        } else {
          return SliverFillRemaining(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
      },
    );
  }
}
