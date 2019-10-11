import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';
class Pembayaran extends StatefulWidget {
  String id = "";
  Pembayaran({this.id}); 
  @override  
  _PembayaranState createState() => _PembayaranState(id:id);
}


class _PembayaranState extends State<Pembayaran> {
  String id;
   _PembayaranState({this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}