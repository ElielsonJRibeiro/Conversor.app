import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=d321af6e";

void main() async{

  runApp(MaterialApp(
    home: Home()
  ));
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(

        title: Text("🤑Conversor🤑", style: TextStyle(color: Colors.black38, fontSize: 25.0,),),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
    );
  }
}


Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}