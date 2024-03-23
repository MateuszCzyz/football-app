import 'dart:async';

import 'package:FootballApp/blocs/video_bloc/video_bloc.dart';
import 'package:FootballApp/utils/get_leagues_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../local_widgets/single_league_widget.dart';

class LeaguesList extends StatefulWidget {
  @override
  State<LeaguesList> createState() => _LeaguesListState();
}

class _LeaguesListState extends State<LeaguesList> {
  late VideoBloc _videoBloc;
  late StreamController<String> _getcurrentSelectedLeagueStream;

  @override
  void initState() {
    super.initState();
    _videoBloc = BlocProvider.of<VideoBloc>(context);
    _getcurrentSelectedLeagueStream = StreamController()
      ..sink.add(_videoBloc.getLeaguesList[0]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: StreamBuilder(
            stream: _getcurrentSelectedLeagueStream.stream,
            builder: (context, stream) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _videoBloc.getLeaguesList.length,
                itemBuilder: (context, index) {
                  String _leagueLabel = _videoBloc.getLeaguesList[index];
                  return SingleLeagueWidget(
                    imagePath: getLeaguesImage(leagueLabel: _leagueLabel),
                    leagueLabel: _leagueLabel,
                    isActive: (stream.data == _leagueLabel),
                    getcurrentSelectedLeagueStream:
                        _getcurrentSelectedLeagueStream,
                  );
                },
              );
            },
          )),
    );
  }

  @override
  void dispose() {
    _getcurrentSelectedLeagueStream.close();
    super.dispose();
  }
}
