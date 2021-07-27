import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/deworming/AddDewormingDialog.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/deworming/DewornmList.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/AddVacineDialog.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/VaccineList.dart';
import 'package:mascot_app/objects/dewornm.dart';
import 'package:mascot_app/objects/vaccinations.dart';
import 'package:mascot_app/provider/dewornm_provider.dart';
import 'package:mascot_app/provider/vaccine_provider.dart';
import 'package:provider/provider.dart';

class DewornmHome extends StatefulWidget {
  final String id;
  DewornmHome(this.id);

  @override
  DewornmState createState() => DewornmState();
}

class DewornmState extends State<DewornmHome> {

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MRServices _mrServices = MRServices();
    
    List<Dewornm> dewornm = Provider.of<DewornmProvider>(context).deworn;
    var scaffold = FutureProvider.value(
      value: _mrServices.getDewornm(widget.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenDefault,
          leading: CloseButton(color: Colors.black),
          title: Text('Dewornming'),
        ),
        body: ListDewornm(dewornm,  widget.id),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => showDialog(context: context, builder: (BuildContext context) => AddDewornmDialog(widget.id, null), barrierDismissible: false)
        ),
      )
    );
    return scaffold;
  }
}