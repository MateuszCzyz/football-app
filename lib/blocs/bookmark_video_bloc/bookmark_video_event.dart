part of 'bookmark_video_bloc.dart';

abstract class BookmarkVideoEvent extends Equatable {
  const BookmarkVideoEvent();

  @override
  List<Object> get props => [];
}

class FetchInitialVideoState extends BookmarkVideoEvent {
  final Video video;
  FetchInitialVideoState({this.video});
}

class AddBookmarkVideo extends BookmarkVideoEvent {
  final Video video;

  AddBookmarkVideo({this.video});
}

class RemoveBookmarkedVideo extends BookmarkVideoEvent {
  final Video video;

  RemoveBookmarkedVideo({this.video});
}
