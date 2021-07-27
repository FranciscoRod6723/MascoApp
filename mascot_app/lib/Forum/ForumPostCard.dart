import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/Funtions.dart';

import 'ForumPost.dart';

class HomeCards extends StatefulWidget {
  final cardsData;

  HomeCards({Key key, this.cardsData}) : super(key: key);

  @override
  PostCard createState() => PostCard();
}


class PostCard extends State<HomeCards>{
  @override
  Widget build(BuildContext context){
    var card = GestureDetector(
      onTap: (){
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>
          ForoPost(widget.cardsData)));
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
              2: FractionColumnWidth(.15)
            },
            children:[
              TableRow(
                children: [
                  Table(children: [ 
                    TableRow (
                      children: [ 
                        Container(
                          alignment: Alignment.topCenter,
                          height: 20,
                          child: Text(widget.cardsData['user'], style: TextStyle(fontSize:12),)
                        ) 
                      ]
                    ),
                    TableRow ( 
                      children: [ 
                        Container(
                          height: 80,
                          width: 80, 
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, 
                            image: DecorationImage( 
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(widget.cardsData['profilepic'])
                            ),
                          ),
                          child: null, 
                        ) 
                      ]
                    ),
                  ]),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text(widget.cardsData['title'], textAlign: TextAlign.center, style: TextStyle(fontSize: 16),)
                  ),
                  Table(children: [ 
                    TableRow (
                      children: [ 
                        Container(
                          height: 80,
                          alignment: Alignment.topRight,
                          child: Row(
                            children: createIcons(widget.cardsData['tipe'], widget.cardsData['check']),  
                          ) 
                        )
                      ]
                    ),
                    TableRow ( 
                      children: [
                        Container(
                          alignment: Alignment.topRight,
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
    return (card);
  }
}

