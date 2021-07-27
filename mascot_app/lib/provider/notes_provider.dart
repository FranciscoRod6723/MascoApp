import 'package:flutter/cupertino.dart';
import 'package:mascot_app/objects/notes.dart';

class NotesProvider extends ChangeNotifier {
  final List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  List<Notes> get eventsOfSelectedDate => _notes;

  void addEvent(Notes card){
    _notes.add(card);

    notifyListeners();
  }

  void deleteEvent(Notes card){
    _notes.remove(card);

    notifyListeners();
  }

  void editEvent(Notes newNote, Notes oldNote){
    final index = _notes.indexOf(oldNote);
    _notes[index] = newNote; 

    notifyListeners();
  }
}