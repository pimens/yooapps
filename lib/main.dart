import 'package:flutter/material.dart';
import 'package:boiler_bloc/component/Draw.dart';
import 'package:boiler_bloc/pageVideo/Video.dart';
import 'package:boiler_bloc/component/SearchPage.dart';
import 'package:splashscreen/splashscreen.dart';
import './hal_rekomendasi.dart' as rekomendasi;
import './hal_beranda.dart' as beranda;
import './hal_edukasi.dart' as edukasi;
import './hal_entertaiment.dart' as entertaiment;

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      // Define the default brightness and colors.
      // brightness: Brightness.dark,
      // primaryColor: Colors.red,
      // accentColor: Colors.cyan[600],

      // Define the default font family.
      fontFamily: 'Montserrat',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      // textTheme: TextTheme(
      //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      // ),
    ),
    title: "Neonton",
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
      // '/video': (context) => Video(id: "x"),
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
      title: new Text(
        'Neonton',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      image: Image.asset("assets/logo.png"),
      backgroundColor: Color(0xFF3B3A3A),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
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
    controller = new TabController(vsync: this, length: 4);
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
            indicatorColor: Colors.red,
            controller: controller,
            tabs: <Widget>[
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Rekomendasi",
              ),
              Tab(
                text: "Education",
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
          new beranda.beranda(),
          new rekomendasi.Rekomendasi(),
          new edukasi.Edukasi(),
          new entertaiment.Entertaiment(),

        ],
      ),
    );
  }
}
