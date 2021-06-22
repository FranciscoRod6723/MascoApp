import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class ForoPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "Post ..."),
      ),
      body: Center(
        child: Text("hola post"),
      )
    );
    return scaffold;
  }
}