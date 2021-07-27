import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mascot_app/objects/dewornm.dart';
import 'package:mascot_app/objects/medicalV.dart';
import 'package:mascot_app/objects/vaccinations.dart';

class MRServices{

  //--------------- Vacctinations services

  List<Vaccinations> _vaccineFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Vaccinations(
        id: doc.id,
        date: doc['date'] != null  ? doc['date'] : Timestamp.now(),
        vaccine: doc['vaccine'] != null  ? doc['vaccine'] : '',
        next: doc['nvaccine'] != null  ? doc['nvaccine'] : Timestamp.now(),
        veterinarian: doc['veterinarian'] != null  ? doc['veterinarian'] : '',
        isExpanded: doc['isExpanded'] != null  ? doc['isExpanded'] : false,
      );
    }).toList();
  }

  
  Future saveVaccine(id, date, vaccine, nvaccine, veterinarian) async {
    await FirebaseFirestore.instance.collection("hcards").doc(id).collection('vaccine').add({
      'petid': id,
      'date': date,
      'vaccine': vaccine,
      'nvaccine': nvaccine,
      'veterinarian': veterinarian,
      'isExpanded': false,
    });   
  }

  Future<List<Vaccinations>> getVaccine(id) async {
    List<Vaccinations> feedList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hcards')
        .doc(id)
        .collection('vaccine')
        .where('petid', isEqualTo: id)
        .get();

    feedList.addAll(_vaccineFromSnapshots(querySnapshot));

    return feedList; 
  }

  Future deletedVaccine(id,idn) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('vaccine')
      .doc(idn)
      .delete();
  }

  Future updateVaccine(id, idv, date, vaccine, nvaccine,veterinarian) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('vaccine')
      .doc(idv)
      .update({
        'petid': id,
        'date': date,
        'vaccine': vaccine,
        'nvaccine': nvaccine,
        'veterinarian': veterinarian,
        'isExpanded': false,
      });
  }


  //--------------------- Dewornming Services

  List<Dewornm> _dewornmFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Dewornm(
        id: doc.id,
        date: doc['date'] != null  ? doc['date'] : Timestamp.now(),
        deworn: doc['dewornming'] != null  ? doc['dewornming'] : '',
        next: doc['ndewornm'] != null  ? doc['ndewornm'] : Timestamp.now(),
        veterinarian: doc['veterinarian'] != null  ? doc['veterinarian'] : '',
        weight: doc['weight'] != null  ? doc['weight'] : '',
        comments: doc['comments'] != null  ? doc['comments'] : '',
        isExpanded: doc['isExpanded'] != null  ? doc['isExpanded'] : false,
      );
    }).toList();
  }

  
  Future saveDewornm(id, date, dewornming, ndewornm, veterinarian, weight, comments) async {
    await FirebaseFirestore.instance.collection("hcards").doc(id).collection('dewornm').add({
      'petid': id,
      'date': date,
      'dewornming': dewornming,
      'ndewornm': ndewornm,
      'weight': weight,
      'veterinarian': veterinarian,
      'comments': comments,
      'isExpanded': false,
    });   
  }

  Future<List<Dewornm>> getDewornm(id) async {
    List<Dewornm> feedList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hcards')
        .doc(id)
        .collection('dewornm')
        .where('petid', isEqualTo: id)
        .get();

    feedList.addAll(_dewornmFromSnapshots(querySnapshot));

    return feedList; 
  }

  Future deletedDewornm(id,idn) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('dewornm')
      .doc(idn)
      .delete();
  }

  Future updateDewornm(id, idd, date, dewornming, ndewornm, veterinarian, weight, comments) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('dewornm')
      .doc(idd)
      .update({
        'petid': id,
        'date': date,
        'dewornming': dewornming,
        'ndewornm': ndewornm,
        'weight': weight,
        'veterinarian': veterinarian,
        'comments': comments,
        'isExpanded': false,
      });
  }

  //-------Medical Visits Services

  List<MedicalV> _medicalVFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return MedicalV(
        id: doc.id,
        fromdate: doc['fromDate'] != null  ? doc['fromDate'] : Timestamp.now(),
        todate: doc['toDate'] != null  ? doc['toDate'] : Timestamp.now(),
        veterinarian: doc['veterinarian'] != null  ? doc['veterinarian'] : '',
        reason: doc['reason'] != null  ? doc['reason'] : '',
        comments: doc['comments'] != null  ? doc['comments'] : '',
        name: doc['name'] != null ? doc['name'] : '',
        isExpanded: doc['isExpanded'] != null  ? doc['isExpanded'] : false,
      );
    }).toList();
  }

  
  Future saveMedicalV(id, fromDate, toDate, veterinarian, comments, reason, name) async {
    await FirebaseFirestore.instance.collection("hcards").doc(id).collection('medical-visits').add({
      'petid': id,
      'name': name,
      'fromDate': fromDate,
      'toDate': toDate,
      'reason': reason,
      'veterinarian': veterinarian,
      'comments': comments,
      'isExpanded': false,
    });   
  }

  Future<List<MedicalV>> getMedicalsV(id) async {
    List<MedicalV> feedList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hcards')
        .doc(id)
        .collection('medical-visits')
        .where('petid', isEqualTo: id)
        .get();

    feedList.addAll(_medicalVFromSnapshots(querySnapshot));

    return feedList; 
  }

  Future deletedMedicalV(id,idn) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('medical-visits')
      .doc(idn)
      .delete();
  }

  Future updateMedical(id,idm, fromDate, toDate, veterinarian, comments, reason,name) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('medical-visits')
      .doc(idm)
      .update({
        'petid': id,
        'name': name,
        'fromDate': fromDate,
        'toDate': toDate,
        'reason': reason,
        'veterinarian': veterinarian,
        'comments': comments,
        'isExpanded': false,
      });
  }
}