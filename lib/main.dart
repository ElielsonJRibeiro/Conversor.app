import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=d321af6e";

void main() async {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text){
    print(text);
  }
  void _dolarChanged(String text){
    print(text);
  }
  void _euroChanged(String text){
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "🤑Conversor🤑",
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text(
                    "Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro a Carregar Dados :(",
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data['results']["currencies"]["USD"]["buy"];
                  euro = snapshot.data['results']["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            size: 150.0, color: Colors.amber),
                        bildTextField("Reais", "R\$", realController, _realChanged),
                        Divider(),
                        bildTextField("Dólares", "US\$", dolarController, _dolarChanged),
                        Divider(),
                        bildTextField("Euros", "€", euroController, _euroChanged),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget bildTextField(String label, String prefix, TextEditingController c, Function f){
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
      prefixText: prefix
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    onChanged: f,
    keyboardType: TextInputType.number,
  );

}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
