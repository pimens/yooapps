import 'package:flutter/material.dart';
import 'package:neonton/component/Carousel_Ecourse.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:neonton/component/trending_item.dart';
import 'dart:async';
import 'dart:convert';

import 'package:neonton/pageVideo/Ecourse.dart';

class beranda extends StatefulWidget {
  @override
  _berandaState createState() => _berandaState();
}

class _berandaState extends State<beranda> {
  List data = [];
  List bimbel = [];

  Future<String> getData() async {
    String url = "http://infinacreativa.com/neonton/index.php?Apii/getEcourse";
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
    }
    return 'success!';
  }

  Future<String> getBimbel() async {
    String url =
        "http://infinacreativa.com/neonton/index.php?Apii/getEcourseByKategori/bimbel";
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        bimbel = content;
      });
    }
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    getData();
    getBimbel();
  }

  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(220, 221, 225, 100),
      body: new Container(
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //listview Scroll atas bawah
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: <Widget>[
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Container(
                  //     margin: EdgeInsets.only(top: 5, left: 10),
                  //     child: Text(
                  //       "Most Viewed",
                  //       style: TextStyle(
                  //           fontSize: 20, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  Carousel_Ecourse(
                      url:
                          "http://infinacreativa.com/neonton/index.php?Apii/getEcourseByKategori/course"),
                  // Carousel(url: "http://infinacreativa.com/neonton/index.php?Apii/getVideo/"),
                  Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "General",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          new Container(
                            height: 2.5,
                            width: 40,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: data == null ? 0 : data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map video = data[index];
                          return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, "/video");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Ecourse(
                                      id: video['id_video'].toString(),
                                      harga: video['harga'],
                                    ),
                                  ),
                                );
                              },
                              child: TrendingItem(
                                img: video["thumbnail"].toString(),
                                title: video["judul"],
                                kategori: video["kategori"],
                                harga: video["harga"],
                                view: video["view"],
                                id: video["id_video"],
                                ids: video["id_video"],

                              ));
                        },
                      )),
                  Divider(),
                  //Ecoures
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Bimbel",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          new Container(
                            height: 2.5,
                            width: 40,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 2.7,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: bimbel == null ? 0 : bimbel.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map video = bimbel[index];
                          return GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context, "/video");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Ecourse(
                                      id: video['id_video'].toString(),
                                      harga: video['harga'],
                                    ),
                                  ),
                                );
                              },
                              child: TrendingItem(
                               img: video["thumbnail"].toString(),
                                title: video["judul"],
                                kategori: video["kategori"],
                                harga: video["harga"],
                                view: video["view"],
                                id: video["id_video"],
                                ids: video["id_video"],
                              ));
                        },
                      )),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
