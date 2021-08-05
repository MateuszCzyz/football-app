part of 'bookmark_article_bloc.dart';

abstract class BookmarkArticleEvent extends Equatable {
  const BookmarkArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialArticleState extends BookmarkArticleEvent {
  final Article article;
  FetchInitialArticleState({this.article});
}

class AddBookmarkArticle extends BookmarkArticleEvent {
  final Article article;

  AddBookmarkArticle({this.article});
}

class RemoveBookmarkedArticle extends BookmarkArticleEvent {
  final Article article;

  RemoveBookmarkedArticle({this.article});
}
