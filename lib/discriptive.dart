import 'dart:html' as ht;

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';

class Discriptive extends StatefulWidget {
  String folderTrack=ht.window.localStorage["subject"];
  // Discriptive(this.folderTrack);
  @override
  _DiscriptiveState createState() => _DiscriptiveState();
}

class _DiscriptiveState extends State<Discriptive> {
  
  fb.Database root;
  
  fb.DatabaseReference subject;
  
  String _question;
  String _answer;

  GlobalKey<FormState> formKey;
  @override
  void initState(){
    super.initState();
    root=fb.database();
    subject=root.ref(widget.folderTrack);
    // subject.orderByKey().startAt('what').endAt('what' + 
    // '\uf8ff')..once('value').then((snap)=>{
    //             print(snap.snapshot.val().toString())
    //         });
    formKey=GlobalKey<FormState>();
  }

  
  @override
  Widget build(BuildContext context) {
    ScrollController controller=new ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.assessment),
        title: Text(widget.folderTrack,textScaleFactor: 1.3,),),
      body:Row(
        children:<Widget>[
          Container(
            width: MediaQuery.of(context).size.width >500
                  ?MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width/4)
                  :MediaQuery.of(context).size.width,
            child:StreamBuilder(
              stream: subject.onValue.asBroadcastStream(),
              builder:(context,snap){
                if(snap.hasData && !snap.hasError && snap.data.snapshot.val()!=null){
                  fb.QueryEvent qe=snap.data;
                  fb.DataSnapshot snapshot = qe.snapshot;
                  List<Map> data=[];
                  snapshot.forEach((childSnap){
                    Map maped=Map.from(childSnap.exportVal());
                    data.add(maped);
                  });
                  return DraggableScrollbar.rrect(
                      alwaysVisibleScrollThumb: true,
                      backgroundColor: Colors.grey,
                      heightScrollThumb: MediaQuery.of(context).size.height/4,
                      controller: controller,
                      child: ListView.builder(
                        controller: controller,
                        itemCount: data.length,
                        itemBuilder:(context,i){
                          String question=data[i].values.toList()[1];
                          String answer=data[i].values.toList()[0];
                          return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color:Color.fromRGBO(52, 58, 64, 1.0),
                            elevation:3.0,
                            child:Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Question",textScaleFactor: 1.6,style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:BorderRadius.circular(10.0)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SelectableText(question,textScaleFactor: 1.6,),
                                  )),
                                  SizedBox(height:8.0),
                                  Text("Answer",textScaleFactor: 1.6,style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold)),
                                  Stack(
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:BorderRadius.circular(10.0)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top:15.0,
                                            bottom: 8.0,
                                            left:5.0,
                                            right: 5.0
                                          ),
                                          child: SelectableText(answer,textScaleFactor: 1.6,),
                                      )),
                                      Positioned(
                                        top: 0.0,
                                        right: 0.0,
                                        child: Container(
                                        height: 20.0,
                                        width: 50.0,
                                        child: FlatButton(
                                          splashColor: Colors.deepOrange,
                                          highlightColor: Colors.deepOrange,
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: (){
                                            final textarea =new ht.TextAreaElement();
                                            ht.document.body.append(textarea);
                                            textarea.style.border = '0';
                                            textarea.style.margin = '0';
                                            textarea.style.padding = '0';
                                            textarea.style.opacity = '0';
                                            textarea.style.position = 'absolute';
                                            textarea.readOnly = true;
                                            textarea.value = answer;
                                            textarea.select();
                                            ht.document.execCommand('copy');
                                            textarea.remove();
                                          }, child: Text("Copy",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500),),color: Colors.blue,)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          )
                        );
                      } 
                    ),
                  );
                }else{
                  return Center(child:CircularProgressIndicator()); 
                }
              } 
            ), 
          ),
          MediaQuery.of(context).size.width >500?Container(
            width:MediaQuery.of(context).size.width/4,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(15.0)
              ),
              elevation: 8.0,
              color: Color.fromRGBO(227, 238, 241, 1.0),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  child: Column(
                    children:<Widget>[
                      SizedBox(height: 8.0,),
                      Container(
                        margin: EdgeInsets.only(bottom:3.0),
                        child: Text("Add Question",textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(height: 15.0,),
                      Form(
                        key: formKey,
                        child: Column(
                          children:<Widget>[
                            Container(
                              child: TextFormField(
                                onChanged: (String value){
                                    _question=value;
                                },
                                validator: (String value){
                                  if(value.isEmpty){
                                    return "Empty !";
                                  }else{
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: "Question ?",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                  )
                                )
                              ),
                            ),
                            SizedBox(height: 8.0,),
                            Container(
                              constraints: new BoxConstraints(
                                maxHeight:MediaQuery.of(context).size.height/2, 
                              ),
                              margin: EdgeInsets.only(top:20.0,bottom:20),
                              child:TextFormField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (String value){
                                      _answer=value;
                                  },
                                  validator: (String value){
                                    if(value.isEmpty){
                                      return "Empty !";
                                    }else{
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Answer !",
                                    contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0)
                                    )
                                  )
                                ),
                              ),
                            SizedBox(height: 15.0,),
                            RaisedButton(
                              color: Color.fromRGBO(52, 58, 64, 1.0),
                              onPressed: (){
                                if(formKey.currentState.validate()){
                                  setState(() {
                                    subject.push().set({
                                      "question":_question.toString(),
                                      "answer":_answer.toString()
                                    });
                                    formKey=GlobalKey<FormState>();
                                  });
                                }
                              },
                              child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                            )
                          ]
                        )
                      )
                    ]
                  ),
                ),
              ),
            ),
          ):Container(),
        ]
      )
    );
  }
}