import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Model{

  final googleSignIn = GoogleSignIn();
  final auth = FirebaseAuth.instance; //apenas uma instancia o tempo todo
  FirebaseUser firebaseUser;

  Map<String,dynamic> userData;

  static UserModel of(BuildContext context) => //statico eh um metodo da classe e n do obj, essa funcao vai permitir chamar o scoped em qualquer canto
    ScopedModel.of<UserModel>(context);


  Future<Null> ensureloggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser; //pegando o usuario do google

    if (user == null) {
      user = await googleSignIn.signInSilently(); //logar silenciosamente, sem mostrar nada ao user
    }
    if (user == null) { //se demorar e ele nao logar
      user = await googleSignIn.signIn(); // de forma nao silenciosa
    }

    if (await auth.currentUser() == null) { //verificando se o user no firebase eh nulo
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser.authentication; //pega as credenciais do google
      await auth.signInWithGoogle(idToken: credentials.idToken, accessToken: credentials.accessToken); //passa as credenciais p o firebase



    }


  }



}