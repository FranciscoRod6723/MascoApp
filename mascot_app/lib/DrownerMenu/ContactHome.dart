import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

final List<dynamic> cardsData = [
  {
    'name': "appmascota2021@gmail.com",
    'icon': Icon(FontAwesomeIcons.mailBulk, size: 50)
  },
  {
    'name': "9998912912",
    'icon': Icon(Icons.phone, size: 50)
  },
  {
    'name': "MasctoApp",
    'icon': Icon(FontAwesomeIcons.facebook, size: 50)
  },
];

class ContacHome extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var card = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "Contac"),
      ),
      body:
        Column(
          children: createCards(cardsData, context)
        ) 
    );
    return (card);
  }
}

List<Widget> createCards(final cardsData, BuildContext context){
  List<Widget> cards = [];
  for(int i = 0; i < 3; i++){
    cards.add(
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width-20,
          height: 125,
          margin: EdgeInsets.fromLTRB(10,20,10,5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
              width: .5,
            ),
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.25),
                blurRadius: 3,
                offset: Offset(0, 6),
                spreadRadius: -1,
              )
            ]
          ),
          child: Table(
            columnWidths: {
              0: FractionColumnWidth(.25),
              1: FractionColumnWidth(.65),
            },
            children:[
              TableRow(
                children: [
                  Table(children: [ 
                    TableRow ( 
                      children: [ 
                        Container(
                          padding: EdgeInsets.all(25),
                          height: 100,
                          alignment: Alignment.center,
                          child: cardsData[i]['icon']
                        ) 
                      ]
                    ),
                  ]),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(cardsData[i]['name'], textAlign: TextAlign.start, style: TextStyle(fontSize: 16),)
                  ),
                ]
              ),
            ]
          )
        ),
      )
    );
  }
  return cards;
}