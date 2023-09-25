import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user_models.dart';
import '../models/patient_model.dart';


createPatient(User user, String name, String number, String insurance, DateTime birthdate, String bd, String blood, String gender, String medications, String disease,
String allergy, File imagefile) async {
  var uri = Uri.parse("$baseUrl/register/patient/");
  final request = http.MultipartRequest('POST', uri);
  final headers = {
    'Authorization': ' Token ${user.token}',
  };

  // Set the headers on the request
  request.headers.addAll(headers);

  // Add the image file to the request
  final image = await http.MultipartFile.fromPath('profilepic', imagefile.path);
  request.files.add(image);
  request.fields['users'] = "${user.id}";
  request.fields['name'] = name;
  request.fields['number'] = number;
  request.fields['insurance'] = insurance;
  // request.fields['birthdate'] = birthdate.toIso8601String();
  request.fields['birthdate'] = bd;
  request.fields['blood'] = blood;
  request.fields['gender'] = gender;
  request.fields['medications'] = medications; 
  request.fields['disease'] = disease;
  request.fields['allergy'] = allergy;
  final res = await request.send();
  if(res.statusCode == 200 || res.statusCode== 201){
    print(request.fields);
    return true;
  }
  else{
    print(res.statusCode);
    print(request.fields);
    return false;
  }
}


Future<bool> deletePatient(User user, int id) async {
  final uri = Uri.parse('$baseUrl/deleteUpdate/patient/${id}/');
  var response = await http.delete(uri, headers: {'Authorization':'Token ${user.token}'});
  if (response.statusCode == 200 || response.statusCode==204) {
    print(response.statusCode);
    return true;
  } else {
   print(response.statusCode);
    return false;
  }
}



Future <PatientModel?> getPatient(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/patient/$id/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    var json = jsonDecode(res.body);
    var patient = PatientModel.fromJson(json);
    return patient;
  } else {
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}


Future<bool> updatePatient(User user, PatientModel patient, File imageFile) async {
  print("Update PAT : ");
  print(patient.id);
  final uri = Uri.parse('$baseUrl/deleteUpdate/patient/${patient.id}/');
  final request = http.MultipartRequest('PUT', uri)
    ..headers['Authorization'] = 'Token ${user.token}'
    ..fields['id'] = "${patient.id}"
    ..fields['users'] = "${user.id}"
    ..fields['name'] = patient.name
    ..fields['number'] = patient.number
    ..fields['gender'] = patient.gender
    ..fields['insurance'] = patient.insurance
    ..fields['birthdate'] = patient.birthdate
    ..fields['blood'] = patient.blood
    ..fields['medications'] = patient.medications
    ..fields['disease'] = patient.disease
    ..fields['allergy'] = patient.allergy;
    // Add other fields similarly
    if (imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath('profilepic', imageFile.path));
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
class Patient{
Future<List> getAllpatient(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/patientsListAPI");
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