import 'package:flutter/material.dart';
import 'package:mascot_app/Forum/ForumPostCard.dart';

final List cardsData = [
  {
    "user": "paco67",
    "profilepic": "https://picsum.photos/250?image=9",
    "title": "¿Cual es su mascota favorita?",
    "description": "En lo personal a mi me gusta...",
    "image": [
      "https://picsum.photos/250?image=9",
      "https://picsum.photos/250?image=9",
    ],
    "tipe": "1",
    "check": true,
  },
  {
    "user": "angelOsuna",
    "profilepic": "https://picsum.photos/250?image=9",
    "title": "La comida favorita de los gatos",
    "description": "A los gatos les gusta mas la comida..",
    "image": [
      "https://picsum.photos/250?image=9",
      "https://picsum.photos/250?image=9",
    ],
    "tipe": "2",
    "check": true,
  },
  {
    "user": "AliceMedina",
    "profilepic": "https://picsum.photos/250?image=9",
    "title": "Como sacar a pasear a tu perro",
    "description": "Para que un perro salga a pasear...",
    "image": [
      "https://picsum.photos/250?image=9",
      "https://picsum.photos/250?image=9",
    ],
    "tipe": "1",
    "check": true,
  }
];

class HomeForum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: SingleChildScrollView ( 
        child: Column(
          children: [
            Row(
              children:[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.greenDefault,
                  ),
                  child: Row(
                    children: [
                      VerticalDivider(indent:10, endIndent: 10, color: Colors.black, thickness: .5, width: 35,),
                      Text("Top", style: TextStyle(fontSize:20),),
                      VerticalDivider(indent:10, endIndent: 10, color: Colors.black, thickness: .5, width: 35,),
                      Text("Vets", style: TextStyle(fontSize:20),),
                      VerticalDivider(indent:10, endIndent: 10, color: Colors.black, thickness: .5, width: 35,),
                      Text("Veterinaty", style: TextStyle(fontSize:20),),
                      VerticalDivider(indent:10, endIndent: 10, color: Colors.black, thickness: .5, width: 35,),
                      Text("People", style: TextStyle(fontSize:20),),
                      VerticalDivider(indent:10, endIndent: 10, color: Colors.black, thickness: .5, width: 35,),
                    ],
                  )
                )
              ]
            ),
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
  for(int i = 0; i < 3; i++){
    cards.add(HomeCards(cardsData: cardsData[i]));
  }
  return cards;
}