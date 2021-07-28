
import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mascot_app/objects/cards.dart';
import 'package:mascot_app/objects/notes.dart';
import 'package:mascot_app/utils/utilsImage.dart';

class HCServices{
  UtilsServices  _utilsServices = UtilsServices();

  List<Cards> _postListFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Cards(
        id: doc.id,
        profileImageUrl: doc['profileImageUrl'] != null  ? doc['profileImageUrl'] : '',
        petName:doc['petName'] != null  ? doc['petName'] : '',
        birthday: doc['birthday'] != null  ? doc['birthday'] : '',
        sex: doc['sex'] != null ? doc['sex'] : '',
        specie: doc['specie'] != null ? doc['specie'] : Timestamp.now(),
        breed: doc['breed'] != null ? doc['breed'] : 0,
        weight: doc['weight'] != null ? doc['weight'] :0,
        color: doc['color'] != null ? doc['color'] : false,
        veterinarian: doc['veterinarian'] != null ? doc['veterinarian'] : '',
        mchipId: doc['mchipId'] != null ? doc['mchipId'] : '',
      );
    }).toList();
  }

  List<Notes> _notesFromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return Notes(
        id: doc.id,
        title: doc['text'] != null  ? doc['text'] : '',
        createDate: doc['date'] != null  ? doc['date'] : Timestamp.now(),
        description: doc['description'] != null  ? doc['description'] : '',
        isExpanded: doc['isExpanded'] != null  ? doc['isExpanded'] : false,
      );
    }).toList();
  }

  Future saveCard(petname, birth, sex, specie, breed, weight, color, veterinarian, mchip, image) async {
    var a = await FirebaseFirestore.instance.collection("hcards").add({
      'petName': petname,
      'birthday': birth,
      'sex': sex,
      'specie': specie,
      'breed': breed,
      'weight': weight,
      'color': color,
      'veterinarian': veterinarian,
      'mchipId': mchip,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'profileImageUrl': ''
    });   
    updateProfile(image, a.id);
  }

  Future saveNote(id, text, description, date) async {
    await FirebaseFirestore.instance.collection("hcards").doc(id).collection('notes').add({
      'petid': id,
      'text': text,
      'description': description,
      'date': date,
      'creator': FirebaseAuth.instance.currentUser.uid,
      'isExpanded': false,
    });   
  }

  Future<List<Cards>> getCards() async {
    List<Cards> feedList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hcards')
        .where('creator', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get();

    feedList.addAll(_postListFromSnapshots(querySnapshot));

    return feedList;
  }

  Future<List<Notes>> getNotes(id) async {
    List<Notes> feedList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hcards')
        .doc(id)
        .collection('notes')
        .where('petid', isEqualTo: id)
        .get();

    feedList.addAll(_notesFromSnapshots(querySnapshot));

    return feedList; 
  }

  Future deletedCard(Cards post) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(post.id)
      .delete();
  }

  Future deletedNote(id,idn) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .collection('notes')
      .doc(idn)
      .delete();
  }

  Future updateCard(id, petname, birth, sex, specie, breed, weight, color, veterinarian, mchip) async {
    await FirebaseFirestore.instance
      .collection("hcards")
      .doc(id)
      .update({
        'petName': petname,
        'birthday': birth,
        'sex': sex,
        'specie': specie,
        'breed': breed,
        'weight': weight,
        'color': color,
        'veterinarian': veterinarian,
        'mchipId': mchip,
        'creator': FirebaseAuth.instance.currentUser.uid,
      });
  }

  Future<void> updateProfile(File _profileImage, String idpet) async {
    String profileImageUrl = '';

    if(_profileImage != null){
      profileImageUrl = await _utilsServices.uploadFile(_profileImage, 'users/healtcard/${FirebaseAuth.instance.currentUser.uid}/${idpet}/profile');
    } 

    Map<String, Object> data = new HashMap();

    if(profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;

    await FirebaseFirestore.instance.collection('hcards').doc(idpet).update(data);
  }
}