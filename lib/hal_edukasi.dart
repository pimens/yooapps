import 'package:flutter/material.dart';
import 'package:neonton_apps/component/Carousel_Ecourse.dart';
import 'package:neonton_apps/component/trending_item.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:neonton_apps/pageVideo/Ecourse.dart';

class Edukasi extends StatefulWidget {
  @override
  _EdukasiState createState() => _EdukasiState();
}

class _EdukasiState extends State<Edukasi> {
  List data = [];
  List bimbel = [];

  Future<String> getData() async {
    String url = "http://192.168.43.184/webNeon/index.php?Apii/getEcourse";
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
        "http://192.168.43.184/webNeon/index.php?Apii/getEcourseByKategori/bimbel";
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
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              //listview Scroll atas bawah
              child: ListView(
                // scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        "Most Viewed",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Carousel_Ecourse(
                      url:
                          "http://192.168.43.184/webNeon/index.php?Apii/getEcourseByKategori/course"),
                  // Carousel(url: "http://192.168.43.184/webNeon/index.php?Apii/getVideo/"),
                  Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        "Bimbels",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 3.0,
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
                              ));
                        },
                      )),
                  Divider(),
                  //Ecoures
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 5, left: 10),
                      child: Text(
                        "E-Course",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 3.0,
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
