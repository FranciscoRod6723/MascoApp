import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/HelatCard/AddHealtCard.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/MRHome.dart';
import 'package:mascot_app/HelatCard/Notes/HomeNotes.dart';
import 'package:mascot_app/mainApp.dart';
import 'package:mascot_app/objects/cards.dart';
import 'package:mascot_app/provider/cards_provider.dart';
import 'package:mascot_app/utils/utilsCards.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

HCServices _hcServices = HCServices();

class HealtCardInfo extends StatelessWidget {
  final Cards cardsData;
  final String idp;
  const HealtCardInfo({this.cardsData, this.idp, Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.greenDefault,
      leading: CloseButton(color: Colors.black),
      actions: buildViewingActions(context,cardsData),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width-41, 
              decoration: BoxDecoration(
                image: DecorationImage( 
                  fit: BoxFit.scaleDown,
                  image: NetworkImage("https://picsum.photos/250?image=9"),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: null, 
            )
          ],),
          SizedBox(height:20),
          Row(children: [Text(cardsData.petName, style: TextStyle(fontSize: 26),)],),
          SizedBox(height:10),
          Row(children: [Text(UtilsCards.birthdayDateTime(cardsData.birthday.toDate()), style: TextStyle(fontSize: 16))],),
          Divider(thickness: 2, color: Colors.greenDefault,),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(cardsData.specie +" " + cardsData.breed + " - " + cardsData.sex, style: TextStyle(fontSize: 16))],),
          Divider(thickness: 2, color: Colors.greenDefault,),
          Container(
            padding: EdgeInsets.all(10),
            child: Table(
              columnWidths: {
                0: FractionColumnWidth(.34),
                1: FractionColumnWidth(.33),
                2: FractionColumnWidth(.33),
              },
              children:[
                TableRow(
                  children:[
                    GestureDetector(
                      onTap: () =>{
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) =>
                          MRHome(idp: idp)))
                      },
                      child: Column(
                        children: [Icon(FontAwesomeIcons.notesMedical, size: 55), Text("Medical record", style: TextStyle(fontSize:16, height: 2), maxLines: 2,)]
                      ),
                    ),
                    Column(
                      children: [Icon(FontAwesomeIcons.bell, size: 55), Text("Remainders", style: TextStyle(fontSize:16, height: 2), maxLines: 2,)]
                    ),
                    GestureDetector(
                      onTap: () =>{
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) =>
                          NoteHome(cardsData.id)))
                      },
                      child: Column(
                        children: [Icon(FontAwesomeIcons.stickyNote, size: 55,), Text("Notes", style: TextStyle(fontSize:16, height: 2), maxLines: 2,)]
                      ),
                    )
                  ]
                )
              ]
            )
          ),
          Divider(thickness: 2, color: Colors.greenDefault,),
          SizedBox(height:20),
          buildData("Vaterinarian", cardsData.veterinarian),
          SizedBox(height:20),
          buildData("Pet Owner", "Francisco Rodriguez"),
          SizedBox(height:20),
          buildData("Weight", cardsData.weight),
          SizedBox(height:20),
          buildData("Color", cardsData.color),
          SizedBox(height:20),
          buildData("Microchip id", cardsData.mchipId),
        ],
      ),
    )
  );

  Widget buildData(String title, String data) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(title, style: TextStyle(fontSize:18),)
        ),
        Expanded(
          child: Text(data, style: TextStyle(fontSize:18),)
        )
      ],
    );
  } 

  List<Widget> buildViewingActions(BuildContext context, Cards cards) => [
    IconButton(
      icon: Icon(Icons.edit, color: Colors.black),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AddHealtCard(card: cards)
        )
      ),
    ),
    IconButton(
      icon: Icon(Icons.delete, color: Colors.black),
      onPressed: () {
        _hcServices.deletedCard(cardsData);

        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage())
        );
      }
    ),
  ];
}
