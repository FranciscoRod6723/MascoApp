import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;
  final String originalId;
  final bool sharring;
  DocumentReference ref;
  int likesCount;
  int sharringCount;
  String postImage;

  PostModel({
    this.postImage,
    this.id,
    this.creator,
    this.text,
    this.timestamp,
    this.likesCount,
    this.sharringCount,
    this.originalId,
    this.sharring,
    this.ref
  });
}
