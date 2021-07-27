import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/FuntionsPost.dart';
import 'package:mascot_app/Forum/post/list.dart';
import 'package:mascot_app/objects/post.dart';
import 'package:provider/provider.dart';

class Replies extends StatefulWidget {
  final PostModel args;
  Replies(this.args,{Key key}) : super(key: key);

  @override
  _RepliesState createState() => _RepliesState();
}

class _RepliesState extends State<Replies> {
  PostService _postService = PostService();
  String text = '';
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PostModel args = widget.args;
    return FutureProvider.value(
        value: _postService.getReplies(args),
        child: Container(
          child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  Expanded(child: ListPost(args)),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                            child: TextFormField(
                          controller: _textController,
                          onChanged: (val) {
                            setState(() {
                              text = val;
                            });
                          },
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        FlatButton(
                            textColor: Colors.black,
                            color: Colors.greenDefault,
                            onPressed: () async {
                              await _postService.reply(args, text);
                              _textController.text = '';
                              setState(() {
                                text = '';
                              });
                            },
                            child: Text("Reply"))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}