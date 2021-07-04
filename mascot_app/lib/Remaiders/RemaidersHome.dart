import 'package:flutter/material.dart';
import 'package:mascot_app/Remaiders/AddRemainder.dart';
import 'package:mascot_app/Remaiders/RemainsdersCalendar.dart';

class Remainders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: HomeRemainders(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.greenDefault,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddRemainders())
        ),
      ),
    );
    return scaffold;
  }
}