import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendMessageIcon extends StatefulWidget {
  final TextEditingController commentMessage;
  final FocusNode focusNode;
  final String articleID;
  final User currentUser;

  SendMessageIcon(
      {this.commentMessage, this.articleID, this.focusNode, this.currentUser});

  @override
  State<SendMessageIcon> createState() => _SendMessageIconState();
}

class _SendMessageIconState extends State<SendMessageIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _absorbIcon = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            if (_animationController.isCompleted) {
              _animationController.reverse();
              setState(() {
                _absorbIcon = false;
              });
            }
          });
    _animation =
        Tween<double>(begin: 1.0, end: 1.4).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: AbsorbPointer(
          absorbing: _absorbIcon,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Icon(Icons.send, color: HexColor('888888')),
                  ),
                );
              }),
        ),
      ),
      onTap: () async {
        _animationController.forward();
        sendCommentToArticle(
            textEditingController: widget.commentMessage,
            context: context,
            focusNode: widget.focusNode,
            commentMessage: widget.commentMessage.text,
            articleID: widget.articleID,
            userID: widget.currentUser.uid);
        setState(() {
          _absorbIcon = true;
        });
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

void sendCommentToArticle(
    {TextEditingController textEditingController,
    BuildContext context,
    FocusNode focusNode,
    String commentMessage,
    String articleID,
    String userID}) {
  if (commentMessage.isNotEmpty) {
    RepositoryProvider.of<ArticleRepository>(context).addCommentToArticle(
        commentMessage: commentMessage,
        date: DateTime.now().toString(),
        articleID: articleID,
        userID: userID);
    textEditingController.clear();
    focusNode.unfocus();
  }
}
