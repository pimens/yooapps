import 'package:flutter/material.dart';
import 'package:neonton/component/Carousel.dart';
import 'dart:core';

class Entertaiment extends StatefulWidget {
  @override
  _EntertaimentState createState() => _EntertaimentState();
}

class _EntertaimentState extends State<Entertaiment> {
  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: new Column(
        children: <Widget>[
          Carousel(url: "http://sampeweweh.dx.am/neon/index.php?Apii/getVideo"),
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
          ),
        ],
      )),
    );
  }
}
