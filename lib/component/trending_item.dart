import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class TrendingItem extends StatefulWidget {
  String ids = "";
  final String img;
  final String title;
  final String kategori;
  final String harga;
  final String view;
  final String id;

  TrendingItem(
      {Key key,
      @required this.img,
      @required this.title,
      @required this.kategori,
      @required this.harga,
      @required this.view,
      @required this.id,
      this.ids})
      : super(key: key);

  @override
  _TrendingItemState createState() => _TrendingItemState(ids: ids);
}

class _TrendingItemState extends State<TrendingItem> {
  String ids, x;

  _TrendingItemState({this.ids}) {
    getRating();
  }
  List rtg = [];
  Future<String> getRating() async {
    String ur =
        "http://infinacreativa.com/neonton/index.php?Apii/getRatingEcourse/" +
            ids;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        rtg = content;
      });
    }
    return "ok";
  }

  Widget judul(BuildContext context) {
    return ExpandablePanel(
      // header: Text("xxx"),
      collapsed: Text(
        " ${widget.title} ",
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      expanded: Text(
        " ${widget.title} ",
        softWrap: true,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        margin: EdgeInsets.all(3),
        // height: MediaQuery.of(context).size.height / 1.0,
        color: Color(0xFF3B3A3A),
        width: MediaQuery.of(context).size.width / 3.0,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: Color(0xFF3B3A3A),
                    height: MediaQuery.of(context).size.height / 5.0,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      "${widget.img}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 25.0,
                    right: 3.0,
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(32.0)),
                      ),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.monetization_on,
                                color: Colors.white,
                                size: 10,
                              ),
                              Text(
                                " ${widget.harga} ",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1.0,
                    right: 3.0,
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.red,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(32.0)),
                      ),
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                                size: 10,
                              ),
                              Text(
                                " ${widget.view} ",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 6.0,
                  //   left: 6.0,
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(3.0)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(4.0),
                  //       child: Row(
                  //         children: <Widget>[
                  //           Text(
                  //             " ${widget.kategori} ",
                  //             style: TextStyle(
                  //               fontSize: 10,
                  //               color: Colors.green,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // SizedBox(height: 7.0),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  new Container(
                                      padding: EdgeInsets.only(left: 1.0),
                                      width: MediaQuery.of(context).size.width,
                                      // child: Text(
                                      //   " ${widget.title} ",
                                      //   style: TextStyle(
                                      //     fontSize: 20,
                                      //     color: Colors.green,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // )),
                                      child: judul(context)),
                                  new Container(
                                    padding:
                                        EdgeInsets.only(left: 1.0, bottom: 2.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      " ${widget.kategori} ",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  new Container(
                                    padding:
                                        EdgeInsets.only(left: 1.0, bottom: 2.0),
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 10,
                                        ),
                                        rtg.length == 0
                                            ? Text("rr")
                                            : Text(
                                                rtg[0]['rating'].toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
