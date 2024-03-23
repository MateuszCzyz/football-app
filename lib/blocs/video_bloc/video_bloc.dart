import 'dart:async';

import 'package:FootballApp/resources/repositories/video_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:FootballApp/models/video.dart';
import 'package:equatable/equatable.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository _videoRepository;
  final StreamController<String> _currentSelectedLeagueStream;
  String _currentSelectedLeague;
  VideoBloc({required VideoRepository videoRepository})
      : _videoRepository = videoRepository,
        _currentSelectedLeagueStream = StreamController()
          ..add(videoRepository.leagues[0]),
        _currentSelectedLeague = '',
        super(VideoInitial());

  @override
  Stream<VideoState> mapEventToState(
    VideoEvent event,
  ) async* {
    if (event is FetchVideos && event.leagueLabel != _currentSelectedLeague) {
      try {
        yield VideoLoading();
        _currentSelectedLeagueStream.sink.add(event.leagueLabel);
        _currentSelectedLeague = event.leagueLabel;
        List<Video> videos = await _videoRepository.fetchVideos(
            selectedLeague: event.leagueLabel);
        yield SuccessFetchedVideos(videos: videos);
      } catch (e) {
        yield FailureFetchedVideos();
      }
    }
  }

  List<String> get getLeaguesList => _videoRepository.leagues;
  StreamController<String> get getcurrentSelectedLeagueStream =>
      _currentSelectedLeagueStream;
}
