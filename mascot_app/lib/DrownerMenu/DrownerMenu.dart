import 'package:flutter/material.dart';
import 'package:mascot_app/DrownerMenu/ContactHome.dart';
import 'package:mascot_app/DrownerMenu/InfoComponent.dart';
import 'package:mascot_app/DrownerMenu/Ppolicies.dart';
import 'package:mascot_app/ExtraComponents/Funtions.dart';
import 'package:mascot_app/Forum/profile/edit.dart';
import 'package:mascot_app/Forum/profile/profile.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  final AuthServices _authService = AuthServices();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Configuration',
              style: TextStyle(color: Colors.grey[500], fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.greenDefault
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Profile(userId: Provider.of<UserModel>(context).id,))
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About us'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => InfoContent())
            )
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Privacy policies'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Ppolicies())
            )
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Contact'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ContacHome())
            )
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Sign Out'),
            onTap: () => _authService.signOut(),
          )
        ],
      ),
    );
  }
}