import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:FootballApp/models/article.dart';
part 'article_list_event.dart';
part 'article_list_state.dart';

class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  final ArticleRepository articleRepository;
  int page = 1;
  ArticleListBloc({required this.articleRepository}) : super(ArticleInitial());

  @override
  Stream<ArticleListState> mapEventToState(
    ArticleListEvent event,
  ) async* {
    if (event is FetchFirstPage) {
      yield* fetchFirstPageToState(articleRepository: articleRepository);
    } else if (event is FetchNextPage) {
      yield* fetchNextPageToState(
          articleRepository: articleRepository, page: (++page));
    }
  }
}

Stream<ArticleListState> fetchFirstPageToState({
  required ArticleRepository articleRepository,
}) async* {
  try {
    List<Article> _articles = await articleRepository.fetchArticleData(page: 1);
    yield SuccessFetchedFirstPage(articles: List.from(_articles));
  } catch (e) {
    yield FailureFetchedFirstPage();
  }
}

Stream<ArticleListState> fetchNextPageToState({
  required ArticleRepository articleRepository,
  required int page,
}) async* {
  try {
    List<Article> _articles =
        await articleRepository.fetchArticleData(page: page);
    yield SuccessFetchedNextPage(articles: List.from(_articles));
  } catch (e) {
    yield FailureFetchedNextPage();
  }
}
