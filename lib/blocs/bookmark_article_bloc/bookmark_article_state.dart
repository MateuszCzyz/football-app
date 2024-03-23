part of 'bookmark_article_bloc.dart';

abstract class BookmarkArticleState extends Equatable {
  const BookmarkArticleState();

  @override
  List<Object> get props => [];
}

class LoadingBookmarkArticle extends BookmarkArticleState {
  final String? articleID;

  LoadingBookmarkArticle({this.articleID});

  @override
  List<Object> get props => articleID != null ? [articleID!] : [];
}

class BookmarkArticleResult extends BookmarkArticleState {
  final String articleID;
  final bool isBookmarked;

  BookmarkArticleResult({required this.articleID, required this.isBookmarked});

  @override
  List<Object> get props => [articleID, isBookmarked];
}
