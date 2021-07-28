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
    body: SingleChildScrollView( child: Container(
      padding: EdgeInsets.all(20),
      child: Form(
        child: Column(
          children: [
            Image(image: AssetImage("assets/logo.png"), height: 200,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (val) => setState((){
                email = val;
              }),
            ),
            SizedBox(height:30),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Password is required';
                }
              },
              onChanged: (val) => setState((){
                password = val;
              }),
            ),
            SizedBox(height:50),
            GestureDetector(
              onTap: (){
                _authService.signIn(email, password);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenDefault,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 150,
                height: 50,
                child: Center( child: Text("Sign In", style: TextStyle(fontSize: 18)))
              )
            ),
            SizedBox(height:150),
            Text("Enter your information and register"),
            SizedBox(height:10),
            GestureDetector(
              onTap: (){
                 _authService.signUp(email, password);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.greenDefault,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 150,
                height: 50,
                child: Center( child: Text("Sign up", style: TextStyle(fontSize: 18)))
              )
            ),
          ],
        ),
      ),
    ),
  ));
}