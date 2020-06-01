import 'package:flutter/material.dart';
import 'package:neonton_apps/hal_edukasi.dart';
import 'package:neonton_apps/hal_entertaiment.dart';
import 'package:neonton_apps/hal_rekomendasi.dart';
import 'package:neonton_apps/main.dart';
import 'package:neonton_apps/pengaturan.dart';
import 'package:neonton_apps/profil.dart';
import 'package:neonton_apps/tentang.dart';
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
  Widget DrLogin(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Home(),
            )),
            child: ListTile(
              title: Text(
                data_login[0].toString(),
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
              builder: (BuildContext context) => new Pengaturan(),
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

  @override
  Widget build(BuildContext context) {
    return DrLogin(context);
  }
}
