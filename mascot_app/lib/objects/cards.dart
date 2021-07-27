import 'package:cloud_firestore/cloud_firestore.dart';

class Cards {
  final String id;
  final String petName;
  final Timestamp birthday;
  final String sex;
  final String specie;
  final String breed;
  final String weight;
  final String color;
  final String veterinarian;
  final String mchipId;
  final String creator;


  Cards({
    this.id,
    this.petName,
    this.birthday,
    this.sex,
    this.specie,
    this.breed,
    this.weight,
    this.color,
    this.veterinarian,
    this.mchipId,
    this.creator,
  });
}