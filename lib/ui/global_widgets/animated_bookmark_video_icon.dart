import 'package:flutter/material.dart';
import 'package:FootballApp/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/bookmark_video_bloc/bookmark_video_bloc.dart';

class AnimatedBookmarkVideoIcon extends StatefulWidget {
  final Color iconColor;
  final double iconSize;
  final Video video;

  AnimatedBookmarkVideoIcon({this.iconColor, this.iconSize, this.video});

  @override
  _AnimatedBookmarkIconState createState() => _AnimatedBookmarkIconState();
}

class _AnimatedBookmarkIconState extends State<AnimatedBookmarkVideoIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkVideoBloc>(context)
        .add(FetchInitialVideoState(video: widget.video));
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            }
          });
    _animation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkVideoBloc, BookmarkVideoState>(
      buildWhen: _buildWhenFunction,
      builder: (context, state) {
        if (state is BookmarkVideoResult) {
          return AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Transform.scale(
                  scale: _animation.value,
                  child: InkWell(
                      child: Icon(
                        (state.isBookmarked)
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: widget.iconColor,
                        size: widget.iconSize,
                      ),
                      onTap: () {
                        _onTapFunction(state);
                      }),
                );
              });
        } else {
          return LoadingWidget(
            iconColor: widget.iconColor,
          );
        }
      },
    );
  }

  void _onTapFunction(BookmarkVideoResult state) {
    _animationController.forward();
    if (state.isBookmarked) {
      BlocProvider.of<BookmarkVideoBloc>(context)
          .add(RemoveBookmarkedVideo(video: widget.video));
    } else {
      BlocProvider.of<BookmarkVideoBloc>(context)
          .add(AddBookmarkVideo(video: widget.video));
    }
  }

  bool _buildWhenFunction(previous, current) {
    if ((current is BookmarkVideoResult &&
            current.video.title == widget.video.title) ||
        (current is LoadingBookmarkVideo &&
            current.video.title == widget.video.title)) {
      return true;
    } else {
      return false;
    }
  }
}

class LoadingWidget extends StatelessWidget {
  final Color iconColor;

  LoadingWidget({this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        color: iconColor,
        strokeWidth: 2.0,
      ),
    );
  }
}
