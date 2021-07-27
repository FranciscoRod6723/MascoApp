import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';
import 'package:mascot_app/ExtraComponents/Funtions.dart';

class Login extends StatefulWidget {
  Login({Key key, this.titleP}) : super(key: key);

  final String titleP;
  @override
  LoginContainer createState() => LoginContainer();
}

class LoginContainer extends State<Login>{
  
  final AuthServices _authService = AuthServices();
  String email;
  String password;
  static BuildContext context1;

 @override
  Widget build(BuildContext context) {
    context1 = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "MascotApp"),
      ),
      body: buildLogin(),
    );
  }

  Widget buildLogin() => Scaffold(
    body: Container(
      padding: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              onChanged: (val) => setState((){
                email = val;
              }),
            ),
            TextFormField(
              onChanged: (val) => setState((){
                password = val;
              }),
            ),
            RaisedButton(
              child: Text("Sign Up"),
              onPressed: () async => { _authService.signUp(email, password)},
            ),
            RaisedButton(
              child: Text("Sign In"),
              onPressed: () async => { _authService.signIn(email, password)},
            )
          ],
        ),
      ),
    ),
  );
}