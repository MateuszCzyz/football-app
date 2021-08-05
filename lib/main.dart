import 'package:FootballApp/blocs/account_detail_bloc/account_detail_bloc.dart';
import 'package:FootballApp/blocs/article_list_bloc/article_list_bloc.dart';
import 'package:FootballApp/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:FootballApp/blocs/bookmark_article_bloc/bookmark_article_bloc.dart';
import 'package:FootballApp/blocs/bookmark_video_bloc/bookmark_video_bloc.dart';
import 'package:FootballApp/blocs/login_bloc/login_bloc.dart';
import 'package:FootballApp/blocs/register_bloc/register_bloc.dart';
import 'package:FootballApp/blocs/video_bloc/video_bloc.dart';
import 'package:FootballApp/resources/repositories/article_repository.dart';
import 'package:FootballApp/resources/repositories/auth_repository.dart';
import 'package:FootballApp/resources/repositories/bookmark_repository.dart';
import 'package:FootballApp/resources/repositories/users_repository.dart';
import 'package:FootballApp/resources/repositories/video_repository.dart';
import 'resources/repositories/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'utils/main_services.dart';
import 'ui/screens/home_screen/home_screen.dart';

void main() async {
  await mainServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(create: (context) => AuthenticationRepository()),
      RepositoryProvider(create: (context) => ArticleRepository()),
      RepositoryProvider(create: (context) => VideoRepository()),
      RepositoryProvider(create: (context) => UsersRepository()),
      RepositoryProvider(create: (context) => ImageRepository()),
      RepositoryProvider(create: (context) => BookmarkRepository())
    ], child: BlocProviders());
  }
}

class BlocProviders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationRepository _authenticationRepository =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final UsersRepository _usersRespository =
        RepositoryProvider.of<UsersRepository>(context);
    final ArticleRepository _articleRepository =
        RepositoryProvider.of<ArticleRepository>(context);
    final VideoRepository _videoRepository =
        RepositoryProvider.of<VideoRepository>(context);
    final BookmarkRepository _bookmarkRepository =
        RepositoryProvider.of<BookmarkRepository>(context);
    final ImageRepository _imageRepository =
        RepositoryProvider.of<ImageRepository>(context);

    return BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
            authenticationRepository: _authenticationRepository)
          ..add(CheckAuthenticationStatus()),
        child: MultiBlocProvider(providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                authenticationRepository: _authenticationRepository,
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                usersRepository: _usersRespository),
          ),
          BlocProvider<RegisterBloc>(
              create: (context) => RegisterBloc(
                  authenticationRepository: _authenticationRepository,
                  usersRepository: _usersRespository)),
          BlocProvider<ArticleListBloc>(
              create: (context) =>
                  ArticleListBloc(articleRepository: _articleRepository)
                    ..add(FetchFirstPage())),
          BlocProvider(
              create: (context) => VideoBloc(videoRepository: _videoRepository)
                ..add(FetchVideos(leagueLabel: 'ALL LEAGUES'))),
          BlocProvider(
              create: (context) => AccountDetailBloc(
                  authenticationRepository: _authenticationRepository,
                  usersRepository: _usersRespository,
                  articleRepository: _articleRepository,
                  imageRepository: _imageRepository,
                  context: context)),
          BlocProvider(
              create: (context) => BookmarkArticleBloc(
                  articleRepository: _articleRepository,
                  bookmarkRepository: _bookmarkRepository)),
          BlocProvider(
              create: (context) =>
                  BookmarkVideoBloc(bookmarkRepository: _bookmarkRepository)),
        ], child: AppView()));
  }
}

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appThemeData(),
      home: HomePage(),
    );
  }
}

ThemeData appThemeData() => ThemeData(
    primaryColor: HexColor('6798B4'),
    textTheme: GoogleFonts.nunitoTextTheme(TextTheme(
        bodyText1: GoogleFonts.nunito(
      textStyle: TextStyle(overflow: TextOverflow.ellipsis),
      color: HexColor('444444'),
    ))));
