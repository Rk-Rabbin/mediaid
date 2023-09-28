import 'dart:io';
import 'package:mediaid_flutter/models/user_models.dart';

class PatientModel {
  int id;
  String name;
  String number;
  String insurance;
  String birthdate;
  String blood;
  String gender;
  String medications;
  String disease;
  String allergy;
  String profilepic;
  int users; // Assuming you have a UserModel

  PatientModel(
    this.id,
    this.name,
    this.number,
    this.insurance,
    this.birthdate,
    this.blood,
    this.gender,
    this.medications,
    this.disease,
    this.allergy,
    this.profilepic,
    this.users, // Include UserModel
);

factory PatientModel.fromJson(Map<String, dynamic> json) {
  return PatientModel(
    json["id"],
    json["name"],
    json["number"],
    json["insurance"],
    json["birthdate"],
    json["blood"],
    json["gender"],
    json["medications"],
    json["disease"],
    json["allergy"],
    json["profilepic"],
    json["users"]
  );
}


Map<String, dynamic> toJson() {
  return {
    "id": id,
    "name": name,
    "number": number,
    "gender": gender,
    "insurance": insurance,
    "birthdate": birthdate,
    "blood": blood,
    "medications": medications,
    "disease": disease,
    "allergy": allergy,
    "profilepic": profilepic,
    "users": users
  };
}

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      // "users": users.toMap(), // Assuming User class has a toMap method
      "name": name,
      "number": number,
      "gender": gender,
      "insurance": insurance,
      "birthdate": birthdate,
      "blood": blood,
      "medications": medications,
      "disease": disease,
      "allergy": allergy,
      "profilepic": profilepic,
      "users": users
    };
  }
}