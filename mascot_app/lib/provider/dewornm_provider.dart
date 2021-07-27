import 'package:flutter/cupertino.dart';
import 'package:mascot_app/objects/dewornm.dart';

class DewornmProvider extends ChangeNotifier {
  final List<Dewornm> _dewornm = [];

  List<Dewornm> get deworn => _dewornm;

  List<Dewornm> get eventsOfSelectedDate => _dewornm;

  void addEvent(Dewornm dewornm){
    _dewornm.add(dewornm);

    notifyListeners();
  }

  void deleteEvent(Dewornm dewornm){
    _dewornm.remove(dewornm);

    notifyListeners();
  }

  void editEvent(Dewornm newDewornm, Dewornm oldDewornm){
    final index = _dewornm.indexOf(oldDewornm);
    _dewornm[index] = newDewornm; 

    notifyListeners();
  }
}