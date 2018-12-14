import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/models/user_model.dart';

class PrincipalScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  PrincipalScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage("https://image.freepik.com/icones-gratis/perfil-macho-utilizador-sombra_318-40244.jpg"),
                    ),
                    SizedBox(width: 10.0,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          snapshot.data["title"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0
                          ),
                        ),
                        Text(
                          "Teste",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 10.0
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(),
              SizedBox(height: 10.0,),
              SizedBox(
                height: 300.0,
                width: 250.0,
                child: Image.network(snapshot.data["imgUrl"]),
              ),
//              SizedBox(height: 10.0,),
              SizedBox(height: 20.0,),
              Text(snapshot.data["local"]),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Urgência:"),
                  SizedBox(width: 20.0,),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: RaisedButton(
                      onPressed: (){},
                      child: Text("-",textAlign: TextAlign.center,),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  Text(snapshot.data["urgency"].toString()),
                  SizedBox(width: 20.0,),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: RaisedButton(
                      onPressed: (){
                      },
                      child: Text("+",textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,)

            ],
          ),

    );
  }
}
