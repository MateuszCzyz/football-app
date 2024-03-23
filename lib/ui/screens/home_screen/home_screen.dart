import 'package:FootballApp/ui/global_widgets/custom_app_bar.dart';
import 'package:FootballApp/ui/screens/articles_screen/article_screen.dart';
import 'package:FootballApp/ui/screens/videos_screen/videos_screen.dart';
import 'package:FootballApp/ui/screens/bookmark_screen/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'local_widgets/drawer.dart';

final List<Widget> pages = [
  ArticleScreen(),
  VideosPage(),
  BookmarkScreen(),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: HexColor('FBFBFB'),
            drawer: MyDrawer(),
            appBar: CustomAppBar(),
            body: TabBarView(
              children: pages,
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey[100]!))),
              child: TabBar(
                indicatorColor: HexColor('6798B4'),
                labelColor: HexColor('6798B4'),
                unselectedLabelColor: HexColor('888686'),
                overlayColor: MaterialStateProperty.all(HexColor('6798B4')),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.article,
                    ),
                  ),
                  Tab(
                      icon: Icon(
                    Icons.play_circle_fill_rounded,
                  )),
                  Tab(
                    icon: Icon(Icons.bookmark),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
