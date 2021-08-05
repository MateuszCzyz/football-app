import 'package:FootballApp/models/article_detail.dart';
import 'package:FootballApp/resources/providers/image_provider.dart';
import 'package:hive/hive.dart';
import 'package:FootballApp/models/article.dart';
import 'package:FootballApp/models/video.dart';

class BookmarkRepository {
  ImageProvider _imageProvider = ImageProvider();
  Box _articlesBox = Hive.box('bookmarked_articles');
  Box _videosBox = Hive.box('bookmarked_videos');
  Box _articlesDetailsBox = Hive.box('articles_details');

  void addBookmarkArticle({Article article}) async {
    String _bookmarkedImagePath =
        await _imageProvider.saveBookmarkedImage(article.image);
    Map<dynamic, dynamic> _articleData = article.toMap();
    _articleData['image'] = _bookmarkedImagePath;
    _articlesBox.put(article.id, _articleData);
  }

  void addBookmarkedArticleDetail({ArticleDetail articleDetail}) {
    _articlesDetailsBox.put(articleDetail.id, articleDetail.toMap());
  }

  void addBookmarkVideo({Video video}) async {
    String _bookmarkedImagePath =
        await _imageProvider.saveBookmarkedImage(video.image);
    Map<dynamic, dynamic> _videoData = video.toMap();
    _videoData['image'] = _bookmarkedImagePath;
    _videosBox.put(video.title, _videoData);
  }

  void removeBookmarkedVideo({Video video}) {
    _videosBox.delete(video.title);
  }

  void removeBookmarkedArticle({Article article}) {
    _articlesBox.delete(article.id);
  }

  void removeBookmarkedArticleDetail({String articleID}) {
    _articlesDetailsBox.delete(articleID);
  }

  bool isArticleBookmarked({String articleID}) {
    return _articlesDetailsBox.containsKey(articleID);
  }

  bool isVideoBookmarked({Video video}) {
    return _videosBox.containsKey(video.title);
  }

  ArticleDetail getBookmarkedArticleDetail({String articleID}) {
    return ArticleDetail.fromMap(_articlesDetailsBox.get(articleID));
  }

  Box get getArticlesBox => _articlesBox;
  Box get getVideosBox => _videosBox;
}
