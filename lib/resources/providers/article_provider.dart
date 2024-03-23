import 'package:dio/dio.dart';
import 'package:FootballApp/models/app_data.dart';

class ArticleApiProvider {
  Future<Response<Map>> fetchArticleList({required int page}) async {
    return await Dio(BaseOptions(headers: {
      'x-rapidapi-key': AppData.apiKey,
      'x-rapidapi-host': AppData.apiHost
    })).get(AppData.articleListEndpoint + '?page=$page');
  }

  Future<Response<Map>> fetchArticleDetail({required String slug}) async {
    return await Dio(BaseOptions(headers: {
      'x-rapidapi-key': AppData.apiKey,
      'x-rapidapi-host': AppData.apiHost
    })).get(AppData.articleDetailEndpoint + '?slug=$slug');
  }
}
