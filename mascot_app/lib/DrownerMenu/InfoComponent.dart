import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "About us"),
      ),
      body: Center(
        child: Text("About us"),
      )
    );
    return scaffold;
  }
}