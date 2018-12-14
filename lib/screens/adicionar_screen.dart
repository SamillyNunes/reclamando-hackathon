import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon_app/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdicionarScreen extends StatefulWidget {
  @override
  _AdicionarScreenState createState() => _AdicionarScreenState();
}

class _AdicionarScreenState extends State<AdicionarScreen> {

  File image;
  final titleController = TextEditingController();
  final localController = TextEditingController();

  final googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar"),
        centerTitle: true,
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Título:"),
              ),
              TextFormField(
                controller: localController,
                decoration: InputDecoration(labelText: "Localidade:"),
              ),
            RaisedButton(
              child: Text("Tirar foto"),
              onPressed: () async{
                await ImagePicker.pickImage(source: ImageSource.camera).then(
                    (file){
                      if(file==null) return;
                      this.image=file;
                      popup();
                    }
                );

              },
            ),
              RaisedButton(
                onPressed: () async{
                  await UserModel.of(context).ensureloggedIn();

                  print(image);

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
                      "urgency":1
                    }
                  );
                },
                child: Text("Enviar"),
                color: Theme.of(context).primaryColor,
              )
            ],
          ),

        )
      ),
    );
  }

  Future<void> popup() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Foto tirada com sucesso!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Sua foto será anexada a publicação'),
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
