import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccinations {
  final String id;
  final String vaccine;
  final Timestamp date;
  final Timestamp next;
  final String veterinarian;
  bool isExpanded;


  Vaccinations({
    this.id,
    this.vaccine,
    this.date,
    this.next,
    this.veterinarian,
    this.isExpanded
  });
}