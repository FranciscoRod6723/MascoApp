import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mascot_app/DrownerMenu/ContactHome.dart';
import 'package:mascot_app/DrownerMenu/InfoComponent.dart';
import 'package:mascot_app/DrownerMenu/Ppolicies.dart';
import 'package:mascot_app/Forum/ForumPost.dart';
import 'package:mascot_app/Login/Loginmain.dart';
import 'package:mascot_app/mainApp.dart';

void main() {
  runApp(MyApp());
  //SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login',
      routes: {
        //login section
        'login': (context) => Login(),

        //home section
        'home': (context) => HomePage(),

        //drawner menu section
        'info': (context) => InfoContent(),
        'contac': (context) => ContacHome(),
        'ppolicies': (context) => Ppolicies(),

      },
    );
  }
}
