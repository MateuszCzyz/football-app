part of 'bookmark_video_bloc.dart';

abstract class BookmarkVideoState extends Equatable {
  const BookmarkVideoState();

  @override
  List<Object> get props => [];
}

class LoadingBookmarkVideo extends BookmarkVideoState {
  final Video? video;

  LoadingBookmarkVideo({this.video});

  @override
  List<Object> get props => video != null ? [video!] : [];
}

class BookmarkVideoResult extends BookmarkVideoState {
  final Video video;
  final bool isBookmarked;

  BookmarkVideoResult({required this.video, required this.isBookmarked});

  @override
  List<Object> get props => [video, isBookmarked];
}
