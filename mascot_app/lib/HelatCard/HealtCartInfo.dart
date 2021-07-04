import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class HealtCardInfo extends StatelessWidget {
  final cardsData;
  const HealtCardInfo(this.cardsData, {Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: cardsData['petName']),
      ),
      body: Center(
        child: Text("Info"),
      )
    );
    return scaffold;
  }
}
