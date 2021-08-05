import 'package:FootballApp/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:FootballApp/models/article_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './comment_widget.dart';
import 'package:FootballApp/models/firestore_user.dart';

class CommentsStream extends StatelessWidget {
  final Stream<QuerySnapshot> commentsStream;
  int index;
  CommentsStream({this.commentsStream}) : index = 0;

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    final ArticleDetailBloc _articleDetailBloc =
        BlocProvider.of<ArticleDetailBloc>(context);
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            FutureBuilder(
              future: _articleDetailBloc.getUsersList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<FirestoreUser>> future) {
                if (future.hasData) {
                  return StreamBuilder(
                      stream: commentsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.length > 0) {
                            return Column(
                              children: snapshot.data.docs.map((doc) {
                                index++;
                                Map<String, dynamic> _data = doc.data();
                                FirestoreUser _firestoreUser =
                                    _articleDetailBloc.getUserData(
                                        users: future.data,
                                        userID: _data['id_user']);
                                return CommentWidget(
                                  commentMessage: _data['content'],
                                  date: _data['date'],
                                  commentID: _data['id_comment'],
                                  userHasImage: _firestoreUser.userHasImage,
                                  imagePath: _firestoreUser.imagePath,
                                  userName: _firestoreUser.nickname,
                                  index: index,
                                  theCurrentUserComment:
                                      _firestoreUser.userID ==
                                              _authenticationBloc
                                                  .getCurrentUser()
                                                  ?.uid
                                          ? true
                                          : false,
                                );
                              }).toList(),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              child: Text('There is no any comments'),
                            );
                          }
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            child: Text('Loading comments...'),
                          );
                        }
                      });
                } else {
                  return Text('Connecting with server...');
                }
              },
            ),
            Divider()
          ],
        ));
  }
}
