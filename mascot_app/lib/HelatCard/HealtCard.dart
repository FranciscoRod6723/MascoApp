import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascot_app/objects/cards.dart';
import 'HealtCartInfo.dart';

class HomeHealtCards extends StatelessWidget {
  final Cards cardData;
  final String idp;

  const HomeHealtCards({this.cardData, this.idp, Key key,}) : super(key: key);

  Widget build(BuildContext context) => GestureDetector(
      onTap: (){
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>
          HealtCardInfo(cardsData: cardData, idp: idp)));
      },
      child: Center(
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
              0: FractionColumnWidth(.15),
              1: FractionColumnWidth(.65),
              2: FractionColumnWidth(.11)
            },
            children:[
              TableRow(
                children: [
                  Table(children: [ 
                    TableRow ( 
                      children: [ 
                        Container(
                          padding: EdgeInsets.only(left:25),
                          height: 100,
                          alignment: Alignment.center,
                          child: Icon(FontAwesomeIcons.paw, size: 65)
                        ) 
                      ]
                    ),
                  ]),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(cardData.petName, textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)
                  ),
                  Table(children: [ 
                    TableRow ( 
                      children: [
                        Container(
                          height: 100,
                          alignment: Alignment.bottomRight,
                          child: Icon(Icons.double_arrow_rounded)
                        ) 
                      ]
                    ),
                  ]),
                ]
              ),
            ]
          )
        ),
      )
    );
}
