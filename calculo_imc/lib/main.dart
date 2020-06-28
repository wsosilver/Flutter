import 'dart:ffi';

import 'package:flutter/material.dart';

const request = "https://api.hgbrasil.com/finance/";
void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    home: Container(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController pesoController =  TextEditingController();
  TextEditingController alturaController =  TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  String _resultado = "Insira as informações";
  double _r;

  void result(){
    setState(() {
      double _peso =  double.parse(pesoController.text) ;
      double _altura = double.parse(alturaController.text);

      _r =  (_peso / (_altura * _altura));
      if(_r < 18.5) _resultado = "Abaixo do peso (${_r.toStringAsPrecision(3)})";
      else if(_r < 24.9) _resultado = "Peso normal (${_r.toStringAsPrecision(3)})";
      else if(_r < 29.9) _resultado = "Sobrepeso (${_r.toStringAsPrecision(3)})";
      else if(_r < 34.9) _resultado = "Obesidade grau 1 (${_r.toStringAsPrecision(3)})";
      else if(_r < 39.9) _resultado = "Obesidade grau 2 (${_r.toStringAsPrecision(3)})";
      else if(_r > 40) _resultado = "Obesidade grau 3 (${_r.toStringAsPrecision(3)})";
    });

  }

  void clear(){

    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      _resultado = "Insira as informações";
      _formKey = GlobalKey<FormState>();

    });
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              clear();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.grey,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso(kg)",
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25),
                controller: pesoController,
                validator: (value) {
                  if(value.isEmpty)  return "insira seu peso";

                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura(cm)",
                    labelStyle: TextStyle(color: Colors.grey)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 25),
                controller: alturaController,
                validator: (v) {
                  if (v.isEmpty)
                    return "insira sua altura";

                }),
              Container(
                height: 50,
                child:  RaisedButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      result();
                    }
                  },
                  child: Text("Calcular", style: TextStyle(color: Colors.teal, fontSize: 25),), color: Colors.black,
                ),
              ),
              Text(
                "$_resultado",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 20),
              ),

            ],
          ),
        ),
      )
    );
  }
}
