import 'package:FootballApp/utils/fetch_url_from_string.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:FootballApp/ui/screens/videos_screen/local_widgets/play_video_icon.dart';
import 'package:FootballApp/ui/global_widgets/time_widget.dart';
import 'package:FootballApp/ui/global_widgets/share_icon.dart';
import 'package:FootballApp/ui/global_widgets/animated_bookmark_video_icon.dart';
import 'package:FootballApp/models/video.dart';
import 'package:FootballApp/utils/calculate_time.dart';

class SingleVideo extends StatelessWidget {
  final Video video;

  SingleVideo({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: HexColor('D9D6D6'), blurRadius: 5, spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoImage(
              video: video,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                children: [
                  TimeAndIconsVideo(
                    video: video,
                  ),
                  MatchInformation(video: video)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoImage extends StatelessWidget {
  final Video video;

  VideoImage({required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.grey,
            boxShadow: [
              BoxShadow(
                  color: HexColor('D9D6D6'), blurRadius: 10, spreadRadius: 0)
            ],
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: CachedNetworkImageProvider(
                  video.image!,
                ))),
        child: Center(
            child: PlayVideoIcon(
          videoFrame: video.url!,
        )));
  }
}

class TimeAndIconsVideo extends StatelessWidget {
  final Video video;

  TimeAndIconsVideo({required this.video});

  @override
  Widget build(BuildContext context) {
    Map<String, String> videoTime = calculateTime(date: video.date);
    return Padding(
      padding: EdgeInsets.only(bottom: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeWidget(
            timeSincePublished: videoTime['timeSincePublished']!,
            color: '888888',
          ),
          Row(
            children: [
              ShareIcon(
                shareURL: getUrlFromString(content: video.url),
                shareTitle: video.title!,
                iconColor: Colors.grey.shade600,
              ),
              SizedBox(width: 5),
              AnimatedBookmarkVideoIcon(
                  iconSize: 27, iconColor: Colors.grey.shade600, video: video)
            ],
          )
        ],
      ),
    );
  }
}

class MatchInformation extends StatelessWidget {
  final Video video;

  MatchInformation({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(video.title!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
              Text(
                video.competition!,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black45, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
