import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/datas/user_data.dart';
import 'package:hackathon_app/models/user_model.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PrincipalScreen extends StatefulWidget {

  final DocumentSnapshot snapshot;

  PrincipalScreen(this.snapshot);


  @override
  _PrincipalScreenState createState() => _PrincipalScreenState(snapshot);
}

class _PrincipalScreenState extends State<PrincipalScreen> {

  final DocumentSnapshot snapshot;

  int urgency;
  _PrincipalScreenState(this.snapshot){
    this.urgency=snapshot.data["urgency"];
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      color: chooseColor(urgency),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data["user"]["photoUrl"]),
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
                      snapshot.data["user"]["name"],
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
          Image.network(
            snapshot.data["imgUrl"],
            fit: BoxFit.contain,
            width: 300.0,
            height: 250.0,

          ),
//              SizedBox(height: 10.0,),
          SizedBox(height: 20.0,),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.location_on,size: 40.0,color: Colors.red,),
                Text(snapshot.data["local"].toString().toUpperCase(),style: TextStyle(fontSize: 15.0),),
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Urgência:",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 20.0,),
              SizedBox(
                height: 30.0,
                width: 30.0,
                child: RaisedButton(
                  onPressed: () async{
                    dynamic resp = await CloudFunctions.instance.call(
                        functionName: "decreaseUrgencyCall",
                        parameters: {
                          "postId": snapshot.documentID,
                        }
                    );

                    setState(() {
                      urgency--;
                    });
                  },
                  child: Text("-",textAlign: TextAlign.center,),
                ),
              ),
              SizedBox(width: 20.0,),
              Text(
                urgency.toString(),

              ),
              SizedBox(width: 20.0,),
              SizedBox(
                height: 30.0,
                width: 30.0,
                child: RaisedButton(
                  onPressed: () async {
                    dynamic resp = await CloudFunctions.instance.call(
                        functionName: "increaseUrgencyCall",
                        parameters: {
                          "postId": snapshot.documentID,
                        }
                    );

                    setState(() {
                      urgency+=1;
                    });

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

  Color chooseColor(int urgency){
    if(urgency<20){
      return Colors.yellow;
    } else if(urgency>=20 && urgency<50){
      return Colors.orange;
    } else {
      return Colors.redAccent;
    }

//    return Colors.white;
  }
}
