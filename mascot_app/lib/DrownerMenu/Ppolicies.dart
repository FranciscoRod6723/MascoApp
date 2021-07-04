import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class Ppolicies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "Privacy policies"),
      ),
      body: Center(
        child: Text("Privacy policies"),
      )
    );
    return scaffold;
  }
}