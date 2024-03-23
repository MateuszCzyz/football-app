import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import '../../../global_widgets/account_image_widget.dart';
import './add_comment_field_widget.dart';

class AddCommentMenu extends StatelessWidget {
  final String articleID;
  AddCommentMenu({required this.articleID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is SuccesAuthentication) {
        return Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
          child: Row(children: [
            AccountImage(
              size: 40,
              displayName: state.user!.displayName!,
              userHasImage: state.user!.photoURL != null ? true : false,
              imagePath: state.user!.photoURL!,
              heroTag: 'account_add_message_image',
              fontSize: 16,
            ),
            AddCommentField(
              articleID: articleID,
              currentUser: state.user!,
            ),
          ]),
        );
      } else if (state is FailureAuthentication) {
        return Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Center(
                  child: Text('you have to be signed to commenting posts'),
                ))
          ],
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
