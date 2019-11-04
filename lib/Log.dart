import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neonton/component/SignUp.dart';
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
  String msg = "";
  String id;
  static List data = [];
  login() async {
    var url = 'http://infinacreativa.com/neonton/index.php?Apii/login';
    var response = await http.post(url, body: {
      "email": emailController.text,
      "password": passController.text,
    }).then((result) async {
      var content = json.decode(result.body);
      data = content;
      if (data.length > 0) {
        getData();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      } else {
        msg = "Email/password Salah";
      }
    }).catchError((error) {});
  }

  Future<String> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
            Center(
              child: Text(
                "NEONTON",
                softWrap: true,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.red),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                style: new TextStyle(color: Colors.white),
                // initialValue: 'alucard@gmail.com',
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email',
                  focusColor: Colors.red,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  // border: OutlineInputBorder(
                  //   borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                  //     borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),

            // TextField(
            //   // autofocus: true,
            //   controller: emailController,
            //   keyboardType: TextInputType.emailAddress,
            //   decoration: InputDecoration(
            //     labelText: "E-mail",
            //     labelStyle: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 20,
            //     ),
            //   ),
            //   style: TextStyle(fontSize: 20),
            // ),
            Text(msg),
            Theme(
              data: Theme.of(context).copyWith(primaryColor: Colors.red),
              child: TextFormField(
                autofocus: false,
                style: new TextStyle(color: Colors.white),
                // initialValue: 'some password',
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: 'Password',
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
            //   // autofocus: true,
            //   controller: passController,
            //   keyboardType: TextInputType.text,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: "Kata Sandi",
            //     labelStyle: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 20,
            //     ),
            //   ),
            //   style: TextStyle(fontSize: 20),
            // ),
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
                    login();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Sign up",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
