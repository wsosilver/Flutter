import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() async {
  runApp(MaterialApp(
    title: "COnversor Api",
    home: Home(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get("https://api.hgbrasil.com/finance");
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController realController = TextEditingController();
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  double _dolar;
  double _euro;

  void clear(){

    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }
  void realChange(String text) {
    double real = double.parse(text);
    dolarController.text = (real/_dolar).toStringAsFixed(2);
    euroController.text = (real/_euro).toStringAsFixed(2);
  }

  void dolarChange(String text) {
    double _dolar = double.parse(text);
    realController.text = (_dolar * this._dolar).toStringAsFixed(2);
    euroController.text = (_dolar * this._dolar /_euro).toStringAsFixed(2);
  }

  void euroChange(String text) {
    double _euro = double.parse(text);
    realController.text = (_euro * this._euro).toStringAsFixed(2);
    dolarController.text = (_euro * this._euro /_dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("\$ Conversor API \$"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              clear();
            },
          )
        ],
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando...",
                style: TextStyle(color: Colors.amber, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Error ao carregar ):",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ));
              } else {
                _dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                _euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on,
                          size: 150.0, color: Colors.amber),
                      buildTextField("Reais", "R\$", realController, realChange),
                      Divider(),
                      buildTextField("Dolares", "US\$", dolarController, dolarChange),
                      Divider(),
                      buildTextField("Euros", "€", euroController, euroChange),
                    ],
                  ),
                );
              }
          }
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}

Widget buildTextField(String label, String prefixed, TextEditingController cont, Function f) {
  return TextField(
      controller: cont,
      onChanged: f,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.amber),
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.amber),
          ),
          border: OutlineInputBorder(),
          prefixText: prefixed,
          prefixStyle: const TextStyle(color: Colors.amber, fontSize: 25.0)),
      style: TextStyle(
        color: Colors.amber,
        fontSize: 25.0,
      ));
}
