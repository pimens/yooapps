import 'package:flutter/material.dart';
import 'package:neonton/component/Draw.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:neonton/pageVideo/Video.dart';

class SearchPage extends StatefulWidget {
  String keyword;
  SearchPage({this.keyword});
  @override
  _SearchPageState createState() => _SearchPageState(keyword: this.keyword);
}

class _SearchPageState extends State<SearchPage> {
  String keyword;
  _SearchPageState({this.keyword});

  List data = [];
  Future<String> getData() async {
    final String url =
        'http://sampeweweh.dx.am/neon/index.php?Apii/getVideoByTitle/' +
            keyword;
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        // data = content['hasil'];
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
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        title: new Center(
          child: new Text("NEONTON"),
        ),
      ),
      drawer: Draw(),
      body: new Column(
        children: <Widget>[
          new Text(
            "Hasil Pencarian",
            style: TextStyle(
              fontSize: 30,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black,
            ),
          ),
          Divider(),
          Expanded(
            child: new Container(
                child: new Center(
              child: ListView(
                  children: data == null
                      ? null
                      : data.map((d) {
                          return new Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[                                  
                                  GestureDetector(
                                      onTap: () {
                                        // Navigator.pushNamed(context, "/video");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Video(
                                              id: d['id_video'].toString(),
                                              harga: d['harga'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Image.network(
                                          // http://192.168.0.108/webNeon/assets/global/video_thumb/'+
                                          d['thumbnail'].toString(),
                                        ),
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(left: 20.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.add_box,
                                            color: Colors.black,
                                          ),
                                          new Text(" " + d['judul'].toString()),
                                        ],
                                      )),
                                  Divider(),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.black,
                                              ),
                                              new Text(
                                                  " " + d['view'].toString()),
                                            ],
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.money_off,
                                                color: Colors.black,
                                              ),
                                              new Text(d['harga'].toString()),
                                            ],
                                          )),                                      
                                    ],
                                  ),
                                  Divider(),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        }).toList()),
            )),
          ),
        ],
      ),
    );
  }
}
