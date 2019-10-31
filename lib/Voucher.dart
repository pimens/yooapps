import 'package:flutter/material.dart';
import 'package:neonton/component/Draw.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Voucher extends StatefulWidget {
  @override
  _VoucherState createState() => _VoucherState();
}

class _VoucherState extends State<Voucher> {
  List cekVoucher = [];
  final TextEditingController kodeVoucher = new TextEditingController();
  static List data_login = [];
  static List dataProfil = [];

  String pesan = '';
  _VoucherState() {
    getValuesSF();
  }
  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data_login = prefs.getStringList('login') ?? [];
  }
  Future<String> getProfil() async {
    String ur =
        "http://infinacreativa.com/neonton/index.php?Apii/getUserById/" +
            data_login[2];
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        dataProfil = content;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('login', [
      dataProfil[0]['name'].toString(),
      dataProfil[0]['foto'].toString(),
      dataProfil[0]['user_id'].toString(),
      dataProfil[0]['saldo'].toString()
    ]);
    return "ok";
  }

  Future<String> cekV() async {
    String url =
        "http://infinacreativa.com/neonton/index.php?Apii/cekVoucher/" +
            data_login[2] +
            "/" +
            kodeVoucher.text;
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        cekVoucher = content;
        if (cekVoucher.length == 0) {
          insertV();
          getProfil();
        }else{
          setStatus("Sudah pernah TOPUP dengan Kode : "+kodeVoucher.text);
        }
      });
    }
    return 'success!';
  }

  setStatus(String message) {
    setState(() {
      pesan = message;
    });
  }

  insertV() async {
    String url =
        "http://infinacreativa.com/neonton/index.php?Apii/insertVoucher/" +
            data_login[2] +
            "/" +
            kodeVoucher.text;
    var response = await http.post(url, body: {}).then((result) {
      setStatus(result.statusCode == 200 ? result.body : "Something Wrong");
    }).catchError((error) {
      setStatus(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        title: new Center(
          child: new Text("NEONTON"),
        ),
        actions: <Widget>[new Icon(Icons.search)],
      ),
      drawer: Draw(),
      body: Center(
        child: Container(
          child: Column(
            children: <Widget>[
              TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Masukkan Kode Voucher",
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: kodeVoucher,
              ),
              OutlineButton(
                onPressed: cekV,
                child: Text('TopUpVoucher'),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(pesan)
            ],
          ),
        ),
      ),
    );
  }
}
