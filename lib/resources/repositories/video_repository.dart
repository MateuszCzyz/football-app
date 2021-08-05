import '../providers/video_provider.dart';
import '../../models/video.dart';
import 'package:dio/dio.dart';

class VideoRepository {
  VideoApiProvider _videoApiProvider = VideoApiProvider();

  final List<String> leagues = [
    'ALL LEAGUES',
    'SPAIN',
    'ENGLAND',
    'ITALY',
    'GERMANY',
    'POLAND',
    'FRANCE',
    'NETHERLANDS',
    'PORTUGAL',
    'CHAMPIONS LEAGUE'
  ];

  Future<List<Video>> fetchVideos({String selectedLeague}) async {
    List<Video> videosList = [];
    Response<List<dynamic>> videos = await _videoApiProvider.fetchVideos();
    videos.data.forEach((video) async {
      bool isCorrectLeague = (selectedLeague == 'ALL LEAGUES')
          ? (leagues.contains(video['competition']['name'].split(':')[0]))
          : (video['competition']['name'].split(':')[0] == selectedLeague);

      if (isCorrectLeague) {
        videosList.add(Video(
            title: video['title'],
            date: video['date'],
            competition: video['competition']['name'],
            image: video['thumbnail'],
            url: video['videos'][0]['embed']));
      }
    });
    return videosList;
  }
}
