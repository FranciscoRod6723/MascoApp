import 'package:cloud_firestore/cloud_firestore.dart';

class MedicalV {
  String id;
  final String name;
  final Timestamp fromdate;
  final Timestamp todate;
  final String veterinarian;
  final String reason;
  final String comments;
  bool isExpanded;


  MedicalV({
    this.id,
    this.name,
    this.fromdate,
    this.todate,
    this.veterinarian,
    this.isExpanded,
    this.reason,
    this.comments,
  });
}