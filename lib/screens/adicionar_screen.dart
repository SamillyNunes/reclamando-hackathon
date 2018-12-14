import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_app/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'principal_screen.dart';

class AdicionarScreen extends StatefulWidget {
  @override
  _AdicionarScreenState createState() => _AdicionarScreenState();
}

class _AdicionarScreenState extends State<AdicionarScreen> {

  File image;
  final titleController = TextEditingController();
  final localController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar"),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: true,
      body: Form(
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
//              SizedBox(height: 50.0,),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título:"),
              ),
              TextField(
                controller: localController,
                decoration: InputDecoration(labelText: "Localidade:"),
              ),
            RaisedButton(
              child: Text("Tirar foto"),
              onPressed: () async{
                await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 1080.0,maxWidth:1080.0 ).then(
                    (file){
                      if(file==null) return;
                      this.image=file;
                      popup("Sua foto foi tirada com sucesso!","Ela será anexada a publicação. :) ");
                    }
                ).catchError((e)=>print(e));

              },
            ),
              RaisedButton(
                onPressed: () async{
                  await UserModel.of(context).ensureloggedIn();

                  StorageUploadTask task = FirebaseStorage.instance.ref().child(DateTime.now().millisecondsSinceEpoch.toString()).putFile(image);

                  String downloadUrl;

                  await task.onComplete.then((s) async{
                    downloadUrl = await s.ref.getDownloadURL();
                  });

                  Firestore.instance.collection("posts").document().setData(
                    {
                      "title":titleController.text,
                      "local":localController.text,
                      "imgUrl":downloadUrl,
                      "date":DateTime.now().toString(),
                      "urgency":1,
                      "user":UserModel.of(context).userData
                    }
                  );

                  popup("Sua publicação foi enviada com sucesso", "Vá para a página principal e poderá vê-la");

                },
                child: Text("Enviar"),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),

      ),
    );
  }

  Future<void> popup(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
