import 'dart:io';

class DoctorModel {
  int id;
  String name;
  String number;
  String gender; 
  String licensenum;
  String hospital; 
  String speciality;
  String qualification;
  String availability;
  String start; 
  String end; 
  String fees; 
  String profilepic;

  DoctorModel(
    this.id,
    this.name,
    this.number,
    this.gender,
    this.licensenum,
    this.hospital,
    this.speciality,
    this.qualification,
    this.availability,
    this.start,
    this.end,
    this.fees,
    this.profilepic,
  );

  factory DoctorModel.fromJson(Map json) {
    return DoctorModel(
      json["id"],
      json["name"],
      json["number"],
      json["gender"],
      json["licensenum"],
      json["hospital"],
      json["speciality"],
      json["qualification"],
      json["availability"],
      json["start"],
      json["end"],
      json["fees"],
      json["profilepic"],
    );
  }
  
  Map<String, String> toJson() {
    return {
      "id": "$id",
      // "author": "${author.id}",
      "name": name,
      "number": number,
      "gender": gender,
      "licensenum": licensenum,
      "hospital": hospital,
      "speciality": speciality,
      "qualification": qualification,
      "availability": availability,
      "start": start,
      "end": end,
      "fees": fees,
      "profilepic": profilepic,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "id": "$id",
      // "author": "${author.id}",
      "name": name,
      "number": number,
      "gender": gender,
      "licensenum": licensenum,
      "hospital": hospital,
      "speciality": speciality,
      "qualification": qualification,
      "availability": availability,
      "start": start,
      "end": end,
      "fees": fees,
      "profilepic": profilepic,
    };
  }
}