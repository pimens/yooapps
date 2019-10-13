import 'package:flutter/material.dart';
import 'package:neonton/Log.dart';
import 'package:neonton/component/ChewieListItem.dart';
import 'package:neonton/component/Draw.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Video extends StatefulWidget {
  String id = "";
  String harga;
  Video({this.id, this.harga});
  @override
  _VideoState createState() => _VideoState(id: id, harga: harga);
}

class _VideoState extends State<Video> {
  String id, x;
  String harga = "";
  int saldo = 0;
  _VideoState({this.id, this.harga});
  static String user = "0";
  static bool rate = false;
  List data = [], byr = [];
  List cekrtg = [];
  List rtg = [];
  List data_login = [];

  //pembayaran
  Future<String> pembayaran() async {
    String ur = "http://infinacreativa.com/neonton/index.php?Apii/payVideo/" +
        data_login[2] +
        "/" +
        id;
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    //getSaldobaru
    String url = 'http://infinacreativa.com/neonton/index.php?Apii/getUserById/' +
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
      d[0]['email'].toString(),
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
    }
  }

  Future<String> getData() async {
    String url = 'http://infinacreativa.com/neonton/index.php?Apii/getVideoById/';
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

  Future<String> getRating() async {
    String ur = "http://infinacreativa.com/neonton/index.php?Apii/getRating/" + id;
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
    String ur = "http://infinacreativa.com/neonton/index.php?Apii/cekRating/" +
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
        "http://infinacreativa.com/neonton/index.php?Apii/alreadyPayForVideo/" +
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
    getValuesSF();
  }

  void insertRating(String rating) {
    var url = "http://infinacreativa.com/neonton/index.php?Apii/insertRating/" +
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
          actions: <Widget>[new Icon(Icons.search)],
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
                    decoration: new BoxDecoration(
                      color: Color(0xFF3B3A3A),
                      // gradient: new LinearGradient(
                      //   colors: [Colors.red, Colors.cyan],
                      // ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: data.length == 0
                              ? Text("")
                              : Text(
                                  data[0]['judul'].toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 1
                                      ..color = Colors.white,
                                  ),
                                ),
                        ),
                        Divider()
                      ],
                    ),
                  ),

                  ///kalau untuk yang harus bayar lagi cek lagi dbnya videonya bimbel apa bukan taruh sini,
                  ///habis cek di db movie cek lagi di db user buy video, si user udh beli apa blum bru
                  ///bisa nnton videonya
                  new Container(
                    child: new ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        // http://infinacreativa.com/neonton/assets/global/video/'
                        data.length == 0
                            ? "http://"
                            : data[0]['file_video'].toString(),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Text('Views : '),
                            data.length == 0
                                ? Text("")
                                : new Text(data[0]["view"].toString() + " x"),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            //sementara pakai rating begini, nnti jadi db, sebelum nampilin data harus cek db apakah user sudah rate atau belum
                            new Text("Rating : "),
                            // new Text(data[0]['rating'].toString() + "   "),
                            rtg.length == 0
                                ? new Text(" 0 ")
                                : new Text(rtg[0]['rating'].toString()),
                            cekrtg.length > 0
                                ? new Text("")
                                : rate == false
                                    ? new RaisedButton(
                                        //cek apakah user sudah rate taroh disni nanti
                                        child: new Text("Rate this video"),
                                        onPressed: () {
                                          setState(() {
                                            rate = !rate;
                                          });
                                        })
                                    : new Text("data"),
                            rate == false
                                ? new Text("")
                                : new Row(
                                    children: <Widget>[
                                      new FlutterRatingBar(
                                        initialRating: rtg.length == 0
                                            ? 0
                                            : rtg[0]['rating'].toString() ==
                                                        "null" ||
                                                    rtg.length < 0
                                                ? 0
                                                : double.parse(rtg[0]['rating']
                                                    .toString()),
                                        itemSize: 25.0,
                                        // noRatingWidget: true,
                                        fillColor: Colors.amber,
                                        borderColor: Colors.amber.withAlpha(50),
                                        allowHalfRating: true,
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                          insertRating(rating.toString());
                                        },
                                      ),
                                      new RaisedButton(
                                          child: new Text("Rate"),
                                          onPressed: () {
                                            setState(() {
                                              rate = !rate;
                                            });
                                          }),
                                    ],
                                  )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            new Text("description : "),
                            Expanded(
                              child: new Container(
                                width: MediaQuery.of(context).size.width,
                                child: data.length == 0
                                    ? Text("")
                                    : new Text(
                                        data[0]['deskripsi_video'].toString()),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            new Text("Genre"),
                            new Text("Komedi"),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ));
  }
   @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources   
  }
}
