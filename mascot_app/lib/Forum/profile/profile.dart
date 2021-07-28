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
  UserServices _userService = UserServices();
  ScrollController _scrollViewController;

  @override
  void initState(){
    super.initState();
    _scrollViewController = ScrollController();
  }

  @override
  void dispose(){
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String id = widget.userId != null ? widget.userId : FirebaseAuth.instance.currentUser.uid;
    return MultiProvider(
        providers: [
          StreamProvider.value(
            value: _userService.isFollowing(
                FirebaseAuth.instance.currentUser.uid, widget.userId),
          ),
          StreamProvider.value(
            value: _postService.getPostsByUser(id),
          ),
          StreamProvider.value(
            value: _userService.getUSerInfo(id),
          )
        ],
        child: Scaffold(
            body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.greenDefault,
                    floating: false,
                    pinned: true,
                    expandedHeight: 130,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                      Provider.of<UserModel>(context).bannerImageUrl ?? '',
                      fit: BoxFit.cover,
                    )),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Provider.of<UserModel>(context)
                                            .profileImageUrl !=
                                        ''
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            Provider.of<UserModel>(context)
                                                .profileImageUrl),
                                      )
                                    : Icon(Icons.person, size: 50),
                                if (FirebaseAuth.instance.currentUser.uid ==
                                    id)
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/edit');
                                      },
                                      child: Text("Edit Profile"))
                                else if (FirebaseAuth
                                            .instance.currentUser.uid !=
                                        id &&
                                    !Provider.of<bool>(context))
                                  TextButton(
                                      onPressed: () {
                                        _userService.followUser(id);
                                      },
                                      child: Text("Follow"))
                                else if (FirebaseAuth
                                            .instance.currentUser.uid !=
                                        id &&
                                    Provider.of<bool>(context))
                                  TextButton(
                                      onPressed: () {
                                        _userService.unfollowUser(id);
                                      },
                                      child: Text("Unfollow")),
                              ]),
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
                        ],
                      ),
                    )
                  ]))
                ];
              },
              body: ListPost(null)),
        )));
  }
}