import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
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
            leading: Icon(Icons.input),
            title: Text('About us'),
            onTap: () => Navigator.pushNamed(context, 'info'),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Privacy policies'),
            onTap: () => Navigator.pushNamed(context, 'ppolicies')
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Contact'),
            onTap: () => Navigator.pushNamed(context, 'contac'),
          ),
        ],
      ),
    );
  }
}