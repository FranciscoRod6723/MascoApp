import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/QuoteId.dart';
import 'package:mascot_app/objects/event.dart';
import 'package:mascot_app/provider/event_provider.dart';
import 'package:mascot_app/utils/utilsEvent.dart';
import 'package:provider/provider.dart';

class AddRemainders extends StatefulWidget {
  final Event event;
   
  const AddRemainders({
    Key key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<AddRemainders> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final desController = TextEditingController();
  DateTime fromDate;
  DateTime toDate;
  String titleAppbar;

  @override
  void initState(){
    super.initState();

    if(widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
      titleAppbar = 'Add Remainder';
    } else {
      final event = widget.event;

      desController.text = event.description;
      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
      titleAppbar = 'Edit Remainder';
    }
  }

  @override
  void dispose(){
    titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: Text(titleAppbar),
      backgroundColor: Colors.greenDefault,
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Form (
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle("Title", titleController),
            SizedBox(height:2),
            buildDateTimePickers(),
            buildTitle("Description", desController),
          ],
        ),
      )
    )
  );

  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: saveForm,
      icon: Icon(Icons.done),
      label: Text('save'),
    ),
  ];

  Widget buildTitle(title, controller) => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: title,
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: (title) => 
      title != null && title.isEmpty ? 'Title cannot be emty' + title : null,
    controller: controller,
  );

  Widget buildDateTimePickers() => Column(
    children: [
      buildForm(),
      buildTo(),
    ],
  );

  Widget buildForm() =>  builHeader(
    header: 'From',
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
    header: 'To',
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

  Widget buildDropdownField({
    String text,
    VoidCallback onClicked,  
  }) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked, 
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

  Future saveForm() async {
    final isValid = _formKey.currentState.validate();

    if(isValid) {
      final event = Event(
        title: titleController.text,
        description: desController.text,
        from: fromDate,
        to: toDate,
      );

      final isEditting = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);
      if(isEditting){
        provider.editEvent(event, widget.event);
      }else{
        CollectionReference collectionReference = FirebaseFirestore.instance.collection("remainders_data");
        collectionReference.add({
          "dateFrom": UtilsEvent.toTimeDateS(fromDate),
          "dateTo": UtilsEvent.toTimeDateS(toDate),
          "description": desController.text,
          "id_pet": "1",
          "id_remainder": getRandomString(20),
          "title": titleController.text,
          "id_user": FirebaseAuth.instance.currentUser.uid,
        });
        provider.addEvent(event);
      }

      Navigator.of(context).pop();
    }
  }
}