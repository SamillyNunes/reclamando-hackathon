
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  String name;
  String email;
  String photoUrl;

  UserData.fromDocument(Future<DocumentSnapshot> doc){

    doc.then((docSnap){
      this.name=docSnap.data["name"];
      this.email=docSnap.data["email"];
      this.photoUrl=docSnap.data["photoUrl"];
    });


//    this.nome= doc..data["name"];
//    this.email=doc.data["email"];
//    this.photoUrl=doc.data["photoUrl"];
  }
}