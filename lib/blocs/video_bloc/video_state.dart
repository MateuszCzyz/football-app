part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class SuccessFetchedVideos extends VideoState {
  final List<Video> videos;
  SuccessFetchedVideos({this.videos});
}

class FailureFetchedVideos extends VideoState {}

class VideoLoading extends VideoState {}
