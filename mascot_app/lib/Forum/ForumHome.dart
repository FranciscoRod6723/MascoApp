import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';
import 'package:mascot_app/Forum/post/addpost.dart';
import 'package:mascot_app/Forum/post/list.dart';
import 'package:provider/provider.dart';

class HomeForum extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PostService _postService = PostService();
    var scaffold = FutureProvider.value(
      value: _postService.getFeed(),
      child: Scaffold(
        body: ListPost(null), 
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Colors.greenDefault,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Add())
          ),
        ),
      )
    );
    return scaffold;
  }
}