part of 'article_list_bloc.dart';

abstract class ArticleListEvent extends Equatable {
  const ArticleListEvent();

  @override
  List<Object> get props => [];
}

class FetchFirstPage extends ArticleListEvent {}

class FetchNextPage extends ArticleListEvent {}
