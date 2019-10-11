import 'package:flutter/material.dart';
import 'package:neonton/Log.dart';
import 'package:neonton/hal_edukasi.dart';
import 'package:neonton/hal_entertaiment.dart';
import 'package:neonton/hal_rekomendasi.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
    // data_login = prefs.getString('login') ?? '';
  }

  // Widget dialog(BuildContext context) {
  //   return AlertDialog(
  //     title: new Text("Alert Dialog title"),
  //     content: new Text("Alert Dialog body"),
  //     actions: <Widget>[
  //       // usually buttons at the bottom of the dialog
  //       new FlatButton(
  //         child: new Text("Close"),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //     ],
  //   );
  // }

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
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Rekomendasi(),
            )),
            child: ListTile(
              title: Text(
                'Rekomendasi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.event_available,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Log(),
            )),
            child: ListTile(
              title: Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
              ),
            ),
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
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget DrLogin(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(data_login[0].toString()),
            accountEmail: Text(data_login[1].toString()),
            currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
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
            child: ListTile(
              title: Text(
                "Beranda",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Profil(),
            )),
            child: ListTile(
              title: Text(
                'Profil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.person,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Rekomendasi(),
            )),
            child: ListTile(
              title: Text(
                'Rekomendasi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.event_available,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Edukasi(),
            )),
            child: ListTile(
              title: Text(
                'Edukasi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.school,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Entertaiment(),
            )),
            child: ListTile(
              title: Text(
                'Entertaiment',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.camera,
                color: Color(0xFF3B3A3A),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Pengaturan(),
            )),
            child: ListTile(
              title: Text(
                'Pengaturan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
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
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => logout(context),
            child: ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B3A3A),
                ),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ),
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
