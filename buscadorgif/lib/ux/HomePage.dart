
import 'dart:convert';

import 'package:buscadorgif/ux/openGig.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
String _seachr;
int offset = 0;


  Future<Map> getGifs() async {
  http.Response _response;

  if(_seachr == null || _seachr.isEmpty)
   _response = await http.get("https://api.giphy.com/v1/stickers/trending?api_key=CkLjswWA3nnzLGFWPpClGfUlayxfWUAr&limit=20&rating=G");

  else
   _response = await http.get("https://api.giphy.com/v1/stickers/search?api_key=CkLjswWA3nnzLGFWPpClGfUlayxfWUAr&q=$_seachr&limit=19&offset=$offset&rating=G&lang=en");

  return json.decode(_response.body);
}




class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise aqui",
                labelStyle: TextStyle(color: Colors.white, fontSize: 25.0),
               // border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
              textAlign: TextAlign.center,
              onSubmitted: (text){
                setState(() {

                  _seachr = text;
                  offset = 0;
                });
              },
            )

          ),
          Expanded(
            child: FutureBuilder(
                future: getGifs(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        height: 200.0,
                        width: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        )
                      );
                    default:
                      if(snapshot.hasError)return Container();
                      else return _createTable(context, snapshot);
                  }
                }
            ),
          ),
        ],
      ),
    );


  }

  int getCount(List data){
    print(data.length);
    if(_seachr == null || _seachr.isEmpty){
     return data.length;
    }
    else return data.length + 1;
  }

  Widget _createTable(BuildContext context, AsyncSnapshot snapshot ){
      return GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0
        ),
        itemCount: getCount(snapshot.data["data"]) ,
        itemBuilder: (context, index){
          if(_seachr == null || index < snapshot.data["data"].length){
              return GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover,),
                onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => openGif(snapshot.data["data"][index])));
                },
                onLongPress: (){
                  Share.share(snapshot.data["data"][index]["images"]["fixed_height"]["url"]);
                },
              );
              }
            else
              return Container(
                child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white, size: 70.0,),
                    Text("Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                       )
                          ],
                ),
                  onTap: (){
                  setState(() {
                    offset += 19;
                  });
                  },
                  )
              );

        });
        }




  @override
  void initState() {
    super.initState();
    getGifs();


  }





  }
