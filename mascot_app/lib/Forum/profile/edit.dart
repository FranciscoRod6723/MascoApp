import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot_app/ExtraComponents/UserServices.dart';
import 'package:mascot_app/objects/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserServices _userServices = UserServices();
  File _profileImage;
  File _bannerImage;
  final picker = ImagePicker();
  String name = '';

  Future getImage(int type) async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null && type == 0){
        _profileImage = File(pickedFile.path);
      }

      if(pickedFile != null && type == 1){
        _bannerImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(onPressed: () async {
            await _userServices.updateProfile(_bannerImage, _profileImage, name);
            Navigator.pop(context);
          }, 
          child: Text('Save'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          child: 
          Column(
            children: [
              Row(
                children:[
                  Text('Profile image'),
                  FlatButton(
                    onPressed: () => getImage(0), 
                    child: _profileImage == null ?
                    Icon(Icons.person) 
                    : Image.file(_profileImage, height: 100)
                  )
                ]
              ),
              Row(
                children:[
                  Text('Banner image'),
                  FlatButton(
                    onPressed: () => getImage(1), 
                    child: _bannerImage == null ?
                    Icon(Icons.person) 
                    : Image.file(_bannerImage, height: 100)
                  ),
                ]
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "nickName",
                  border: UnderlineInputBorder(),
                  hintText: "nickName",
                ),
                onChanged: (val) => setState((){
                  name = val;
                })
              )
            ],
          )
        ),
      ),
    );
  }
}