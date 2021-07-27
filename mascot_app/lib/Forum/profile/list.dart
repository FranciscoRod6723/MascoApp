import 'package:flutter/material.dart';
import 'package:mascot_app/Forum/profile/profile.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:provider/provider.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({ Key key }) : super(key: key);

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    List<UserModel> users = Provider.of<List<UserModel>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (context, index){
        final user = users[index];

        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Profile(userId: user.id))
          ) ,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    user.profileImageUrl != '' ? 
                    CircleAvatar(radius:20, backgroundImage: NetworkImage(user.profileImageUrl))
                    : Icon(Icons.person, size: 40,),
                    SizedBox(width: 10),
                    Text(user.name)
                  ]
                ),
              ),
              Divider(thickness: 1,)
            ],
          ),
        );
      }
    );
  }
}