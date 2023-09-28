class PrescriptionModel {
  int id;
  String disease;
  String date;
  String hospital;
  String upload;
  String presctext;
  int users;
  int doctor;
  int patient; // Assuming you have a UserModel

  PrescriptionModel(
    this.id,
    this.disease,
    this.date,
    this.hospital,
    this.upload,
    this.presctext,
    this.users,
    this.doctor,
    this.patient,
);

factory PrescriptionModel.fromJson(Map<String, dynamic> json) {
  return PrescriptionModel(
    json["id"],
    json["disease"],
    json["date"],
    json["hospital"],
    json["upload"],
    json["presctext"],
    json["users"],
    json["doctor"],
    json["patient"],
  );
}


Map<String, dynamic> toJson() {
  return {
    "id": id,
    "disease": disease,
    "date": date,
    "hospital": hospital,
    "upload": upload,
    "presctext": presctext,
    "users": users,
    "doctor": doctor,
    "patient": patient,
  };
}

  Map<String, dynamic> toMap() {
    return {
    "id": id,
    "disease": disease,
    "date": date,
    "hospital": hospital,
    "upload": upload,
    "presctext": presctext,
    "users": users,
    "doctor": doctor,
    "patient": patient,
    };
  }
}