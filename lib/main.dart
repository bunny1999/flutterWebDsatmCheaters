// import 'package:dsatm/discriptive.dart';
import 'package:dsatm/Selection.dart';
import 'package:dsatm/discriptive.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'HomePage.dart';

void main(){ 
  //TESTING
  // assert((){
  //     fb.initializeApp(
  //       apiKey: "AIzaSyBhYpYClaNpwr-yPlZu8qZH3NAmuQ2V7Uo",
  //       authDomain: "dsatmcheaters.firebaseapp.com",
  //       databaseURL: "https://dsatmcheaters.firebaseio.com",
  //       projectId: "dsatmcheaters",
  //       storageBucket: "dsatmcheaters.appspot.com",
  //       messagingSenderId: "814922170975",
  //       appId: "1:814922170975:web:d4fc88d8c60ca622c811ea",
  //       measurementId: "G-8630TL8DP2"
  //     );
  //     return true;
  //   }());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DSATM Cheaters",
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
        '/selector':(context)=>Selection(),
        '/disciptive':(context)=>Discriptive()
      },
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontSizeFactor: 0.8,
        ),
        primaryColor: Color.fromRGBO(52, 58, 64, 1.0),accentColor: Color.fromRGBO(52, 58, 64, 1.0)),
      // home: HomePage(),
    );
  }
}