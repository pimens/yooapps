import 'package:flutter/material.dart';
import 'package:neonton/util/const.dart';
import 'package:expandable/expandable.dart';

class ItemSearch extends StatefulWidget {
  final String img;
  final String title;
  final String address;
  final String rating;
  final String view;

  ItemSearch({
    Key key,
    @required this.img,
    @required this.title,
    @required this.address, //katgori
    @required this.rating, //harga
    @required this.view,
  }) : super(key: key);

  @override
  _ItemSearchState createState() => _ItemSearchState();
}


class _ItemSearchState extends State<ItemSearch> {
  Widget judul(BuildContext context) {
    return ExpandablePanel(
      // header: Text("xxx"),
      collapsed: Text(
        " ${widget.title} ",
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: Text(
        " ${widget.title} ",
        softWrap: true,
      ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height/2.5,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        "${widget.img}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.monetization_on,
                              color: Constants.darkPrimary,
                              size: 10,
                            ),
                            Text(
                              " ${widget.rating} ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 26.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              color: Constants.darkPrimary,
                              size: 10,
                            ),
                            Text(
                              " ${widget.view} ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    left: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              " ${widget.address} ",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add_box,
                              color: Constants.darkPrimary,
                              size: 16,
                            ),
                            Expanded(
                              child: new Container(
                                  padding: EdgeInsets.only(left: 7.0),
                                  width: MediaQuery.of(context).size.width,
                                  // child: Text(
                                  //   " ${widget.title} ",
                                  //   style: TextStyle(
                                  //     fontSize: 20,
                                  //     color: Colors.green,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // )),
                                  child: judul(context)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}