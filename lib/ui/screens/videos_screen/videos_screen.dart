import 'package:FootballApp/blocs/video_bloc/video_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/ui/screens/videos_screen/local_widgets/leagues_list.dart';
import 'package:FootballApp/ui/screens/videos_screen/local_widgets/single_video.dart';
import 'package:FootballApp/ui/global_widgets/custom_error_widget.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>
    with AutomaticKeepAliveClientMixin<VideosPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [LeaguesList(), VideosBuilder()],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VideosBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is SuccessFetchedVideos) {
          if (state.videos.length > 0) {
            return Container(
              margin: EdgeInsets.only(top: 75),
              child: ListView.builder(
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  return SingleVideo(
                    video: state.videos[index],
                  );
                },
              ),
            );
          } else {
            return CustomErrorWidget(
              title: 'There is no any videoss',
              description:
                  'Current selected country does not include any videos, try check some other country section',
            );
          }
        } else if (state is FailureFetchedVideos) {
          return CustomErrorWidget(
            title: 'Something went wrong',
            description:
                'There is no any videos, check your network conectivity or try it later',
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
