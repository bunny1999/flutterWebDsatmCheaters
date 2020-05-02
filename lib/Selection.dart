import 'package:dsatm/discriptive.dart';
import 'package:flutter/material.dart';
import 'dart:html' as ht;
import 'package:firebase/firebase.dart' as fb;

import 'package:url_launcher/url_launcher.dart';

class Selection extends StatefulWidget {
  String folderTrack=ht.window.localStorage["subject"];
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  // Map<String,String> mcqLinks={
  //   "CNS":"https://drive.google.com/file/d/1_Wbt6JZ3_J9lsNlOJVUUDqW6ZisfLGqw/view?usp=sharing",
  //   "CG":"https://drive.google.com/file/d/190A_zikKlrdAI64iR-tZC373ezWrr8Zn/view?usp=sharing",
  //   "SS&CD":"https://drive.google.com/file/d/1B9kc0k3kWWJT6PIZMcnF3WPvSe3QBOww/view?usp=sharings",
  //   "OS":"https://drive.google.com/file/d/1ZqRyOUqc9tWGnhyLcP-jtcBEisvabSEB/view?usp=sharing",
  //   "Python":"https://drive.google.com/file/d/1SmLvFGDK4g6pfHNlp7kLe-Pm4XBagJYi/view?usp=sharing",
  //   "DM":"https://drive.google.com/file/d/1Tto2lmx9mhimcrR3ayKVdEj_LT53NoEL/view?usp=sharing"
  // };

  // Map<String,String> assignmentLink={
  //   "CNS":"https://www.dropbox.com/s/2f2of65p664yhs9/CNS%202.pdf?dl=0",
  //   "CG":"https://www.dropbox.com/s/mawvzlm5pq5xpe2/CG%202.pdf?dl=0",
  //   "SS&CD":"https://www.dropbox.com/s/tbtxpgfxo5dn4ui/SSCD%202.pdf?dl=0",
  //   "OS":"https://www.dropbox.com/s/7jf9w2t43ozu2ug/OS%202.pdf?dl=0",
  //   "Python":"",
  //   "DM":"https://www.dropbox.com/s/hazfg7uia5sz4y0/DM%202.pdf?dl=0"
  // };

  fb.Database root;
  fb.DatabaseReference mcq;
  fb.DatabaseReference assignments;
  String mcqURl="";
  String assignmentURl="";
  bool mcqLoaded=false;
  bool assLoaded=false;
  bool _isLoading;

  @override
  void initState(){
    super.initState();
    root=fb.database();
    mcq=root.ref("PDF/MCQ");
    assignments=root.ref("PDF/Assignment");
    _isLoading=false;
    mcq.child(widget.folderTrack).once('value').then((snap){
      setState(() {
        mcqURl=snap.snapshot.val();
        mcqLoaded=true;
        if(mcqLoaded && assLoaded){
          setState(() {
            _isLoading=true;
          });
        }
      });
    });
    assignments.child(widget.folderTrack).once('value').then((snap){
      setState(() {
        assignmentURl=snap.snapshot.val();
        assLoaded=true;
        if(mcqLoaded && assLoaded){
          setState(() {
            _isLoading=true;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(52, 58, 64, 1.0),
      appBar: AppBar(
        leading: Icon(Icons.assessment),
        title: Text(widget.folderTrack,textScaleFactor: 1.3,),),
      body:!_isLoading 
      ?Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
      :Container(
        margin: EdgeInsets.only(
          top:MediaQuery.of(context).size.height/8,
          left:MediaQuery.of(context).size.width/4,
          right:MediaQuery.of(context).size.width/4,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child:GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ((MediaQuery.of(context).size.width/2)/116).round(),
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 2.0
                ), 
                children: <Widget>[
                  FittedBox(
                    fit:BoxFit.fitWidth,
                      child: GestureDetector(
                        onTap: () async{
                          if(await canLaunch(mcqURl)){
                              await launch(mcqURl);
                          }
                        },
                        child: Container(        
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.picture_as_pdf,color: Color.fromRGBO(227, 238, 241, 1.0),size: 100.0,),
                            Text(widget.folderTrack+" MCQ",textScaleFactor: 1.5,style: TextStyle(color:Colors.white,),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  assignmentURl!=""?FittedBox(
                    fit:BoxFit.fitWidth,
                      child: GestureDetector(
                        onTap: () async{
                          if(await canLaunch(assignmentURl)){
                            await launch(assignmentURl);
                          }
                        },
                        child: Container(        
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.picture_as_pdf,color: Color.fromRGBO(227, 238, 241, 1.0),size: 100.0,),
                            Text(widget.folderTrack+" Assignment 2",textScaleFactor: 1.5,style: TextStyle(color:Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ):Container(),
                  FittedBox(
                    fit:BoxFit.fitWidth,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context,'/disciptive');
                        },
                        child: Container(        
                        margin: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.folder,color: Color.fromRGBO(227, 238, 241, 1.0),size: 100.0,),
                            Text(widget.folderTrack+" Discriptive\n(REALTIME CHAT)",textScaleFactor: 1.6,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold ),)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        )  
      ),
    );
  }
}