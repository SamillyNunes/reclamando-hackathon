import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/screens/principal_screen.dart';


class PrincipalTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reclamando"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("posts").getDocuments(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            } else {
              var cards = snapshot.data.documents.map(
                      (doc){
                    return PrincipalScreen(doc);
                  }
              ).toList();

              return ListView(
                children: cards,
              );
            }
          },

        ),
      )
    );




  }
}
