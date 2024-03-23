part of 'bookmark_article_bloc.dart';

abstract class BookmarkArticleEvent extends Equatable {
  const BookmarkArticleEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialArticleState extends BookmarkArticleEvent {
  final Article article;
  FetchInitialArticleState({required this.article});
}

class AddBookmarkArticle extends BookmarkArticleEvent {
  final Article article;

  AddBookmarkArticle({required this.article});
}

class RemoveBookmarkedArticle extends BookmarkArticleEvent {
  final Article article;

  RemoveBookmarkedArticle({required this.article});
}
