import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/CreateInput.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/objects/dewornm.dart';
import 'package:mascot_app/provider/dewornm_provider.dart';
import 'package:mascot_app/provider/vaccine_provider.dart';
import 'package:mascot_app/utils/utilsEvent.dart';
import 'package:provider/provider.dart';

class AddDewornmDialog extends StatefulWidget{
  final Dewornm dewornm;
  final String id;
   
  const AddDewornmDialog(this.id, this.dewornm,{
    Key key,
  }) : super(key: key);

  @override
  _AddDewornmDialog createState() => _AddDewornmDialog();
}

class _AddDewornmDialog extends State<AddDewornmDialog>{  
  final _formKey = GlobalKey<FormState>();
  DateTime fromDate;
  DateTime toDate;
  final dewornmController = TextEditingController();
  final veterinairanController = TextEditingController();
  final weightController = TextEditingController();
  final commentsController = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(widget.dewornm != null){
      fromDate = widget.dewornm.date.toDate();
      toDate = widget.dewornm.next.toDate();
      dewornmController.text = widget.dewornm.deworn;
      veterinairanController.text = widget.dewornm.veterinarian;
      weightController.text = widget.dewornm.weight;
      commentsController.text = widget.dewornm.comments;

    }else{
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(days: 1));
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
                  'Add dewornming',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  )
                ),
                SizedBox(height:20),
                buildInput("Dewornming", dewornmController),
                SizedBox(height: 50),
                buildDateTimePickers(),
                SizedBox(height: 20),
                buildInput("Weight", weightController),
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
    header: 'Nex dewornming',
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
      final dewornm = Dewornm(
        date: Timestamp.fromDate(fromDate),
        next: Timestamp.fromDate(toDate),
        deworn: dewornmController.text,
        veterinarian: veterinairanController.text,
        comments: commentsController.text,
        weight: weightController.text,
        isExpanded: false,
      );

      final isEditting = widget.dewornm != null;
      final provider = Provider.of<DewornmProvider>(context, listen: false);
      if(isEditting){
        provider.editEvent(dewornm, widget.dewornm);
        _mrServices.updateDewornm(id, widget.dewornm.id,fromDate ,  dewornmController.text, toDate,veterinairanController.text, weightController.text, commentsController.text);
      }else{
        provider.addEvent(dewornm);
        _mrServices.saveDewornm(id, fromDate ,  dewornmController.text, toDate,veterinairanController.text, weightController.text, commentsController.text);
      }

      Navigator.of(context).pop();
    }
  }
}