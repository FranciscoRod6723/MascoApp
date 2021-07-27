import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/UserServices.dart';
import 'package:mascot_app/Forum/profile/list.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  UserServices _userServices = UserServices();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: _userServices.queryByName(search),
      child: Scaffold (
          appBar: AppBar(
            backgroundColor: Colors.greenDefault,
            title: Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    search = text;
                  });
                },
                decoration: InputDecoration(hintText: 'Search...'),
              ),
            ),
          ),
          body: Column(
          children: [
            ListUsers()
          ],
        ),
      )
    );
  }
}