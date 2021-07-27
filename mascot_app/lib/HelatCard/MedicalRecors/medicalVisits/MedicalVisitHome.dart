import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/medicalVisits/AddMedicalVDialog.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/medicalVisits/MedicalVList.dart';
import 'package:mascot_app/objects/medicalV.dart';
import 'package:mascot_app/provider/medicalV_provider.dart';
import 'package:provider/provider.dart';

class MedicalVHome extends StatefulWidget {
  final String id;
  MedicalVHome(this.id);

  @override
  MediclaVisit createState() => MediclaVisit();
}

class MediclaVisit extends State<MedicalVHome> {

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MRServices _mrServices = MRServices();
    
    List<MedicalV> mediclaV = Provider.of<MedicalVProvider>(context).medicalV;
    var scaffold = FutureProvider.value(
      value: _mrServices.getMedicalsV(widget.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenDefault,
          leading: CloseButton(color: Colors.black),
          title: Text('Medical visits'),
        ),
        body: ListMedicalV(mediclaV, widget.id),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => showDialog(context: context, builder: (BuildContext context) => AddMedicalVDialog(widget.id, null), barrierDismissible: false)
        ),
      )
    );
    return scaffold;
  }
}