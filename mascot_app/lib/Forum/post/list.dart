import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';
import 'package:mascot_app/ExtraComponents/UserServices.dart';
import 'package:mascot_app/objects/post.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:provider/provider.dart';
import 'package:mascot_app/Forum/post/item.dart';

class ListPost extends StatefulWidget {
  final PostModel post;
  const ListPost(this.post, {Key key}) : super(key: key);

  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost>{
  @override
  Widget build(BuildContext context) {
    PostService _postService = PostService();
    List<PostModel> posts = Provider.of<List<PostModel>>(context) ?? []; 
    if(widget.post != null){
      posts.insert(0,widget.post);
    }
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        if(post.sharring){
          return FutureBuilder(
              future: _postService.getPostById(post.originalId),
              builder: (BuildContext context, 
              AsyncSnapshot<PostModel> snapshotPost) {
                if(!snapshotPost.hasData){
                  return Center(child:CircularProgressIndicator());
                }
                 return mainPost(snapshotPost.data, true);
              }
            );
        }
        return mainPost(post, false);
      },
    );
  }

  StreamBuilder<UserModel> mainPost(PostModel post, bool sharring) {
    UserServices _userService = UserServices();
    PostService _postService = PostService();
    return StreamBuilder( 
      stream: _userService.getUSerInfo(post.creator),
      builder: (BuildContext context,  AsyncSnapshot<UserModel> snapshotUser) {
        if(!snapshotUser.hasData){
          return Center(child:CircularProgressIndicator());
        }
    
        //---
        return StreamBuilder( 
          stream: _postService.getCurrentUserLike(post),
          builder: (BuildContext context,  AsyncSnapshot<bool> snapshotLike) {
          if(!snapshotLike.hasData){
            return Center(child:CircularProgressIndicator());
          }
          return StreamBuilder( 
            stream: _postService.getCurrentUserSharring(post),
            builder: (BuildContext context,  AsyncSnapshot<bool> snapshotSharring) {
            if(!snapshotSharring.hasData){
              return Center(child:CircularProgressIndicator());
            }
              return ItemPost(post: post, snapshotLike: snapshotLike, snapshotUser: snapshotUser, sharring: sharring, snapshotSharring:snapshotSharring);
            }
          );
        });
      }
    );
  }
}