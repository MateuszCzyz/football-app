import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:FootballApp/blocs/video_bloc/video_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

class SingleLeagueWidget extends StatelessWidget {
  final StreamController<String> getcurrentSelectedLeagueStream;
  final String leagueLabel;
  final String imagePath;
  final bool isActive;

  SingleLeagueWidget({
    required this.leagueLabel,
    required this.imagePath,
    required this.isActive,
    required this.getcurrentSelectedLeagueStream,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
        child: Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
                color: isActive ? Colors.grey[350] : HexColor('EEEEEE'),
                borderRadius: BorderRadius.circular(5)),
            child: InkWell(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: SvgPicture.asset(imagePath, width: 27, height: 27),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        if (leagueLabel != 'CHAMPIONS LEAGUE')
                          BoxShadow(blurRadius: 1, color: Colors.black26)
                      ]),
                    ),
                    SizedBox(width: 15),
                    Text(
                      leagueLabel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isActive ? Colors.white : Colors.black87),
                    ),
                  ],
                ),
              ),
              onTap: () {
                getcurrentSelectedLeagueStream.sink.add(leagueLabel);
                BlocProvider.of<VideoBloc>(context)
                    .add(FetchVideos(leagueLabel: leagueLabel));
              },
            )));
  }
}
