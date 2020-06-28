import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Listar Tarefas",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tarefaController = TextEditingController();
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastPosition;

  @override
  void initState() {
    super.initState();
    setState(() {
      _readData().then((value) => {
            _toDoList = json.decode(value),
          });
    });
  }

  void addToDo() {
    setState(() {
      Map<String, dynamic> newToDO = Map();
      newToDO["title"] = tarefaController.text;
      tarefaController.text = "";
      newToDO["ok"] = false;
      _toDoList.add(newToDO);
      _saveData();
    });
  }

  Future<Null> refresh() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if(a["ok"] && !b["ok"]) return 1;
        else if(!a["ok"] && b["ok"]) return -1;
        else return 0;
      });
      _saveData();

    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listar Tarefas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: tarefaController,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(
                          color: Colors.blueAccent,
                        )),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Add"),
                  textColor: Colors.white,
                  onPressed: addToDo,
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(onRefresh: refresh,
              child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: _toDoList.length,
              itemBuilder: buildItem,
            ),

            )
          ),
        ],
      ),
    );
  }



  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastPosition = index;
          _toDoList.removeAt(index);
          _saveData();
        });
        final snack = SnackBar(
          content: Text("Tarefa \"${_lastRemoved["title"]}\" foi removida!"),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _toDoList.insert(_lastPosition, _lastRemoved);
                _saveData();
              });
            },
          ),
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }

  Future<File> _getFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return File("${appDocDir.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
