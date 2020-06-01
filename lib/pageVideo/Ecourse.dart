import 'package:flutter/material.dart';
import 'package:neonton_apps/Log.dart';
import 'package:neonton_apps/component/ChewieListItem.dart';
import 'package:neonton_apps/component/Draw.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Ecourse extends StatefulWidget {
  String id = "";
  String harga;
  Ecourse({this.id, this.harga});
  @override
  _EcourseState createState() => _EcourseState(id: id, harga: harga);
}

class _EcourseState extends State<Ecourse> {
  String id, x;
  String harga = "";
  int saldo = 0;
  _EcourseState({this.id, this.harga});
  static String user = "0";
  static bool rate = false;
  List data = [], byr = [];
  List cekrtg = [];
  List rtg = [];
  List materi = [];
  List data_login = [];

  //pembayaran
  Future<String> pembayaran() async {
    String ur = "http://192.168.43.184/webNeon/index.php?Apii/payEcourse/" +
        data_login[2] +
        "/" +
        id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    //getSaldobaru
    String url =
        'http://192.168.43.184/webNeon/index.php?Apii/getUserById/' +
            data_login[2];
    List d = [];
    res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        d = content;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('login', [
      d[0]['name'].toString(),
      d[0]['foto'].toString(),
      d[0]['user_id'].toString(),
      d[0]['saldo'].toString()
    ]);
    return 'success!';
  }

  //popup pembayaran
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: new Text("Pembayaran"),
              content: new Text(
                  "Apakah anda mau membeli video ini dengan harga : " +
                      harga +
                      " ? "),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Beli"),
                  onPressed: () {
                    saldo = int.parse(data_login[3]) - int.parse(harga);
                    if (saldo < 0) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else {
                      pembayaran();
                      Navigator.of(context).pop();
                      getData();
                      getRating();
                    }
                  },
                ),
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    // Navigator.pop(context);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
    );
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data_login = prefs.getStringList('login') ?? [];
    if (data_login.length == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Log(),
        ),
      );
    } else {
      cekBayar();
    }
    // data_login = prefs.getString('login') ?? '';
  }

  openPembayaran() {
    if (byr.length == 0) {
      _showDialog();
    } else {
      getData();
      getRating();
      getMateri();
    }
  }

  Future<String> getData() async {
    String url =
        'http://192.168.43.184/webNeon/index.php?Apii/getEcourseById/';
    String ur = url + id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
    }
    return 'success!';
  }

  Future<String> getMateri() async {
    String url = 'http://192.168.43.184/webNeon/index.php?Apii/getMateri/';
    String ur = url + id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        materi = content;
      });
    }
    return 'success!';
  }

  Future<String> getRating() async {
    String ur =
        "http://192.168.43.184/webNeon/index.php?Apii/getRatingEcourse/" +
            id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        rtg = content;
      });
    }
    cekRating();
    return "ok";
  }

  Future<String> cekRating() async {
    String ur =
        "http://192.168.43.184/webNeon/index.php?Apii/cekRatingEcourse/" +
            data_login[2];
    ur = ur + "/" + id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        cekrtg = content;
      });
    }
    return 'success!';
  }

  Future<String> cekBayar() async {
    String ur =
        "http://192.168.43.184/webNeon/index.php?Apii/alreadyPayForEcourse/" +
            data_login[2];
    ur = ur + "/" + id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        byr = content;
      });
    }
    openPembayaran();
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    rate = false;
    getValuesSF();
  }

  void insertRating(String rating) {
    var url =
        "http://192.168.43.184/webNeon/index.php?Apii/insertRatingEcourse/" +
            data_login[2] +
            "/" +
            id +
            "/" +
            rating;
    http.get(url).then((response) {
      getRating();
    });
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
        body: data.length == 0
            ? new Container(
                child: Center(
                child: new CircularProgressIndicator(),
              ))
            : Column(
                children: <Widget>[
                  new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: new Container(
                            padding: EdgeInsets.only(left: 7.0),
                            width: MediaQuery.of(context).size.width,
                            child: data.length == 0
                                ? Text("")
                                : Text(
                                    data[0]['judul'].toString(),
                                    style: TextStyle(
                                      fontFamily: "poppin",
                                      fontSize: 20,                                      
                                    ),
                                  ),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  ),
                  Divider(),

                  ///kalau untuk yang harus bayar lagi cek lagi dbnya videonya bimbel apa bukan taruh sini,
                  ///habis cek di db movie cek lagi di db user buy video, si user udh beli apa blum bru
                  ///bisa nnton videonya
                  new Container(
                    child: new ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        // http://192.168.43.184/webNeon/assets/global/video/'
                        data.length == 0
                            ? "http://"
                            : data[0]['file_video'].toString(),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(left: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Text('Views          : '),
                                  data.length == 0
                                      ? Text("")
                                      : new Text(
                                          data[0]["view"].toString() + " x"),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Text("Rating         : "),
                                      rtg.length == 0
                                          ? Text("0")
                                          : Text(rtg[0]['rating']),
                                    ],
                                  ),
                                  cekrtg.length == 0
                                      ? new FlutterRatingBar(
                                          initialRating: 0,
                                          itemSize: 25.0,
                                          // noRatingWidget: true,
                                          fillColor: Colors.amber,
                                          borderColor:
                                              Colors.amber.withAlpha(50),
                                          allowHalfRating: true,
                                          onRatingUpdate: (rating) {
                                            // print(rating);
                                            insertRating(rating.toString());
                                          },
                                        )
                                      : Text(""),
                                  cekrtg.length == 0
                                      ? new IconButton(
                                          icon: new Icon(Icons.star,
                                              color: Colors.yellow),
                                          onPressed: () => {},
                                        )
                                      : Text("")
                                ],
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  new Text("Deskripsi    : "),
                                  Expanded(
                                    child: new Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: data.length == 0
                                          ? Text("")
                                          : new Text(data[0]['deskripsi_video']
                                              .toString()),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  new Text("Kategori      : "),
                                  Expanded(
                                    child: new Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: data.length == 0
                                          ? Text("")
                                          : new Text(
                                              data[0]['kategori'].toString()),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  new Text("Author         : "),
                                  Expanded(
                                    child: new Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: data.length == 0
                                          ? Text("")
                                          : new Text(
                                              data[0]['author'].toString()),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  new Text("Materi          : "),
                                  Expanded(
                                    child: ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          materi == null ? 0 : materi.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map mt = materi[index];

                                        return GestureDetector(
                                          onTap: () {
                                            launch(mt['path'].toString());
                                          },
                                          child: Text(
                                            (index + 1).toString() +
                                                ". " +
                                                mt['judul'].toString(),
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
