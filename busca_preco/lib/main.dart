import 'package:buscapreco/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text("Busca Preço"),
      ),
      body: Center(
        child: Column(

          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                hint: "Passe o codigo de barras",
                prefix: Icon(Icons.search),
                textInputType: TextInputType.number,

              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(

                  width: constraints.maxWidth,
                  height: 200,
                  child: Card(

                    elevation: 30,
                    color: Colors.white12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("ANADOR 500MG C/24",
                            style: TextStyle(
                                fontSize: 18)),
                        Text("R\$ 2.50", style: TextStyle(fontSize: 25),)
                      ],
                    ),
                  ),
                );

              })

          ],
        ),
      ),

    );
  }
}
