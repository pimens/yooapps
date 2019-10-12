import 'package:flutter/material.dart';
import 'package:neonton/component/Carousel.dart';
import 'package:neonton/component/Carousel_Ecourse.dart';
import 'dart:core';

class Rekomendasi extends StatefulWidget {
  @override
  _RekomendasiState createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: new Column(
        children: <Widget>[
          Carousel_Ecourse(url: "http://sampeweweh.dx.am/neon/index.php?Apii/getEcourseByKategori/course"),
          // Carousel(url: "http://sampeweweh.dx.am/neon/index.php?Apii/getVideo/"),
          Divider(),
          Expanded(
            child: ListView(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Text(
                      "Series",
                      style: TextStyle(
                        color: Color(0xFF3B3A3A),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                new Row(
                  children: <Widget>[
                    new Text(
                      "Film",
                      style: TextStyle(
                        color: Color(0xFF3B3A3A),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Card(
                      child: new Column(
                        children: <Widget>[
                          new Image.asset("assets/cover-film.png"),
                          new Text(
                            "Laskar Pelangi",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF3B3A3A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
