import 'package:flutter/material.dart';
import 'package:mascot_app/HelatCard/HealtCard.dart';

final List cardsData = [
  {
    "petName": "Mila",
    "profilepic": "https://picsum.photos/250?image=9",
  },
  {
    "petName": "Hachi",
    "profilepic": "https://picsum.photos/250?image=9",
  },
];

class HomeHealt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: SingleChildScrollView ( 
        child: Column(
          children: [
            Row(
              children: [Column(children: createCards(cardsData))]
            ),
          ],
        )
      ),
    );
    return scaffold;
  }
}

List<Widget> createCards(final cardsData){
  List<Widget> cards = [];
  for(int i = 0; i < 2; i++){
    cards.add(HomeHealtCards(cardsData: cardsData[i]));
  }
  return cards;
}