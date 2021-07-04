import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Widget> createIcons(String type, bool check){
  List<Widget> icons = [];

  if(type == "1"){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.userMd, size: 15)));
  }else if ((type == "2")){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.clinicMedical, size: 15)));
  }

  if(check){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.checkCircle, size: 15)));
  }
  return icons;
}