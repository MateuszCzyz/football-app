import 'package:flutter/material.dart';
import 'package:FootballApp/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/bookmark_video_bloc/bookmark_video_bloc.dart';

class BookmarkVideoIcon extends StatefulWidget {
  final Color iconColor;
  final double iconSize;
  final Video video;

  BookmarkVideoIcon({
    required this.iconColor,
    required this.iconSize,
    required this.video,
  });

  @override
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkVideoIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Icon(
          Icons.bookmark,
          color: widget.iconColor,
          size: widget.iconSize,
        ),
        onTap: () {
          BlocProvider.of<BookmarkVideoBloc>(context)
              .add(RemoveBookmarkedVideo(video: widget.video));
        });
  }
}
