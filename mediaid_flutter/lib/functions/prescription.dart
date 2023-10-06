import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:mediaid_flutter/Screens/Prescription.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/functions/patient.dart';
import 'package:mediaid_flutter/models/prescription_model.dart';
import '../constants.dart';
import '../models/user_models.dart';
import '../models/patient_model.dart';


createPrescription(User user, String disease, String date, String hospital, String presctext,
    String doctor, String patient, File imagefile) async {
  // Check if the doctor and patient IDs exist
  int doc = int.parse(doctor);
  int pat = int.parse(patient);

  final doctorExists = await checkDoctor(user,doc);
  final patientExists = await checkPatient(user, pat);

  if (!doctorExists || !patientExists) {
    // Handle the case where the doctor or patient ID does not exist
    print('Doctor or patient ID does not exist.');
    return false;
  }

  var uri = Uri.parse("$baseUrl/register/prescription/");
  final request = http.MultipartRequest('POST', uri);
  final headers = {
    'Authorization': 'Token ${user.token}',
  };

  // Set the headers on the request
  request.headers.addAll(headers);

  // Add the image file to the request
  final image = await http.MultipartFile.fromPath('upload', imagefile.path);
  request.files.add(image);
  request.fields['users'] = "${user.id}";
  request.fields['disease'] = disease;
  request.fields['date'] = date;
  request.fields['hospital'] = hospital;
  request.fields['presctext'] = presctext;
  request.fields['doctor'] = doctor;
  request.fields['patient'] = patient;

  final res = await request.send();
  if (res.statusCode == 200 || res.statusCode == 201) {
    print(request.fields);
    return true;
    // Handle the success case
  } else {
    print(res.statusCode);
    print(request.fields);
    return false;
    // Handle the failure case
  }
}

Future <bool> checkDoctor(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/doctor/${id}/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    return true;
  } else {
    // throw Exception('Server Error');
    return false;
 // Throw an exception instead of returning a string
  }
}

Future<bool> checkPatient(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/patient/${id}/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    return true;
  } else {
      return false;
    // throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}



Future<bool> deletePrescription(User user, int id) async {
  final uri = Uri.parse('$baseUrl/deleteUpdate/prescription/${id}/');
  var response = await http.delete(uri, headers: {'Authorization':'Token ${user.token}'});
  if (response.statusCode == 200 || response.statusCode==204) {
    print(response.statusCode);
    return true;
  } else {
   print(response.statusCode);
    return false;
  }
}



Future <PrescriptionModel?> getPrescription(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/prescription/$id/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    var json = jsonDecode(res.body);
    var patient = PrescriptionModel.fromJson(json);
    return patient;
  } else {
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}






Future<bool> updatePrescription(User user, PrescriptionModel prescription, File imageFile) async {
  print("Update PAT : ");
  print(prescription.id);
  final uri = Uri.parse('$baseUrl/deleteUpdate/prescription/${prescription.id}/');
  final request = http.MultipartRequest('PUT', uri)
    ..headers['Authorization'] = 'Token ${user.token}'
    ..fields['id'] = "${prescription.id}"
    ..fields['users'] = "${user.id}"
    ..fields['disease'] = prescription.disease
    ..fields['date'] = prescription.date
    ..fields['hospital'] = prescription.hospital
    ..fields['presctext'] = prescription.presctext
    ..fields['doctor'] = "${prescription.doctor}"
    ..fields['patient'] = "${prescription.patient}";
    // Add other fields similarly
    if (imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath('upload', imageFile.path));
  }
    // ..files.add(await http.MultipartFile.fromPath('profilepic', imageFile.path));
  final response = await request.send();

  if (response.statusCode == 200 || response.statusCode==201) {
    print(response.statusCode);
    return true;
  } else {
   print(response.statusCode);
    return false;
  }
}


// All patients List
class Prescription{
Future<List> getAllprescription(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/prescriptionsAPI");
      var response = await http.get(uri, headers: {
        'Authorization':'Token ${user.token}'
      });
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      } else{
        return Future.error('Server Error');
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}