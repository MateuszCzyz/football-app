import 'package:dio/dio.dart';
import 'package:FootballApp/models/app_data.dart';

class VideoApiProvider {
  Future<Response<List<dynamic>>> fetchVideos() async {
    return await Dio().get(AppData.videoListEndpoint);
  }
}
