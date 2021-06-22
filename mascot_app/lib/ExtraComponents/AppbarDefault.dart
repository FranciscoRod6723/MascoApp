import 'package:flutter/material.dart';

class AppBarDefault extends StatefulWidget {
  AppBarDefault({Key key, this.titleP}) : super(key: key);

  final String titleP;
  @override
  AppBarDefaultP createState() => AppBarDefaultP();
}

class AppBarDefaultP extends State<AppBarDefault>{
 @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.greenDefault,
        title: Text(
          widget.titleP,
          style: TextStyle( color: Colors.black ,fontSize: 24),
        ),
      );
  }
}