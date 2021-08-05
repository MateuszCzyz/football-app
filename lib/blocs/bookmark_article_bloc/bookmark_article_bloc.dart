import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:FootballApp/models/article.dart';
import 'package:FootballApp/models/article_detail.dart';
import 'package:FootballApp/resources/repositories/bookmark_repository.dart';
import 'package:FootballApp/resources/repositories/article_repository.dart';

part 'bookmark_article_event.dart';
part 'bookmark_article_state.dart';

class BookmarkArticleBloc
    extends Bloc<BookmarkArticleEvent, BookmarkArticleState> {
  ArticleRepository _articleRepository;
  BookmarkRepository _bookmarkRepository;
  BookmarkArticleBloc(
      {ArticleRepository articleRepository,
      BookmarkRepository bookmarkRepository})
      : _articleRepository = articleRepository,
        _bookmarkRepository = bookmarkRepository,
        super(LoadingBookmarkArticle());

  @override
  Stream<BookmarkArticleState> mapEventToState(
    BookmarkArticleEvent event,
  ) async* {
    if (event is AddBookmarkArticle) {
      yield* mapAddBookmarkArticle(article: event.article);
    } else if (event is RemoveBookmarkedArticle) {
      yield* mapRemoveBookmarkedArticleToState(article: event.article);
    } else if (event is FetchInitialArticleState) {
      yield* mapFetchInitialArticleStateToState(article: event.article);
    }
  }

  Stream<BookmarkArticleState> mapFetchInitialArticleStateToState(
      {Article article}) async* {
    yield LoadingBookmarkArticle(articleID: article.id);
    final bool _isBookmarked =
        _bookmarkRepository.isArticleBookmarked(articleID: article.id);
    yield BookmarkArticleResult(
        articleID: article.id, isBookmarked: _isBookmarked);
  }

  Stream<BookmarkArticleState> mapAddBookmarkArticle({Article article}) async* {
    yield LoadingBookmarkArticle(articleID: article.id);
    try {
      ArticleDetail _articleDetail =
          await _articleRepository.fetchArticleDetail(slug: article.slug);
      _bookmarkRepository.addBookmarkedArticleDetail(
          articleDetail: _articleDetail);
      _bookmarkRepository.addBookmarkArticle(article: article);
      yield BookmarkArticleResult(articleID: article.id, isBookmarked: true);
    } catch (e) {
      yield BookmarkArticleResult(articleID: article.id, isBookmarked: false);
    }
  }

  Stream<BookmarkArticleState> mapRemoveBookmarkedArticleToState(
      {Article article}) async* {
    yield LoadingBookmarkArticle(articleID: article.id);
    try {
      _bookmarkRepository.removeBookmarkedArticle(article: article);
      yield BookmarkArticleResult(articleID: article.id, isBookmarked: false);
    } catch (e) {
      yield BookmarkArticleResult(articleID: article.id, isBookmarked: true);
    }
  }

  ArticleDetail getBookmarkedArticleDetail({String articleID}) {
    return _bookmarkRepository.getBookmarkedArticleDetail(articleID: articleID);
  }

  get getArticlesBox => _bookmarkRepository.getArticlesBox;
}
