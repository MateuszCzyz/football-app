part of 'article_list_bloc.dart';

abstract class ArticleListState extends Equatable {
  const ArticleListState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleListState {}

class SuccessFetchedFirstPage extends ArticleListState {
  final List<Article> articles;

  SuccessFetchedFirstPage({this.articles});
  @override
  List<Object> get props => [articles];
}

class FailureFetchedFirstPage extends ArticleListState {}

class SuccessFetchedNextPage extends ArticleListState {
  final List<Article> articles;

  SuccessFetchedNextPage({this.articles});
  @override
  List<Object> get props => [articles];
}

class FailureFetchedNextPage extends ArticleListState {}
