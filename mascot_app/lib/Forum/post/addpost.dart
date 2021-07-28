import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';

class Add extends StatefulWidget{
  Add({Key key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add>{
  String text;
  final PostService _postService = PostService();
  File _profileImage;
  final picker = ImagePicker();

  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        _profileImage = File(pickedFile.path);
      }
    });
  }

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
              _postService.savePost(text, _profileImage);
              Navigator.pop(context);
            }, 
            child: Text("Post")
          )
        ],
      ),
      body: Column(
        children:[
          Container(
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children:[
                Text('Add image'),
                FlatButton(
                  onPressed: () => getImage(), 
                  child: _profileImage == null ?
                    Icon(Icons.person) 
                  : Image.file(_profileImage, height: 125)
                )
              ]
            ),
          )
        ]
      )
    );
  }
}