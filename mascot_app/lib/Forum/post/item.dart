import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';
import 'package:mascot_app/objects/post.dart';
import 'package:mascot_app/objects/user.dart';
import 'package:mascot_app/Forum/post/replies.dart';

class ItemPost extends StatefulWidget {
  final PostModel post;
  final AsyncSnapshot<UserModel> snapshotUser;
  final AsyncSnapshot<bool> snapshotLike;
  final bool sharring;
  final AsyncSnapshot<bool> snapshotSharring;
  const ItemPost({this.post,this.snapshotUser, this.snapshotLike, this.sharring,this.snapshotSharring, Key key }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<ItemPost> {

  @override
  Widget build(BuildContext context) {
    PostService _postService = PostService();
    return ListTile(
      title: Padding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(widget.snapshotSharring.data || widget.sharring)
            Text('Sharring'),
            SizedBox(height:10),
            Row(
            children: [
                widget.snapshotUser.data.profileImageUrl != '' ? 
                CircleAvatar(
                  radius:20,
                  backgroundImage: NetworkImage(widget.snapshotUser.data.profileImageUrl)
                )
                : Icon(Icons.person, size: 40),
                SizedBox(width: 10,),
                Text(widget.snapshotUser.data.name),
              ],
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(0,15,0,15), 
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0,15,0,15),
            child: Column(
              children: [
                Text(widget.post.text),
                SizedBox(height: 20,),
                Text(widget.post.timestamp.toDate().toString()),
                SizedBox(height:20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.chat_bubble_outline_outlined, 
                            color: Colors.black, 
                            size: 30,), 
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Replies(widget.post))
                          )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.paw, 
                            color:
                              widget.snapshotLike.data ?
                              Colors.red
                              : Colors.black, 
                            size: 30,), 
                          onPressed: () { 
                            _postService.likePost(widget.post , widget.snapshotLike.data);
                          }
                        ),
                        Text(widget.post.likesCount.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            widget.snapshotSharring.data ?
                            Icons.cancel: Icons.repeat , 
                            color: Colors.black,
                            size: 30,), 
                            onPressed: () { 
                              _postService.sharerring(widget.post, widget.snapshotSharring.data);
                            }
                        ),
                        Text(widget.post.sharringCount.toString()),
                      ],
                    )
                  ],
                )
              ],
            ), 
          ),
          Divider(),
        ],
      )
    );
  }
}
