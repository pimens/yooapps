import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  ///jangan lupa update data login!!!!!!!!!!!!
  final passController = TextEditingController();
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  List dataProfil = [];
  List data_login = [];
  Future<String> getProfil() async {
    String ur =
        "http://infinacreativa.com/neonton/index.php?Apii/getUserById/" +
            data_login[2];
    var res = await http
        .get(Uri.encodeFull(ur), headers: {'accept': 'application/json'});
    if (this.mounted) {
      setState(() {
        var content = json.decode(res.body);
        dataProfil = content;
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('login', [
      dataProfil[0]['name'].toString(),
      dataProfil[0]['foto'].toString(),
      dataProfil[0]['user_id'].toString(),
      dataProfil[0]['saldo'].toString()
    ]);
    return "ok";
  }

  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    data_login = prefs.getStringList('login') ?? [];
    getProfil();
  }

  @override
  void initState() {
    super.initState();
    getValuesSF();
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    // startUpload();
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }
  // startUpload() {
  //   setStatus('Uploading Image...');
  //   if (null == tmpFile) {
  //     setStatus(errMessage);
  //     return;
  //   }
  //   String fileName = tmpFile.path.split('/').last;
  //   upload(fileName);
  // }

  upload(String fileName) async {
    var url = 'http://infinacreativa.com/neonton/index.php?Apii/editFoto';
    var response = await http.post(url, body: {
      "image": base64Image,
      "name": fileName,
      "id": data_login[2],
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
    getProfil();
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Text("");
          // return Container(
          //   child: Image.file(
          //     snapshot.data,
          //     fit: BoxFit.fill,
          //   ),
          // );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF3B3A3A),
        title: new Center(
          child: new Text("NEONTON"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: ClipPath(
                  clipper: ClippingClass(),
                  child: Container(
                    height: 130.0,
                    decoration: BoxDecoration(color: Color(0xFF3B3A3A)),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: dataProfil.length == 0
                              ? NetworkImage(
                                  "http://infinacreativa.com/neonton/assets/global/fotoUser/scaled_IMG-20191013-WA0001.jpg")
                              : NetworkImage(
                                  "http://infinacreativa.com/neonton/" +
                                      dataProfil[0]['foto'].toString())),
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: OutlineButton(
                    onPressed: chooseImage,
                    child: Icon(Icons.camera_enhance),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Center(
            child: OutlineButton(
              onPressed: startUpload,
              child: new Icon(
                Icons.save,
                color: Colors.lightBlue,
              ),
            ),
          ),
          Card(
            elevation: 4.0,
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
                  hintText: dataProfil.length == 0
                      ? ""
                      : dataProfil[0]["name"].toString(),
                  suffixIcon: new IconButton(
                    icon: new Icon(
                      Icons.save,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () => {},
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: passController,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            elevation: 4.0,
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
                  hintText: dataProfil.length == 0
                      ? ""
                      : dataProfil[0]["email"].toString(),
                  suffixIcon: new IconButton(
                    icon: new Icon(
                      Icons.save,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () => {},
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: passController,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            elevation: 4.0,
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
                  hintText: "New Password",
                  suffixIcon: new IconButton(
                    icon: new Icon(
                      Icons.save,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () => {},
                  ),
                  // Icon(
                  //   Icons.search,
                  //   color: Colors.black,
                  // ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: passController,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          // Text(status),
          showImage(),
          // Text(dataProfil[0]['foto'].toString())
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon) {
    return Container(
      height: 60.0,
      width: 60.0,
      child: Material(
        borderRadius: BorderRadius.circular(12.0),
        elevation: 34.0,
        shadowColor: Colors.white70,
        child: MaterialButton(
          onPressed: () {},
          child: Icon(
            icon,
            color: Color(0xFF3B3A3A),
          ),
        ),
      ),
    );
  }

  Widget _buildUserImage(AssetImage img, double size, double margin) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - (size.width / 4),
      size.height,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
