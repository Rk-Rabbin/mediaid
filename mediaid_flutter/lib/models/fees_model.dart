class DoctorFeesModel {
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
  String percentage;
  String? profilepic;
  int users;

  DoctorFeesModel(
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
    this.percentage,
    this.profilepic,
    this.users
  );

  factory DoctorFeesModel.fromJson(Map json) {
    return DoctorFeesModel(
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
      json["percentage"],
      json["profilepic"],
      json["users"],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      "id": "$id",
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
      "percentage": percentage,
      "profilepic": profilepic,
      "users": "$users",

    };
  }

  Map<String, dynamic> toMap() {
    return {
      "id": "$id",
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
      "percentage": percentage,
      "profilepic": profilepic,
      "users": "$users",
    };
  }
}