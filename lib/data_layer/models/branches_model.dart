import 'package:cloud_firestore/cloud_firestore.dart';

class BranchesDataModel {
  String? branch;
  String? customNo;
  String? arabicName;
  String? arabicDescription;
  String? englishName;
  String? englishDescription;
  String? note;
  String? address;
  Timestamp? timestamp;


  BranchesDataModel({
    this.branch,
    this.customNo,
    this.arabicName,
    this.arabicDescription,
    this.englishName,
    this.englishDescription,
    this.note,
    this.address,
    this.timestamp
  });

  BranchesDataModel.fromJson(Map<String, dynamic> json) {
    branch = json['branch'];
    customNo = json['customNo'];
    arabicName = json['arabicName'];
    arabicDescription = json['arabicDescription'];
    englishName = json['englishName'];
    englishDescription = json['englishDescription'];
    note = json['note'];
    address = json['address'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'branch': branch,
      'customNo': customNo,
      'arabicName': arabicName,
      'arabicDescription': arabicDescription,
      'englishName': englishName,
      'englishDescription': englishDescription,
      'note': note,
      'address': address,
      'timestamp': timestamp,
    };
  }
}
