import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:mascot_app/utils/utilsImage.dart';

class UserServices {
  UtilsServices  _utilsServices = UtilsServices();

  List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        id: doc.id,
        name: doc['name'] ?? '',
        profileImageUrl: doc['profileImageUrl'] ?? '',
        bannerImageUrl: doc['bannerImageUrl'] ?? '',
        email: doc['email'] ?? '',
      );
    }).toList();
  }

  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot){
    return snapshot != null ?
      UserModel(
        id: snapshot.id,
        name: snapshot['name'] ?? '',
        bannerImageUrl: snapshot['bannerImageUrl'] ?? '',
        profileImageUrl: snapshot['profileImageUrl'] ?? '',
        email: snapshot['email'] ?? '',
      )
      : null;
  }

  Stream<UserModel> getUSerInfo(uid){
    return FirebaseFirestore.instance
    .collection('user')
    .doc(uid)
    .snapshots()
    .map(_userFromFirebaseSnapshot);
  }

  Stream<List<UserModel>> queryByName(search){
    return FirebaseFirestore.instance
    .collection('user')
    .orderBy('name')
    .startAt([search])
    .endAt([search + '\uf8ff'])
    .limit(10)
    .snapshots()
    .map(_userListFromQuerySnapshot);
  }

  
  Stream<bool> isFollowing(uid,otherId){
    return FirebaseFirestore.instance
    .collection('user')
    .doc(uid)
    .collection('following')
    .doc(otherId)
    .snapshots()
    .map((snapshots){return snapshots.exists;});
  }

  Future<void> followUser(uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('following')
        .doc(uid)
        .set({});

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({});
  }

  Future<void> unfollowUser(uid) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('following')
        .doc(uid)
        .delete();

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('followers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .delete();
  }

  Future<List<String>> getUserFollowing(uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('following')
        .get();

    final users = querySnapshot.docs.map((doc) => doc.id).toList();
    return users;
  }

  Future<void> updateProfile(File _bannerImage, File _profileImage, String username) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if(_bannerImage != null){
      bannerImageUrl = await _utilsServices.uploadFile(_bannerImage, 'users/profile/${FirebaseAuth.instance.currentUser.uid}/banner');
    }
    if(_profileImage != null){
      profileImageUrl = await _utilsServices.uploadFile(_profileImage, 'users/profile/${FirebaseAuth.instance.currentUser.uid}/profile');
    } 

    Map<String, Object> data = new HashMap();

    if(username != '') data['name'] = username;
    if(bannerImageUrl != '') data['bannerImageUrl'] = bannerImageUrl;
    if(profileImageUrl != '') data['profileImageUrl'] = profileImageUrl;

    await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser.uid).update(data);
  }
}