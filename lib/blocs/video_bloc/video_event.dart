part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class FetchVideos extends VideoEvent {
  final String leagueLabel;

  FetchVideos({required this.leagueLabel});
}
