import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neonton/main.dart';

class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  final passController = TextEditingController();
  final emailController = TextEditingController();
  static List data = [];
  Future<String> getData() async {
    String url =
        'http://infinacreativa.com/neonton/index.php?Apii/getUser/informatika15/' +
            passController.text;
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
      if (data.length > 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('login', 'hello');
        prefs.setStringList('login', [
          data[0]['name'].toString(),
          data[0]['foto'].toString(),
          data[0]['user_id'].toString(),
          data[0]['saldo'].toString(),
          // data[0]['foto'].toString(),
        ]);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);        
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Log(),
          ),
        );
      }
    }
    return 'success!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Color(0xFF3B3A3A),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              // autofocus: true,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              // autofocus: true,
              controller: passController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Kata Sandi",
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
              style: TextStyle(fontSize: 20),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  emailController.text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  // MaterialPageRoute(
                  //   builder: (context) => ResetPasswordPage(),
                  // ),
                  // );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFFE82A2C),
                    Color(0xFFBC2021),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        child: SizedBox(
                          child: Image.asset("assets/logo-white.png"),
                          height: 30,
                          width: 30,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    getData();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    passController.dispose();
    emailController.dispose();
  }
}
