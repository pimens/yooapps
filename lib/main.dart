import 'package:flutter/material.dart';
import 'package:neonton/Log.dart';
import 'package:neonton/component/Draw.dart';
import 'package:neonton/pageVideo/Video.dart';
import 'package:neonton/component/SearchPage.dart';
import 'package:neonton/tentang.dart';
import 'package:splashscreen/splashscreen.dart';
import './hal_rekomendasi.dart' as rekomendasi;
import './hal_edukasi.dart' as edukasi;
import './hal_entertaiment.dart' as entertaiment;

void main() {
  runApp(new MaterialApp(   
     
    title: "Neonton",
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      '/video': (context) => Video(id: "x"),
    },
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Home(),
      title: new Text('Neonton',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      image : Image.asset("assets/logo.png"),
      backgroundColor: Color(0xFF3B3A3A),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
      
    );
  }
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85.0),
        child: new AppBar(
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
