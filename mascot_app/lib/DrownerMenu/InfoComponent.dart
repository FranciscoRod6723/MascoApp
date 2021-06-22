import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "Infomación"),
      ),
      body: Center(
        child: Text("hola info"),
      )
    );
    return scaffold;
  }
}