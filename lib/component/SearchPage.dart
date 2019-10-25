import 'package:flutter/material.dart';
import 'package:neonton/component/Draw.dart';
import 'package:http/http.dart' as http;
import 'package:neonton/component/ItemSearch.dart';
import 'package:neonton/component/trending_item.dart';
import 'package:neonton/pageVideo/Ecourse.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class SearchPage extends StatefulWidget {
  String keyword;
  SearchPage({this.keyword});
  @override
  _SearchPageState createState() => _SearchPageState(keyword: this.keyword);
}

class _SearchPageState extends State<SearchPage> {
  String keyword;
  _SearchPageState({this.keyword});
  final TextEditingController _searchControl = new TextEditingController();

  List data = [];
  Future<String> getData(String key) async {
    this.keyword = key;
    final String url =
        'http://infinacreativa.com/neonton/index.php?Apii/getEcourseByTitle/' +
            key;
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        data = content;
      });
    }

    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    getData(keyword);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        title: new Center(
          child: new Text("NEONTON"),
        ),
      ),
      drawer: Draw(),
      body: new Column(
        children: <Widget>[
          Card(
            elevation: 6.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
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
                  hintText: "Keyword Searching : " + keyword,
                  suffixIcon: new IconButton(
                    icon: new Icon(Icons.search,color: Colors.black,),
                    onPressed: () =>getData(_searchControl.text),
                  ),                  
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          new Text(
            "Hasil Pencarian",
            style: TextStyle(
              fontSize: 30,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.black,
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map video = data[index];
                      return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, "/video");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Ecourse(
                                  id: video['id_video'].toString(),
                                  harga: video['harga'],
                                ),
                              ),
                            );
                          },
                          // child: Text(video["judul"].toString()),
                          child: ItemSearch(
                            img: video["thumbnail"].toString(),
                            title: video["judul"],
                            address: video["kategori"],
                            rating: video["harga"],
                            view: video["view"],
                          )
                          );
                    },
                  ),
                  Center(child: data.length == 0 ? Text("Tidak Ditemukan") : Text("")),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
