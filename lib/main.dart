import 'package:flutter/material.dart';
import 'package:hackathon_app/models/user_model.dart';
import 'package:hackathon_app/screens/adicionar_screen.dart';
import 'package:hackathon_app/screens/principal_screen.dart';
import 'package:hackathon_app/screens/tab_screen.dart';
import 'package:hackathon_app/tabs/principal_tab.dart';
import 'package:scoped_model/scoped_model.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),

  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Reclamando",
        theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Colors.redAccent
        ),
        debugShowCheckedModeBanner: false,
        home: TabScreen(),
      )
      );
  }
}



