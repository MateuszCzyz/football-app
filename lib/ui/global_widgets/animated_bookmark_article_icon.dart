import 'package:flutter/material.dart';
import 'package:FootballApp/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/bookmark_article_bloc/bookmark_article_bloc.dart';

class AnimatedBookmarkArticleIcon extends StatefulWidget {
  final Color iconColor;
  final double iconSize;
  final Article article;
  final ValueKey key;

  AnimatedBookmarkArticleIcon(
      {this.iconColor, this.iconSize, this.article, this.key})
      : super(key: key);

  @override
  _AnimatedBookmarkArticleIconState createState() =>
      _AnimatedBookmarkArticleIconState();
}

class _AnimatedBookmarkArticleIconState
    extends State<AnimatedBookmarkArticleIcon> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkArticleBloc>(context)
        .add(FetchInitialArticleState(article: widget.article));
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
    _animation = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkArticleBloc, BookmarkArticleState>(
      buildWhen: _buildWhenFunction,
      builder: (context, state) {
        if (state is BookmarkArticleResult) {
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

  bool _buildWhenFunction(previous, current) {
    if ((current is BookmarkArticleResult &&
            current.articleID == widget.article.id) ||
        (current is LoadingBookmarkArticle &&
            current.articleID == widget.article.id)) {
      if (widget.key.value == widget.article.id) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void _onTapFunction(BookmarkArticleResult state) {
    _animationController.forward();
    if (state.isBookmarked) {
      BlocProvider.of<BookmarkArticleBloc>(context)
          .add(RemoveBookmarkedArticle(article: widget.article));
    } else {
      BlocProvider.of<BookmarkArticleBloc>(context)
          .add(AddBookmarkArticle(article: widget.article));
    }
  }
}

class LoadingWidget extends StatelessWidget {
  final Color iconColor;

  LoadingWidget({this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        color: iconColor,
        strokeWidth: 2.0,
      ),
    );
  }
}
