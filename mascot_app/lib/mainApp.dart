import 'package:flutter/material.dart';
import 'package:mascot_app/DrownerMenu/DrownerMenu.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';
import 'package:mascot_app/Forum/ForumHome.dart';
import 'package:mascot_app/Forum/ForumSearch.dart';
import 'package:mascot_app/HelatCard/HealtCardHome.dart';
import 'package:mascot_app/Remaiders/RemaidersHome.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Home createState() => Home();
}

class Home extends State<HomePage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  int _appBarrIndex = 0; 
  static BuildContext context1;
  final tabs = [
    HomeHealt(),
    Remainders(),
    HomeForum(),
  ];

  final appbar = [
    PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBarDefault(titleP: "MascotApp"),
    ),
    AppBar(
        backgroundColor: Colors.greenDefault,
        title: Text("Forum", style: TextStyle(color: Colors.black),),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: () => Navigator.of(context1).push(
              MaterialPageRoute(builder: (context) => Search())
            ),
            icon: Icon(Icons.search, color: Colors.black),
            label: Text('search', style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
  ];

  @override
  Widget build(BuildContext context){
    context1 = context;
    var scaffold = Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: appbar[_appBarrIndex],
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined, color: Colors.black),
            label: 'Medical',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded, color: Colors.black),
            label: 'Agenda',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined, color: Colors.black),
           label: 'foro',
            backgroundColor: Colors.white
          ),
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
            if (index == 2) {
              _appBarrIndex = 1;
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