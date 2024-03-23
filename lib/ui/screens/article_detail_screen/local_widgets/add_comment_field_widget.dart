import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:FootballApp/ui/screens/article_detail_screen/local_widgets/send_message_icon.dart';

class AddCommentField extends StatefulWidget {
  final String articleID;
  final User currentUser;

  AddCommentField({
    required this.articleID,
    required this.currentUser,
  });

  @override
  State<AddCommentField> createState() => _AddCommentFieldState();
}

class _AddCommentFieldState extends State<AddCommentField> {
  late TextEditingController _commentMessage;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _commentMessage = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.25,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 15,
              child: TextField(
                focusNode: _focusNode,
                controller: _commentMessage,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey[300]!, width: 1.0),
                  ),
                  hintText: 'Your comment',
                  filled: true,
                  fillColor: HexColor('FBFBFB'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: SendMessageIcon(
                    commentMessage: _commentMessage,
                    articleID: widget.articleID,
                    focusNode: _focusNode,
                    currentUser: widget.currentUser))
          ],
        ));
  }

  @override
  void dispose() {
    _commentMessage.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
