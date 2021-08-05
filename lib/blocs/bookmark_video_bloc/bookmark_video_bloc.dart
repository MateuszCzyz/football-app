import 'dart:async';

import 'package:FootballApp/resources/repositories/bookmark_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:FootballApp/models/video.dart';

part 'bookmark_video_event.dart';
part 'bookmark_video_state.dart';

class BookmarkVideoBloc extends Bloc<BookmarkVideoEvent, BookmarkVideoState> {
  BookmarkRepository _bookmarkRepository;
  BookmarkVideoBloc({BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository,
        super(LoadingBookmarkVideo());

  @override
  Stream<BookmarkVideoState> mapEventToState(
    BookmarkVideoEvent event,
  ) async* {
    if (event is AddBookmarkVideo) {
      yield* mapAddBookmarkVideoToState(video: event.video);
    } else if (event is RemoveBookmarkedVideo) {
      yield* mapRemoveBookmarkedVideoToState(video: event.video);
    } else if (event is FetchInitialVideoState) {
      yield* mapFetchInitialVideoStateToState(video: event.video);
    }
  }

  Stream<BookmarkVideoState> mapAddBookmarkVideoToState({Video video}) async* {
    yield LoadingBookmarkVideo(video: video);
    try {
      _bookmarkRepository.addBookmarkVideo(video: video);
      yield BookmarkVideoResult(video: video, isBookmarked: true);
    } catch (e) {
      yield BookmarkVideoResult(video: video, isBookmarked: false);
    }
  }

  Stream<BookmarkVideoState> mapRemoveBookmarkedVideoToState(
      {Video video}) async* {
    yield LoadingBookmarkVideo(video: video);
    try {
      _bookmarkRepository.removeBookmarkedVideo(video: video);
      yield BookmarkVideoResult(video: video, isBookmarked: false);
    } catch (e) {
      yield BookmarkVideoResult(video: video, isBookmarked: true);
    }
  }

  Stream<BookmarkVideoState> mapFetchInitialVideoStateToState(
      {Video video}) async* {
    yield LoadingBookmarkVideo(video: video);
    bool _isBookmarked = _bookmarkRepository.isVideoBookmarked(video: video);
    yield BookmarkVideoResult(video: video, isBookmarked: _isBookmarked);
  }

  get getVideosBox => _bookmarkRepository.getVideosBox;
}
