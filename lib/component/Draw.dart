import 'package:flutter/material.dart';
import 'package:neonton/Log.dart';
import 'package:neonton/Topup.dart';
import 'package:neonton/Voucher.dart';
import 'package:neonton/component/SignUp.dart';
import 'package:neonton/main.dart';
import 'package:neonton/pengaturan.dart';
import 'package:neonton/profil.dart';
import 'package:neonton/tentang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Draw extends StatelessWidget {
  static List data_login = [];
  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data_login = prefs.getStringList('login') ?? [];
    // data_login = prefs.getString('login') ?? '';
  }

  Draw() {
    getValuesSF();
  }
  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("login");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Home(),
    //   ),
    // );
    // data_login = prefs.getString('login') ?? '';
  }

  Widget DrawerBeforeLogin(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: GestureDetector(
              child: SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.png"),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color(0xFF3B3A3A),
                Colors.grey,
              ]),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home(),
            )),
            child: ListTile(
              title: Text(
                "Beranda",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Colors.red,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Log(),
            )),
            child: ListTile(
              title: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              leading: Icon(
                Icons.vpn_key,
                color: Colors.redAccent,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new SignUp(),
            )),
            child: ListTile(
              title: Text(
                'SignUp',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              leading: Icon(
                Icons.input,
                color: Colors.redAccent,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Colors.red,
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Tentang(),
            )),
            child: ListTile(
              title: Text(
                'Tentang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              leading: Icon(
                Icons.help,
                color: Colors.red,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget DrLogin(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Container(
              margin: EdgeInsets.only(top: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      // margin: EdgeInsets.only(top: 10.0),
                      child: Text(data_login[0].toString())),
                  Text("Rp. " + data_login[3].toString(),
                      style: TextStyle(fontSize: 24))
                ],
              ),
            ),
            accountEmail: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(right: 25.0),
                    child: Text("Rp. " + data_login[3].toString(),
                        style: TextStyle(fontSize: 24))),
              ],
            ),
            currentAccountPicture: GestureDetector(
              child: Container(
                height: 110.0,
                width: 90.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage("http://infinacreativa.com/neonton/" +
                          data_login[1].toString())),
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Color(0xFF3B3A3A),
                Colors.grey,
              ]),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Beranda",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Profil(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Profil',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Topup(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Topup',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Voucher(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Kode Voucher',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Pengaturan(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Pengaturan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Tentang(),
            )),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Tentang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                ),
                new Container(
                  height: 0.5,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => logout(context),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Logout',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B3A3A),
                    ),
                  ),
                  trailing: new Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () => logout(context),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return data_login.length != 0
        ? DrLogin(context)
        : DrawerBeforeLogin(context);
  }
}
