import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:FootballApp/utils/calculate_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../global_widgets/account_image_widget.dart';

class CommentWidget extends StatelessWidget {
  final String commentID;
  final String commentMessage;
  final String date;
  final String imagePath;
  final bool userHasImage;
  final bool theCurrentUserComment;
  final int index;
  String userName;

  CommentWidget(
      {this.userName,
      this.commentMessage,
      this.userHasImage,
      this.imagePath,
      this.date,
      this.index,
      this.theCurrentUserComment,
      this.commentID}) {
    if (userName.length > 20) userName = userName.substring(0, 20) + '...';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> _calucatedTime = calculateTime(date: date);
    return PopupMenuButton(
      elevation: 1,
      enableFeedback: theCurrentUserComment,
      enabled: theCurrentUserComment,
      itemBuilder: (context) => [
        PopupMenuItem(
            value: commentID,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.black54,
                ),
                Text('Remove comment')
              ],
            ))
      ],
      child: Row(
        children: [
          AccountImage(
            size: 40,
            displayName: userName,
            imagePath: imagePath,
            userHasImage: userHasImage,
            heroTag: 'comment_widget_$index',
            fontSize: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(theCurrentUserComment ? '$userName (You)' : userName,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15)),
                    Text(
                      _calucatedTime['date'],
                      style: TextStyle(fontSize: 11, color: Colors.black45),
                    )
                  ],
                ),
                Text(
                  commentMessage,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
      onSelected: (commentID) async {
        await RepositoryProvider.of<ArticleRepository>(context)
            .removeCommentFromArticle(commentID: commentID);
      },
    );
  }
}
