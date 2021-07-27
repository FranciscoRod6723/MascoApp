import 'package:cloud_firestore/cloud_firestore.dart';

class Notes {
  final String id;
  final String title;
  final Timestamp createDate;
  final String description;
  bool isExpanded;


  Notes({
    this.id,
    this.title,
    this.createDate,
    this.description,
    this.isExpanded
  });
}