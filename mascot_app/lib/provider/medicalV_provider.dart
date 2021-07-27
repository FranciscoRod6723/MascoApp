import 'package:flutter/cupertino.dart';
import 'package:mascot_app/objects/medicalV.dart';

class MedicalVProvider extends ChangeNotifier {
  final List<MedicalV> _medicalV = [];

  List<MedicalV> get medicalV => _medicalV;

  List<MedicalV> get eventsOfSelectedDate => _medicalV;

  void addEvent(MedicalV medicalV){
    _medicalV.add(medicalV);

    notifyListeners();
  }

  void deleteEvent(MedicalV medicalV){
    _medicalV.remove(medicalV);

    notifyListeners();
  }

  void editEvent(MedicalV newMedicalV, MedicalV oldMedicalV){
    final index = _medicalV.indexOf(oldMedicalV);
    _medicalV[index] = newMedicalV; 

    notifyListeners();
  }
}