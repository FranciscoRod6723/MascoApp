import 'package:cloud_firestore/cloud_firestore.dart';

class Dewornm {
  final String id;
  final String deworn;
  final Timestamp date;
  final Timestamp next;
  final String veterinarian;
  final String weight;
  final String comments;
  bool isExpanded;


  Dewornm({
    this.id,
    this.deworn,
    this.date,
    this.next,
    this.veterinarian,
    this.isExpanded,
    this.weight,
    this.comments,
  });
}