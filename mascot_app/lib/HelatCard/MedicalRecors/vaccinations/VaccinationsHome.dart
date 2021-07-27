import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/AddVacineDialog.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/VaccineList.dart';
import 'package:mascot_app/objects/vaccinations.dart';
import 'package:mascot_app/provider/vaccine_provider.dart';
import 'package:provider/provider.dart';

class VaccHome extends StatefulWidget {
  final String id;
  VaccHome(this.id);

  @override
  Vacc createState() => Vacc();
}

class Vacc extends State<VaccHome> {

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    MRServices _mrServices = MRServices();
    
    List<Vaccinations> vaccines = Provider.of<VaccineProvider>(context).vaccine;
    var scaffold = FutureProvider.value(
      value: _mrServices.getVaccine(widget.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenDefault,
          leading: CloseButton(color: Colors.black),
          title: Text('Vaccinations'),
        ),
        body: ListVaccine(vaccines, widget.id),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => showDialog(context: context, builder: (BuildContext context) => AddVaccineDialog(widget.id, null), barrierDismissible: false)
        ),
      )
    );
    return scaffold;
  }
}