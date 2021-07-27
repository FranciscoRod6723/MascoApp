import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/CreateInput.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/objects/notes.dart';
import 'package:mascot_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class AddNoteDialog extends StatefulWidget{
  final Notes notes;
  final String id;
   
  const AddNoteDialog(this.id, this.notes,{
    Key key,
  }) : super(key: key);

  @override
  _AddNoteDialog createState() => _AddNoteDialog();
}

class _AddNoteDialog extends State<AddNoteDialog>{  
  final _formKey = GlobalKey<FormState>();
  String title;
  String description;
  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  void initState(){
    super.initState();

    if(widget.notes != null){
      titleController.text = widget.notes.title;
      desController.text = widget.notes.description;
    }
  }

  @override 
  Widget build(BuildContext context) => AlertDialog(
    content: Column(
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
                'Add note',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )
              ),
              SizedBox(height:20),
              buildInput("Title", titleController),
              SizedBox(height: 20),
              buildInput("Description", desController),
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
  );

  Future saveForm(id) async {
    final isValid = _formKey.currentState.validate();
    HCServices _hcServices = HCServices();

    if(isValid) {
      final note = Notes(
        title: titleController.text,
        description: desController.text,
        createDate: Timestamp.now(),
        isExpanded: false,
      );

      final isEditting = widget.notes != null;
      final provider = Provider.of<NotesProvider>(context, listen: false);
      if(isEditting){
        provider.editEvent(note, widget.notes);
      }else{
        provider.addEvent(note);
        _hcServices.saveNote(id, titleController.text, desController.text, Timestamp.now());
      }

      Navigator.of(context).pop();
    }
  }
}