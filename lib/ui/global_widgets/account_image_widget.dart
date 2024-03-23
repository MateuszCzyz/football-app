import '../global_widgets/image_hero_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AccountImage extends StatelessWidget {
  final String displayName;
  final String imagePath;
  final String heroTag;
  final double size;
  final double fontSize;
  final bool userHasImage;

  AccountImage({
    required this.displayName,
    required this.imagePath,
    required this.userHasImage,
    required this.fontSize,
    required this.heroTag,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return userHasImage
        ? CachedImageWidget(
            heroTag: heroTag,
            imagePath: imagePath,
            size: size,
          )
        : EmptyImageWidget(
            displayName: displayName,
            fontSize: fontSize,
            size: size,
          );
  }
}

class CachedImageWidget extends StatelessWidget {
  final String heroTag;
  final String imagePath;
  final double size;

  CachedImageWidget({
    required this.heroTag,
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Hero(
          tag: heroTag,
          child: Padding(
            padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imagePath,
              imageBuilder: (context, imageProvider) {
                return Container(
                  alignment: Alignment.center,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover, image: imageProvider)),
                );
              },
              placeholder: (context, imagePath) {
                return Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                      child: LinearProgressIndicator(
                    backgroundColor: Colors.grey[300],
                    color: HexColor('888888'),
                  )),
                );
              },
            ),
          )),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageHero(
                  heroTag: heroTag,
                  imagePath: imagePath,
                )));
      },
    );
  }
}

class EmptyImageWidget extends StatelessWidget {
  final String displayName;
  final double fontSize;
  final double size;

  EmptyImageWidget({
    required this.displayName,
    required this.fontSize,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
        child: Container(
          alignment: Alignment.center,
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor('6798B4'),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.5, blurRadius: 0.5, color: Colors.black12)
              ]),
          child: Text(
            displayName.substring(0, 1).toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
