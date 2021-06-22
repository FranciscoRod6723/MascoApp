import 'package:flutter/material.dart';
import 'package:mascot_app/DrownerMenu/DrownerMenu.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Home createState() => Home();
}

class Home extends State<HomePage>{
  int _currentIndex = 0;
  int _appBarrIndex = 0; 
  static BuildContext context1;
  final tabs = [
    Center(child: Text("Home"),),
    Center(child: Text("Medical"),),
    Center(child: Text("Agenda"),),
    Center(
      child: new RaisedButton(
        child: Text("Post"),
        onPressed: () => Navigator.pushNamed(context1, 'Post')
      )
    ),
  ];

  final appbar = [
    PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBarDefault(titleP: "MascotApp"),
    )
  ];

  @override
  Widget build(BuildContext context){
    context1 = context;
    var scaffold = Scaffold(
      backgroundColor: Colors.backDarkThem,
      drawer: NavDrawer(),
      appBar: appbar[_appBarrIndex],
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            title: Text('Home', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined, color: Colors.black),
            title: Text('Medical',  style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded, color: Colors.black),
            title: Text('Agenda',  style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined, color: Colors.black),
            title: Text('foro',  style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white
          ),
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
            if (index == 3) {
              _appBarrIndex = 0;
            } else {
              _appBarrIndex = 0;
            }
          });
        },
      ),
    );
    return scaffold;
  }
} 