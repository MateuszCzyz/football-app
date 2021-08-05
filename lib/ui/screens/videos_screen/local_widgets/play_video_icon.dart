import 'package:FootballApp/ui/screens/play_video_screen/play_video_screen.dart';
import 'package:flutter/material.dart';

class PlayVideoIcon extends StatefulWidget {
  final String videoFrame;
  @override
  _PlayVideoIconState createState() => _PlayVideoIconState();
  PlayVideoIcon({this.videoFrame});
}

class _PlayVideoIconState extends State<PlayVideoIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  bool _absorbIcon = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100))
          ..addListener(() {
            if (_animationController.isCompleted) {
              _animationController.reverse();
              setState(() {
                _absorbIcon = false;
              });
            }
          });
    _animation =
        Tween<double>(begin: 1.0, end: 1.1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: AbsorbPointer(
          absorbing: _absorbIcon,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, _) {
                return Transform.scale(
                  scale: _animation.value,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.play_circle_outline_outlined,
                      size: 40,
                      color: Colors.white70,
                    ),
                  ),
                );
              }),
        ),
      ),
      onTap: () async {
        _animationController.forward();
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayVideoPage(
                    videoFrame: widget.videoFrame,
                  )));
        });
        setState(() {
          _absorbIcon = true;
        });
      },
    );
  }
}

/* 

*/
