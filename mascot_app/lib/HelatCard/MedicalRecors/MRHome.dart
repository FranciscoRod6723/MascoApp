import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/deworming/DewornHome.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/medicalVisits/MedicalVisitHome.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/VaccinationsHome.dart';

class MRHome extends StatefulWidget {
  final String idp;
  const MRHome({this.idp, Key key }) : super(key: key);

  @override
  _MRHomeState createState() => _MRHomeState();
}

class _MRHomeState extends State<MRHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenDefault,
        leading: CloseButton(color: Colors.black),
        title: Text("Medical Records"),
      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
          mrMenu(context, "Vaccinations", Icon(FontAwesomeIcons.syringe, size: 65),1, widget.idp ),
          SizedBox(height: 50,),
          mrMenu(context,  "Deworming", Icon(FontAwesomeIcons.dog, size: 65),2, widget.idp ),
          SizedBox(height: 50,),
          mrMenu(context,  "Medical visit", Icon(FontAwesomeIcons.hospital, size: 65),3, widget.idp)
        ]
      ),
    );
  }
}

Widget mrMenu(BuildContext context, text, icon, type, idp) => GestureDetector(
   onTap: (){
     if(type == 1){
       Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>
          VaccHome(idp)));
     }
     if(type == 2){
       Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>
          DewornmHome(idp)));
     }
     if(type == 3){
       Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>
          MedicalVHome(idp)));
     }
  },
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
                    child: icon
                  ) 
                ]
              ),
            ]),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)
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
  )
);