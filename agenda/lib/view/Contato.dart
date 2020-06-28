import 'dart:io';

import 'package:agenda/controllers/contact_helper.dart';
import 'package:agenda/view/Home.dart';
import 'package:flutter/material.dart';

class Contato extends StatefulWidget {
   Contact contact;

   Contato({this.contact});

  @override
  _ContatoState createState() => _ContatoState();
}

class _ContatoState extends State<Contato> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ContactHelper helper = ContactHelper();

  Contact _editContact;
  bool _useEdited = false;

  @override
  void initState() {
    super.initState();

    if(widget.contact == null){
      _editContact = Contact();
    }
    else{
      _editContact = Contact.fromMap(widget.contact.toMap());
      nameController.text = _editContact.name;
      emailController.text = _editContact.email;
      phoneController.text = _editContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child:Scaffold(
          appBar: AppBar(
            title: Text(_editContact.name ?? "Novo Contato"),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 140.0,
                        height: 140.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: _editContact.img != null ?
                                FileImage(File(_editContact.img)) :
                                AssetImage("images/pessoa.png")

                            )
                        ),
                      ),
                    ),
                    /* Icon(Icons.account_circle, size: 150.0),*/
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                      onChanged: (text){
                        _useEdited = true;
                        setState(() {
                          _editContact.name = text;
                        });
                      },
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      onChanged: (text){
                        _useEdited = true;
                      },
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                      ),
                      onChanged: (text){
                        _useEdited = true;
                      },

                    ),
                  ],
                ),)
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
            onPressed: (){
              if(_editContact.name.isNotEmpty && _editContact.name != null){
                Navigator.pop(context)
              }
              }
              ,)
          ),

        );
  }

  Future<bool> _requestPop(){
    if(_useEdited == true){
      showDialog(context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Descartar alterações?"),
          content: Text("se sair as alteterações serão perdidas!"),
          actions: <Widget>[
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Cancelar")),
            FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Sim")),

          ],
        );
      }
      );
      Future.value(false);
    }
    else return Future.value(true);
  }


}
