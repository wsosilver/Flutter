
  import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: "Convensor de Moedas",
    home:  Home()));
  }



  class Home extends StatefulWidget {
    @override
    _HomeState createState() => _HomeState();
  }

  class _HomeState extends State<Home> {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController realController =  TextEditingController();
    TextEditingController dolarController =  TextEditingController();
    TextEditingController euroController =  TextEditingController();

    double _real;
    double _dolar;
    double _euro;

    void clear(){
      setState(() {
         realController.text = "";
         dolarController.text = "";
         euroController.text = "";
      });
    }

    void toEuro(value){
     setState(() {
       _euro = double.parse(value);
       _dolar = _euro * 1.09;
       _real = _euro * 6.29;
      realController.text = _real.toString();
      dolarController.text = _dolar.toString();
       euroController.text = _euro.toString();
     });

    }
    void toDolar(value){
      setState(() {
        _dolar = double.parse(value);
        _euro = _dolar * 1.09;
        _real = _dolar * 6.29;
        realController.text = _real.toString();
        dolarController.text = _dolar.toString();
        euroController.text = _euro.toString();

      });
    }

    void toReal(value){
      setState(() {
        _real = double.parse(value);
        _dolar = _real * 0.87;
        _euro = _real * 0.79;
        realController.text = _real.toString();
        dolarController.text = _dolar.toString();
        euroController.text = _euro.toString();

      });
    }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text( 'Convensor de moedas'),
          backgroundColor: Colors.orange,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                clear();
              },
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  size: 120,
                  color: Colors.orange  ,
                ),
                TextFormField(

                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: realController,
                  onChanged: (text) {
                    toReal(text);
                  },
                  decoration: InputDecoration(
                    /*  hintText: 'Tell us about yourself',
                      helperText: 'Keep it short, this is just a demo.',*/
                      labelText: "Real",
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      border: OutlineInputBorder(),

                      labelStyle: TextStyle(color: Colors.orange)
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: dolarController,
                  onChanged: (text) {
                    toDolar(text);
                  },

                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      labelText: "Dolar",
                      border: OutlineInputBorder(),

                      labelStyle: TextStyle(color: Colors.orange)
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.orange, fontSize: 25),
                  controller: euroController,
                  onChanged: (text) {
                       toEuro(text);
                    },

                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.orange),
                      ),
                      labelText: "Euro",
                      border: OutlineInputBorder(),

                      labelStyle: TextStyle(color: Colors.orange)
                  ),
                ),

              ],
            ),
          ),
        ),

      );
    }
  }
