import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/CreateInput.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/objects/medicalV.dart';
import 'package:mascot_app/provider/medicalV_provider.dart';
import 'package:mascot_app/utils/utilsEvent.dart';
import 'package:provider/provider.dart';

class AddMedicalVDialog extends StatefulWidget{
  final MedicalV medicalV;
  final String id;
   
  const AddMedicalVDialog(this.id, this.medicalV,{
    Key key,
  }) : super(key: key);

  @override
  _AddMedicalVDialog createState() => _AddMedicalVDialog();
}

class _AddMedicalVDialog extends State<AddMedicalVDialog>{  
  final _formKey = GlobalKey<FormState>();
  DateTime fromDate;
  DateTime toDate;
  final veterinairanController = TextEditingController();
  final reasonController = TextEditingController();
  final commentsController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(widget.medicalV != null){
      fromDate = widget.medicalV.fromdate.toDate();
      toDate = widget.medicalV.todate.toDate();
      veterinairanController.text = widget.medicalV.veterinarian;
      reasonController.text = widget.medicalV.reason;
      commentsController.text = widget.medicalV.comments;
      nameController.text = widget.medicalV.name;
    }else{
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    }
  }

  @override 
  Widget build(BuildContext context) => AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.close), 
            onPressed: () => Navigator.of(context).pop()
          ),
          SizedBox(height:10),
          Form(
            key: _formKey,
            child: Column ( 
              children: [
                Text(
                  'Add medical visit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  )
                ),
                SizedBox(height: 20),
                buildInput("Name", nameController),
                SizedBox(height: 50),
                buildDateTimePickers(),
                SizedBox(height: 20),
                buildInput("Weight", reasonController),
                SizedBox(height: 20),
                buildInput("Veterinarian", veterinairanController),
                SizedBox(height: 20),
                buildInput("Comments", commentsController),
                SizedBox(height: 30), 
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)
                  ),
                  onPressed: () => {saveForm(widget.id)},
                  child: Text("save")
                )
              ]
            )
          )
        ],
      )
    )
  );

  Widget buildDateTimePickers() => Column(
    children: [
      buildForm(),
      SizedBox(height: 50),
      buildTo(),
    ],
  );

   Widget buildForm() =>  builHeader(
    header: 'Date',
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: buildDropdownField(
            text: UtilsEvent.toDate(fromDate),
            onClicked: () => pickFromDateTime(pickDate: true),
          )
        ),
        Expanded(
          child: buildDropdownField(
            text: UtilsEvent.toTime(fromDate),
            onClicked: () => pickFromDateTime(pickDate: false) ,
          )
        )
      ],
    )
  );

  Widget buildTo() =>  builHeader(
    header: 'Next',
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: buildDropdownField(
            text: UtilsEvent.toDate(toDate),
            onClicked: () => pickToDateTime(pickDate: true),
          )
        ),
        Expanded(
          child: buildDropdownField(
            text: UtilsEvent.toTime(toDate),
            onClicked: () => pickToDateTime(pickDate: false),
          )
        )
      ],
    )
  );

  Widget builHeader({
    String header, Row child
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: TextStyle(fontWeight: FontWeight.bold,),),
      child,
    ],
  );

  Widget buildDropdownField({
    String text,
    VoidCallback onClicked,  
  }) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked, 
  );

  Future pickFromDateTime({bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate, firsDate: DateTime.now(),);

    if(date == null) return;

    if(date.isAfter(toDate)) {
      toDate = 
        DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(() => fromDate = date);
  }

  Future pickToDateTime({bool pickDate}) async {
    final date = await pickDateTime(
      toDate, 
      pickDate: pickDate,
      firsDate: pickDate ? fromDate : null,
    );

    if(date == null) return;

    setState(() => toDate = date);
  }

  Future<DateTime> pickDateTime(
    DateTime initialDate, {
      bool pickDate,
      DateTime firsDate,
    }
  ) async {
    if(pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firsDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101)
      );

      if (date == null) return null;

      final time =
        Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else{
      final timeOfDay = await showTimePicker(
        context: context, 
        initialTime: TimeOfDay.fromDateTime(initialDate) 
      );

      if(timeOfDay == null) return null;

      final date = 
        DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time =
        Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future saveForm(id) async {
    final isValid = _formKey.currentState.validate();
    MRServices _mrServices = MRServices();

    if(isValid) {
      final medicalV = MedicalV(
        fromdate: Timestamp.fromDate(fromDate),
        todate: Timestamp.fromDate(toDate),
        veterinarian: veterinairanController.text,
        comments: commentsController.text,
        reason: reasonController.text,
        name: nameController.text,
        isExpanded: false,
      );

      final isEditting = widget.medicalV != null;
      final provider = Provider.of<MedicalVProvider>(context, listen: false);
      if(isEditting){
        provider.editEvent(medicalV, widget.medicalV);
        _mrServices.updateMedical(id, widget.medicalV.id, fromDate ,toDate,veterinairanController.text, commentsController.text, reasonController.text, nameController.text);
      }else{
        provider.addEvent(medicalV);
        _mrServices.saveMedicalV(id, fromDate , toDate,veterinairanController.text, commentsController.text, reasonController.text, nameController.text);
      }

      Navigator.of(context).pop();
    }
  }
}