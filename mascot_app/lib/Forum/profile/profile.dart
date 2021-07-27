import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';
import 'package:mascot_app/ExtraComponents/UserServices.dart';
import 'package:mascot_app/Forum/post/list.dart';
import 'package:mascot_app/Forum/profile/edit.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, this.userId}) : super(key: key);
  final userId;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{
  PostService _postService = PostService();
  UserServices _userServices = UserServices();
  @override
  Widget build(BuildContext context) {
    String id = widget.userId != null ? widget.userId : FirebaseAuth.instance.currentUser.uid;
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: _userServices.isFollowing(FirebaseAuth.instance.currentUser.uid, widget.userId),
        ),
        StreamProvider.value(
          value: _postService.getPostsByUser(FirebaseAuth.instance.currentUser.uid),
        ),
        StreamProvider.value(
          value: _userServices.getUSerInfo(id),
        )
      ],
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, _) {
              return[
                SliverAppBar(
                  backgroundColor: Colors.greenDefault,
                  floating: false,
                  pinned: true,
                  expandedHeight: 130,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(Provider.of<UserModel>(context).bannerImageUrl ?? '',
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: EdgeInsets.symmetric(vertical:20, horizontal:20),
                        child: Column(
                          children: [ 
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Provider.of<UserModel>(context).profileImageUrl != ''  ? 
                                CircleAvatar(radius:30, backgroundImage: NetworkImage(Provider.of<UserModel>(context).profileImageUrl))
                                : Icon(Icons.person, size: 40,),
                                if (FirebaseAuth.instance.currentUser.uid ==
                                    widget.userId)
                                  TextButton(
                                      onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => EditProfile())
                                      ),
                                      child: Text("Edit Profile", style: TextStyle(color:Colors.black)))
                                else if (FirebaseAuth
                                            .instance.currentUser.uid !=
                                        widget.userId &&
                                    !Provider.of<bool>(context))
                                  TextButton(
                                      onPressed: () {
                                        _userServices.followUser(widget.userId);
                                      },
                                      child: Text("Follow",  style: TextStyle(color:Colors.greenAccent[700])))
                                else if (FirebaseAuth
                                            .instance.currentUser.uid !=
                                        widget.userId &&
                                    Provider.of<bool>(context))
                                  TextButton(
                                      onPressed: () {
                                        _userServices.unfollowUser(widget.userId);
                                      },
                                      child: Text("Unfollow", style: TextStyle(color:Colors.red))),
                                
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  Provider.of<UserModel>(context).name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                      )
                    ]
                  ),
                )
              ];
            }, body:  ListPost(null),
          ),
        )
      ),
    );
  }
}