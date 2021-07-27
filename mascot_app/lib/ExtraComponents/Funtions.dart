import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascot_app/objects/user.dart';

List<Widget> createIcons(String type, bool check){
  List<Widget> icons = [];

  if(type == "1"){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.userMd, size: 15)));
  }else if ((type == "2")){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.clinicMedical, size: 15)));
  }

  if(check){
    icons.add(Container(padding:EdgeInsets.all(5) ,child:Icon(FontAwesomeIcons.checkCircle, size: 15)));
  }
  return icons;
}

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  UserModel _userFromFireBaseUser(User user){
    return user != null ? UserModel(id: user.uid) : null;
  }

  Stream<UserModel> get user{
    return auth.authStateChanges().map(_userFromFireBaseUser);
  }

  void signUp(String email, String password) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      await FirebaseFirestore.instance.collection('user').doc(user.user.uid).set({'name': email, 'email': email, 'bannerImageUrl': '', 'profileImageUrl': ''});
      _userFromFireBaseUser(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signIn(String email, String password) async {
    try {
      User user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password
      ) as User;

      _userFromFireBaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try{
      return await auth.signOut();
    }catch (e){
      print(e.toString());
    }
  }
}
