import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user_models.dart';
import '../models/doctor_model.dart';


createDoctor(User user, String name, String number, String gender, String licensenum, String hospital, String speciality, String qualification, String availability,
String start, String end, String fees, File imagefile) async {
  var uri = Uri.parse("$baseUrl/register/doctor/");
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
  request.fields['gender'] = gender;
  request.fields['start'] = start;
  request.fields['end'] = end;
  request.fields['fees'] = fees;
  request.fields['licensenum'] = licensenum; 
  request.fields['hospital'] = hospital;
  request.fields['speciality'] = speciality;
  request.fields['qualification'] = qualification;
  request.fields['availability'] = availability;
  final res = await request.send();
  if(res.statusCode == 200 || res.statusCode== 201){
    return true;
  }
  else{
    print(res.statusCode);
    return false;
  }
}






Future<bool> deleteDoctor(User user, int id) async {
  final uri = Uri.parse('$baseUrl/deleteUpdate/doctor/${id}/');
  var response = await http.delete(uri, headers: {'Authorization':'Token ${user.token}'});
  if (response.statusCode == 200 || response.statusCode==204) {
    print(response.statusCode);
    print(uri);
    return true;
  } else {
   print(response.statusCode);
       print(uri);

    return false;
  }
}



Future <DoctorModel?> getDoctor(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/doctor/${id}/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    var json = jsonDecode(res.body);
    var doctor = DoctorModel.fromJson(json);
    print(doctor);
    return doctor;
  } else {
    print(uri);
    print(res.statusCode);
    print(res.body);
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}


Future<bool> updateDoctor(User user, DoctorModel doctor, File imageFile) async {
  print("Update DOC : ");
  print(doctor.id);
  final uri = Uri.parse('$baseUrl/deleteUpdate/doctor/${doctor.id}/');
  final request = http.MultipartRequest('PUT', uri)
    ..headers['Authorization'] = 'Token ${user.token}'
    ..fields['id'] = "${doctor.id}"
    ..fields['users'] = "${user.id}"
    ..fields['name'] = doctor.name
    ..fields['number'] = doctor.number
    ..fields['gender'] = doctor.gender
    ..fields['start'] = doctor.start
    ..fields['end'] = doctor.end
    ..fields['fees'] = doctor.fees
    ..fields['licensenum'] = doctor.licensenum
    ..fields['hospital'] = doctor.hospital
    ..fields['speciality'] = doctor.speciality
    ..fields['qualification'] = doctor.qualification
    ..fields['availability'] = doctor.availability;
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


// All Doctors List
class Doctor{
Future<List> getAllDoctor(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/doctorsListAPI");
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

// Future<List<DoctorModel>> getDoctors(User user) async {
//   List<DoctorModel> doctors = [];
//   var uri = Uri.parse("$baseUrl/doctorsListAPI");

//   var res = await http.get(uri, headers: {
//     'Authorization': ' Token ${user.token}',
//   });
//   // print(res.body);
//   // print(json);
//   if (res.statusCode == 200) {
//     var jsons = jsonDecode(res.body);
//     for (var json in jsons) {
//       doctors.add(DoctorModel.fromJson(json));
//     }
//   }
//   print(res.statusCode);
//   print(doctors);
//   return doctors;
// }