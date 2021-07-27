import 'package:flutter/cupertino.dart';
import 'package:mascot_app/objects/vaccinations.dart';

class VaccineProvider extends ChangeNotifier {
  final List<Vaccinations> _vaccine = [];

  List<Vaccinations> get vaccine => _vaccine;

  List<Vaccinations> get eventsOfSelectedDate => _vaccine;

  void addEvent(Vaccinations card){
    _vaccine.add(card);

    notifyListeners();
  }

  void deleteEvent(Vaccinations card){
    _vaccine.remove(card);

    notifyListeners();
  }

  void editEvent(Vaccinations newVaccine, Vaccinations oldVaccine){
    final index = _vaccine.indexOf(oldVaccine);
    _vaccine[index] = newVaccine; 

    notifyListeners();
  }
}