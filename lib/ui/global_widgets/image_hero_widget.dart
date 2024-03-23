import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageHero extends StatelessWidget {
  final String imagePath;
  final String heroTag;

  ImageHero({
    required this.heroTag,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Hero(
          tag: heroTag,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imagePath))),
          ),
        ),
      ),
    );
  }
}
