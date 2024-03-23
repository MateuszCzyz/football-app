import 'package:flutter/material.dart';
import 'package:FootballApp/models/article.dart';
import 'package:FootballApp/ui/global_widgets/header_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:FootballApp/ui/screens/articles_screen/local_widgets/large_slider_article.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

class SliderWidget extends StatefulWidget {
  final List<Article> articles;

  SliderWidget({required this.articles});
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<SliderWidget> {
  late StreamController _streamController;
  List<Widget> currentSliderPositions =
      List.generate(5, (index) => Container(width: 10, height: 10));

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(horizontalPadding: 5, label: 'Most popular articles'),
        CarouselSlider(
            key: UniqueKey(),
            items: widget.articles.map((article) {
              return LargeArticle(
                key: UniqueKey(),
                article: article,
              );
            }).toList(),
            options: CarouselOptions(
                onPageChanged:
                    (int index, CarouselPageChangedReason changeReason) {
                  _streamController.sink.add(index);
                },
                viewportFraction: 1.0,
                enlargeCenterPage: true)),
        SizedBox(
          height: 5,
        ),
        StreamBuilder(
            initialData: 0,
            stream: _streamController.stream,
            builder: (context, stream) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(5, (index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: stream.data == index
                              ? HexColor('6798B4')
                              : HexColor('C4C4C4'),
                          shape: BoxShape.circle),
                      margin: EdgeInsets.only(
                          top: 10, left: 2.5, right: 2.5, bottom: 5),
                      width: 8,
                      height: 8,
                    );
                  }));
            }),
        Header(horizontalPadding: 5, label: 'The newest articles')
      ],
    );
  }
}
