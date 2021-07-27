import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';

class Add extends StatefulWidget{
  Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add>{
  String text;
  final PostService _postService = PostService();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenDefault,
        title: Text("Create post", style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            onPressed: () async {
              _postService.savePost(text);
              Navigator.pop(context);
            }, 
            child: Text("Post")
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: TextFormField(
            onChanged: (val) {
              setState(() {
                text = val;
              });}
          ),
        )
      ),
    );
  }
}