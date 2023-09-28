import 'dart:io';
import 'package:mediaid_flutter/models/user_models.dart';


class InsuranceModel {
  int id;
  String name;
  String number;
  String address; 
  String policy;
  int users;

  InsuranceModel(
    this.id,
    this.name,
    this.number,
    this.address,
    this.policy,
    this.users
  );

  factory InsuranceModel.fromJson(Map json) {
    return InsuranceModel(
      json["id"],
      json["name"],
      json["number"],
      json["address"],
      json["policy"],
      json["users"],
    );
  }
  
  Map<String, String> toJson() {
    return {
      "id": "$id",
      "name": name,
      "number": number,
      "address": address,
      "policy": policy,
      "users": "$users",
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "id": "$id",
      "name": name,
      "number": number,
      "address": address,
      "policy": policy,
      "users": "$users",
    };
  }
}