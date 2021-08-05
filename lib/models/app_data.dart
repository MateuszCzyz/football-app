abstract class AppData {
  static const String apiKey = '';
  static const String apiHost = 'livescore-football.p.rapidapi.com';
  static const String articleListEndpoint =
      'https://livescore-football.p.rapidapi.com/soccer/news-list';
  static const String articleDetailEndpoint =
      'https://livescore-football.p.rapidapi.com/soccer/news-detail';
  static const String videoListEndpoint =
      'https://www.scorebat.com/video-api/v1/';
  static const String aboutApplicationContent =
      'FootballApp is a simple app to reading sports articles, watching videos, and bookmarking these elements. There is also a whole authentication service (login, registration, modifying account data), commenting article, and sharing article services. It has been written using the bloc pattern to state management, firebase (cloud firebasetore, firesbase storage, firebase authentcation) and local database hive. Below there are the apis links.';
  static const String firstApiLink = 'https://www.scorebat.com/video-api/';
  static const String secondApiLink =
      'https://rapidapi.com/datascraper/api/livescore-football/';

  static const String loginFormTitle = 'Sign in panel';
  static const String loginFormDescription =
      'If you want get acces to commenting sport posts and exchange your insights and opinion about concerete situations you have to sign in to our app';
  static const String registerFormTitle = 'Sign up panel';
  static const String registerFormDescription =
      'If you want get acces to commenting sport posts and exchange your insights and opinion about concerete situations you have to sign in to our app';
}
