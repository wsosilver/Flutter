import 'dart:io';

import 'package:agenda/controllers/contact_helper.dart';
import 'package:agenda/view/Contato.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {
  ContactHelper helper = ContactHelper();
  List<Contact> contacts = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      _getAllContacts();
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.more_vert)
        ],
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: contacts.length,
          itemBuilder: (context, index){
            return contextCard(context, index);
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showContact,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),



    );


  }

  Widget contextCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Row(
            children: <Widget>[

              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                        FileImage(File(contacts[index].img)) :
                        AssetImage("images/pessoa.png")

                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? "",
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),

                    ),
                    Text(contacts[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),

                    ),
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),

                    )


                  ],
                ),
              )

            ],

          ),
        ),
      ),
        onTap:(){
        _showOptions(context, index);
        },

    );


  }
  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlatButton(
                        child: Text("Ligar",
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: null
                    ),
                    FlatButton(
                        child: Text("Editar",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: (){
                          _showContact(contact: contacts[index]);
                        }
                    ),
                    FlatButton(
                        child: Text("Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: (){
                          helper.deleteContact(contacts[index].id);
                          setState(() {
                            contacts.removeAt(index);
                            Navigator.pop(context);
                          });
                        }
                    )
                  ],
                ),
              );
            }
          );
        });
  }

  void _showContact({Contact contact}) async{
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => Contato(contact: contact,)));
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(contact);
      }
      else{
        await helper.saveContact(contact);
      }
      _getAllContacts();
    }

  }

    _getAllContacts(){
      helper.getAllContacts().then((list) => {
        setState((){
          contacts = list;
        })
      });
    }
}
