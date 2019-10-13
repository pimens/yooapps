import 'package:flutter/material.dart';
import 'package:neonton/component/Carousel.dart';
import 'package:neonton/component/Carousel_Ecourse.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:neonton/component/trending_item.dart';
import 'dart:async';
import 'dart:convert';

import 'package:neonton/pageVideo/Ecourse.dart';
class Rekomendasi extends StatefulWidget {
  @override
  _RekomendasiState createState() => _RekomendasiState();
}

class _RekomendasiState extends State<Rekomendasi> {
  List data = [];
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  static const Cubic fastOutSlowIn = Cubic(0.4, 0.0, 0.2, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
          child: new Column(
        children: <Widget>[
          Carousel_Ecourse(url: "http://infinacreativa.com/neonton/index.php?Apii/getEcourseByKategori/course"),
          // Carousel(url: "http://infinacreativa.com/neonton/index.php?Apii/getVideo/"),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                            address: video["kategori"],
                            rating: video["harga"],
                            view: video["view"],
                          ));
                    },
                  ),
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
