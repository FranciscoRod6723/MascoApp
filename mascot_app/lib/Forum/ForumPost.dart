import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';
import 'package:mascot_app/ExtraComponents/Funtions.dart';

class ForoPost extends StatelessWidget {
  final cardsData;
  const ForoPost(this.cardsData, {Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: cardsData['title']),
      ),
      //drawer: NavDrawer(),
      body: SingleChildScrollView (
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-20,
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
                  child: Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FractionColumnWidth(.20),
                          1: FractionColumnWidth(.65),
                          2: FractionColumnWidth(.15)
                        },
                        children: [
                          TableRow(children: [
                            Table(children: [ 
                              TableRow (
                                children: [ 
                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: 20,
                                    child: Text(cardsData['user'], style: TextStyle(fontSize:12),)
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
                                        image: NetworkImage(cardsData['profilepic'])
                                      ),
                                    ),
                                    child: null, 
                                  ) 
                                ]
                              ),
                            ]),
                            Text(""),
                            Table(children: [ 
                              TableRow (
                                children: [ 
                                  Container(
                                    height: 80,
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      children: createIcons(cardsData['tipe'], cardsData['check']),  
                                    ) 
                                  )
                                ]
                              ),
                            ]),
                          ]),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(cardsData['title'], style: TextStyle(fontSize: 18), textAlign: TextAlign.center,)
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(cardsData['description'], style: TextStyle(fontSize: 15), textAlign: TextAlign.left,)
                      ),
                      Row(
                        children: [
                          Column(
                            children: createImage(cardsData['image'], context)
                          )
                        ],
                      )
                    ]
                  ) 
                )
              ],
            )
          ],
        )
      )
    );
    return scaffold;
  }
}

List createImage(List imagen, BuildContext context){
  List<Widget> pics = [];
  for(int i = 0; i < imagen.length; i++){
    pics.add(
      Container(
        height: 280,
        width: MediaQuery.of(context).size.width-41, 
        decoration: BoxDecoration(
          image: DecorationImage( 
            fit: BoxFit.scaleDown,
            image: NetworkImage(imagen[i]),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: null, 
      )
    );
  }
  return pics;
} 