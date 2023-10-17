class ComissionModel {
  int id;
  int patient_num;
  String percentage;
  int total_earnings;
  int doctor;

  ComissionModel(
    this.id,
    this.patient_num,
    this.percentage,
    this.total_earnings,
    this.doctor,
);

factory ComissionModel.fromJson(Map<String, dynamic> json) {
  return ComissionModel(
    json["id"],
    json["patient_num"],
    json["percentage"],
    json["total_earnings"],
    json["doctor"],
  );
}


Map<String, dynamic> toJson() {
  return {
      "id": id,
      "doctor": doctor,
      "patient_num": patient_num,
      "percentage": percentage,
      "total_earnings": total_earnings,
  };
}
}