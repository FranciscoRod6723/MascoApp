import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class Login extends StatefulWidget {
  Login({Key key, this.titleP}) : super(key: key);

  final String titleP;
  @override
  LoginContainer createState() => LoginContainer();
}

class LoginContainer extends State<Login>{
  int _currentIndex = 0; 
  static BuildContext context1;
  final tabs = [
    Scaffold(
      body: Center(
        child: new RaisedButton(
          child: Text("login"),
          onPressed: () => Navigator.pushNamed(context1, 'home')
        ),
      ),
    ),
    Center(child: Text("Registro"),),
  ];

 @override
  Widget build(BuildContext context) {
    context1 = context;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "MascotApp"),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.login, color: Colors.black),
            title: Text('Login', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration, color: Colors.black),
            title: Text('Registro',  style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white
          )
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}