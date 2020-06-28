import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      title: "Contador de pessoas",
      home: Home()));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  int _People = 0;
  String status = "Pode entrar";
  void _changePeople(int delta){
    setState(() {
      _People += delta;
       status = (_People < 10) ? "Pode entraar" : "Não pode Entrar";
       if(_People < 0) status = "Mundo invertido?!";
    });
  }



  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurant.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_People",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () {
                      _changePeople(1);
                      /*...*/
                    },
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: FlatButton(
                    onPressed: () {
                      _changePeople(-1);
                    },
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Text(
              "$status",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )
          ],
        ),
      ],
    );
  }
}
