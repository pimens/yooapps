import 'package:flutter/material.dart';
import 'package:neonton/Log.dart';
import 'package:neonton/component/Draw.dart';
import 'package:neonton/pageVideo/Video.dart';
import 'package:neonton/component/SearchPage.dart';
import 'package:neonton/tentang.dart';

import './hal_rekomendasi.dart' as rekomendasi;
import './hal_edukasi.dart' as edukasi;
import './hal_entertaiment.dart' as entertaiment;

void main() {
  runApp(new MaterialApp(
    title: "Neonton",
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/video': (context) => Video(id: "x"),
    },
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controller;
  ScrollController scrollViewController;
  final myController = TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  int find = 0;
  Widget _appBarTitle = new Text('NEONTON');
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
    scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollViewController.dispose();
    super.dispose();
  }

  Widget search(BuildContext context) {
    if (this.find == 0) {
      return new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      );
    } else {
      return Row(
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(keyword: myController.text),
                ),
              );
            },
          ),
          new IconButton(
              icon: new Icon(Icons.close), onPressed: _searchPressed),
        ],
      );
    }
  }

  void _searchPressed() {
    setState(() {
      if (this.find == 0) {
        this.find = 1;
        this._appBarTitle = new TextField(
          controller: myController,
          decoration: new InputDecoration(hintText: 'Search..'),
        );
      } else {
        this.find = 0;
        this._appBarTitle = new Text('NEONTON');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        centerTitle: true,
        title: _appBarTitle,
        actions: <Widget>[search(context)],
        bottom: new TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(
              text: "Rekomendasi",
            ),
            Tab(
              text: "Edukasi",
            ),
            Tab(
              text: "Entertaiment",
            ),
          ],
        ),
      ),
      drawer: Draw(),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new rekomendasi.Rekomendasi(),
          new edukasi.Edukasi(),
          new entertaiment.Entertaiment(),
        ],
      ),
    );
  }
}
