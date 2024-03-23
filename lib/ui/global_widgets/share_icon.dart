import 'package:flutter/material.dart';
// import 'package:share/share.dart';

class ShareIcon extends StatefulWidget {
  final String shareTitle;
  final String shareURL;
  final Color iconColor;

  ShareIcon(
      {required this.shareURL,
      required this.shareTitle,
      required this.iconColor});
  @override
  _ShareIconState createState() => _ShareIconState();
}

class _ShareIconState extends State<ShareIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
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
        Tween<double>(begin: 1.0, end: 1.2).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: _absorbIcon,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Transform.scale(
              scale: _animation.value,
              child: InkWell(
                  child: Icon(
                    Icons.share,
                    color: widget.iconColor,
                    size: 20,
                  ),
                  onTap: _iconFunction),
            );
          }),
    );
  }

  Future<void> _iconFunction() async {
    // _animationController.forward();
    // await Share.share(widget.shareURL, subject: widget.shareTitle);
    // setState(() {
    //   _absorbIcon = true;
    // });
  }
}
