import 'dart:async';

import 'package:FootballApp/resources/repositories/users_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../resources/repositories/article_repository.dart';
import 'package:FootballApp/models/firestore_user.dart';
import '../../models/article_detail.dart';

part 'article_detail_event.dart';
part 'article_detail_state.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleRepository articleRepository;
  final UsersRepository usersRepository;
  ArticleDetailBloc({this.articleRepository, this.usersRepository})
      : super(ArticleDetailInitial());

  @override
  Stream<ArticleDetailState> mapEventToState(
    ArticleDetailEvent event,
  ) async* {
    if (event is FetchDetail) {
      yield LoadingDetail();
      yield* fetchDetailToState(
          articleRepository: articleRepository,
          slug: event.slug,
          articleID: event.articleID);
    }
  }

  get getUsersList => usersRepository.getUsersList();
  getUserData({List<FirestoreUser> users, String userID}) =>
      usersRepository.getUserData(users: users, userID: userID);
}

Stream<ArticleDetailState> fetchDetailToState(
    {ArticleRepository articleRepository,
    String slug,
    String articleID}) async* {
  try {
    ArticleDetail articleDetail =
        await articleRepository.fetchArticleDetail(slug: slug);
    Stream<QuerySnapshot> commentsSnapshot =
        articleRepository.getCommentsSnapshot(articleID: articleID);
    yield SuccessFetchedDetail(
        articleDetail: articleDetail, commentsSnapshot: commentsSnapshot);
  } catch (e) {
    yield FailureFetchedDetail();
  }
}
