import 'dart:html' as ht;

import 'package:flutter/material.dart';
import "Selection.dart";

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<String> subjects=[
    "CNS",
    "CG",
    "SS&CD",
    "OS",
    "Python",
    "DM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 58, 64, 1.0),
      appBar: AppBar(
        leading: Icon(Icons.assessment),
        title: Text("PORTAL",textScaleFactor: 1.3,),),
      body: Container(
        margin: EdgeInsets.only(
          top:MediaQuery.of(context).size.height/8,
          left:MediaQuery.of(context).size.width/4,
          right:MediaQuery.of(context).size.width/4,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child:GridView.builder(
                itemCount: subjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ((MediaQuery.of(context).size.width/2)/116).round(),
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 2.0
                ), 
                itemBuilder: (context,i){
                  return GestureDetector(
                      onTap: (){
                        ht.window.localStorage["subject"]=subjects[i];
                        Navigator.of(context).pushNamed("/selector");
                      },
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container( 
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.folder,color: Color.fromRGBO(227, 238, 241, 1.0),size: 100.0,),
                            Text(subjects[i]+" Folder",textScaleFactor: 1.3,style: TextStyle(color:Colors.white),)
                          ],
                        ),
                    ),
                      ),
                  );
                },
              )
            ),
            Text.rich(
              TextSpan(
                text:'With Love From ',
                style: TextStyle(color: Colors.white),
                children: <TextSpan>[
                  TextSpan(
                    text: '@bunny1999',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blue
                  ),
                )
              ])
            )
          ],
        )  
      ),
    );
  }
}