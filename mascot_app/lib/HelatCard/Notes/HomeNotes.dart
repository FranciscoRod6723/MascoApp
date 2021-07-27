import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/HelatCard/Notes/AddNotes.dart';
import 'package:mascot_app/HelatCard/Notes/listNotes.dart';
import 'package:mascot_app/objects/notes.dart';
import 'package:mascot_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class NoteHome extends StatefulWidget {
  final String id;
  NoteHome(this.id);

  @override
  Note createState() => Note();
}

class Note extends State<NoteHome> {

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    HCServices _hcServices = HCServices();
    
    List<Notes> notes = Provider.of<NotesProvider>(context).notes;
    var scaffold = FutureProvider.value(
      value: _hcServices.getNotes(widget.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenDefault,
          leading: CloseButton(color: Colors.black),
          title: Text('Notes'),
        ),
        body: ListNotes(notes, widget.id),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => showDialog(context: context, builder: (BuildContext context) => AddNoteDialog(widget.id, null), barrierDismissible: false)
        ),
      )
    );
    return scaffold;
  }
}