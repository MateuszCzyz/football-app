import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:FootballApp/blocs/bookmark_video_bloc/bookmark_video_bloc.dart';
import 'bookmarked_video.dart';
import 'package:FootballApp/models/video.dart';

class BookmarkVideosBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Box _videosBox =
        BlocProvider.of<BookmarkVideoBloc>(context).getVideosBox;
    return ValueListenableBuilder(
        valueListenable: _videosBox.listenable(),
        builder: (context, box, widget) {
          if (_videosBox.length > 0) {
            return Padding(
              padding: EdgeInsets.only(top: 0, bottom: 5),
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _videosBox.length,
                itemBuilder: (context, index) {
                  return BookmarkVideo(
                    video: Video.fromMap(_videosBox.getAt(index)),
                  );
                },
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text('There is no any bookmarked videos',
                  style: TextStyle(color: Colors.black54)),
            );
          }
        });
  }
}
