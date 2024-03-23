import 'package:FootballApp/models/article_detail.dart';
import 'package:dio/dio.dart';
import 'package:FootballApp/models/article.dart';
import 'package:uuid/uuid.dart';
import '../providers/article_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleRepository {
  final ArticleApiProvider _articleProvider = ArticleApiProvider();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  Future<List<Article>> fetchArticleData({required int page}) async {
    List<Article> _articles = [];
    Response<Map> articleList =
        await _articleProvider.fetchArticleList(page: page);
    for (Map data in articleList.data!['data']) {
      _articles.add(Article(
          id: data['id'],
          title: data['title'],
          date: data['published'],
          image: data['image'],
          slug: data['slug'],
          url: data['url']));
    }
    return _articles;
  }

  Future<ArticleDetail> fetchArticleDetail({required String slug}) async {
    Response<Map> articleDetail =
        await _articleProvider.fetchArticleDetail(slug: slug);
    final data = articleDetail.data!['data'];
    return ArticleDetail(
      id: data['id'],
      author: data['author'],
      content: data['article'],
    );
  }

  Stream<QuerySnapshot> getCommentsSnapshot({required String articleID}) {
    return _firestore
        .collection('comments')
        .orderBy('date')
        .where('id_article', isEqualTo: articleID)
        .snapshots();
  }

  Future<void> addCommentToArticle({
    required String commentMessage,
    required String date,
    required String articleID,
    required String userID,
    String? imagePath,
    bool? userHasImage,
    String? userName,
  }) async {
    await _firestore.collection('comments').add({
      'content': commentMessage,
      'date': date,
      'id_article': articleID,
      'id_user': userID,
      'id_comment': _uuid.v4()
    });
  }

  Future<void> removeCommentFromArticle({required String commentID}) async {
    QuerySnapshot _querySnapshot = await _firestore
        .collection('comments')
        .where('id_comment', isEqualTo: commentID)
        .get();
    String _commentDoc = _querySnapshot.docs[0].id;
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(_commentDoc)
        .delete();
  }

  Future<void> removeAllUserComments({required String userID}) async {
    await _firestore
        .collection('comments')
        .where('id_user', isEqualTo: userID)
        .get()
        .then((snapshot) async {
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        await _firestore.collection('comments').doc(doc.id).delete();
      }
    });
  }
}
