class AppointmentModel {
  int id;
  String doctor_name;
  String patient_name;
  String email;
  String phone;
  String disease;
  String expected_date;
  String expected_time;
  String requested_at;
  String payment;
  bool accepted;
  int doctor;
  int patient; // Assuming you have a UserModel

  AppointmentModel(
    this.id,
    this.doctor_name,
    this.patient_name,
    this.email,
    this.phone,
    this.disease,
    this.expected_date,
    this.expected_time,
    this.requested_at,
    this.payment,
    this.accepted,
    this.doctor,
    this.patient,
);

factory AppointmentModel.fromJson(Map<String, dynamic> json) {
  return AppointmentModel(
    json["id"],
    json["doctor_name"],
    json["patient_name"],
    json["email"],
    json["phone"],
    json["disease"],
    json["expected_date"],
    json["expected_time"],
    json["requested_at"],
    json["payment"],
    json["accepted"],
    json["doctor"],
    json["patient"],
  );
}


Map<String, dynamic> toJson() {
  return {
      "id": id,
      "doctor_name": doctor_name,
      "patient_name": patient_name,
      "email": email,
      "phone": phone,
      "disease": disease,
      "expected_date": expected_date,
      "expected_time": expected_time,
      "requested_at": requested_at,
      "payment": payment,
      "accepted": accepted,
      "doctor": doctor,
      "patient": patient,
  };
}

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "doctor_name": doctor_name,
      "patient_name": patient_name,
      "email": email,
      "phone": phone,
      "disease": disease,
      "expected_date": expected_date,
      "expected_time": expected_time,
      "requested_at": requested_at,
      "payment": payment,
      "accepted": accepted,
      "doctor": doctor,
      "patient": patient,
    };
  }
}