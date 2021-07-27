import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/HelatCard/AddHealtCard.dart';
import 'package:mascot_app/HelatCard/listCards.dart';
import 'package:provider/provider.dart';

class HomeHealt extends StatelessWidget {
  @override  
  Widget build(BuildContext context) {
    HCServices _hcServices = HCServices();
    var scaffold = FutureProvider.value(
      value: _hcServices.getCards(),
      child:Scaffold(
        body: ListCards(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddHealtCard())
          ),
        )
      )
    );
    return scaffold;
  }
}