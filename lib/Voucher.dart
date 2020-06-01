import 'package:flutter/material.dart';
import 'package:boiler_bloc/component/Draw.dart';
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
        "http://192.168.43.184/webNeon/index.php?Apii/getUserById/" +
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
        "http://192.168.43.184/webNeon/index.php?Apii/cekVoucher/" +
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
        } else {
          setStatus("Sudah pernah TOPUP dengan Kode : " + kodeVoucher.text);
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
        "http://192.168.43.184/webNeon/index.php?Apii/insertVoucher/" +
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
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        title: new Center(
          child: new Text("NEONTON"),
        ),
        actions: <Widget>[new Icon(Icons.search)],
      ),
      drawer: Draw(),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.red),
                child: TextFormField(
                  autofocus: false,
                  controller: kodeVoucher,
                  style: new TextStyle(color: Colors.white),
                  // initialValue: 'some password',
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    hintText: 'Kode Voucher',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    focusColor: Colors.red,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                  ),
                ),
              ),
              // TextField(
              //   style: TextStyle(
              //     fontSize: 15.0,
              //     color: Colors.black,
              //   ),
              //   decoration: InputDecoration(
              //     contentPadding: EdgeInsets.all(10.0),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(5.0),
              //       borderSide: BorderSide(
              //         color: Colors.black,
              //       ),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: Colors.black,
              //       ),
              //       borderRadius: BorderRadius.circular(5.0),
              //     ),
              //     hintText: "Masukkan Kode Voucher",
              //     hintStyle: TextStyle(
              //       fontSize: 15.0,
              //       color: Colors.black,
              //     ),
              //   ),
              //   maxLines: 1,
              //   controller: kodeVoucher,
              // ),
              OutlineButton(
                onPressed: cekV,
                child: Text(
                  'TopUpVoucher',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
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
