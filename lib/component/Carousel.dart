import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:neonton/Video.dart';

class Carousel extends StatefulWidget {
  final String url;
  Carousel({this.url});
  @override
  _CarouselState createState() => _CarouselState(url: url);
}

class _CarouselState extends State<Carousel> {
  String url;
  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  _CarouselState({this.url});
  static double h = 80;
  List data = [];
  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(this.url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
    }
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 20),
            child: CarouselSlider(
                height: h,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: fastOutSlowIn,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                enlargeCenterPage: true,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
                items: data.length == 0
                    ? [1].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            h = 200;
                            return new CircularProgressIndicator();
                          },
                        );
                      }).toList()
                    : data.map((d) {
                        return Builder(
                          builder: (BuildContext context) {
                            h = 200;
                            return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context, "/video");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Video(id: d['id_video'].toString(),harga: d['harga'],),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: Image.network(
                                    // http://192.168.0.108/webNeon/assets/global/video_thumb/'+
                                    d['thumbnail'].toString(),
                                  ),
                                ));
                          },
                        );
                      }).toList())),
      ],
    );
  }
}
