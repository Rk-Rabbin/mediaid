import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user_models.dart';
import '../models/insurance_model.dart';


createInsurance(User user, String name, String number, String address, String policy) async {
  var uri = Uri.parse("$baseUrl/register/insurance/");
  final request = http.MultipartRequest('POST', uri);
  final headers = {
    'Authorization': ' Token ${user.token}',
  };

  // Set the headers on the request
  request.headers.addAll(headers);

  // Add the image file to the request
  request.fields['users'] = "${user.id}";
  request.fields['name'] = name;
  request.fields['number'] = number;
  request.fields['address'] = address;
  request.fields['policy'] = policy;
  final res = await request.send();
  if(res.statusCode == 200 || res.statusCode== 201){
    return true;
  }
  else{
    print(res.statusCode);
    return false;
  }
}






Future<bool> deleteInsurance(User user, int id) async {
  final uri = Uri.parse('$baseUrl/deleteUpdate/insurance/${id}/');
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



Future <InsuranceModel?> getInsurance(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/insurance/${id}/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    var json = jsonDecode(res.body);
    var doctor = InsuranceModel.fromJson(json);
    return doctor;
  } else {
    print(uri);
    print(res.statusCode);
    print(res.body);
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}


Future<bool> updateInsurance(User user, InsuranceModel doctor) async {
  print("Update DOC : ");
  print(doctor.id);
  final uri = Uri.parse('$baseUrl/deleteUpdate/insurance/${doctor.id}/');
  final request = http.MultipartRequest('PUT', uri)
    ..headers['Authorization'] = 'Token ${user.token}'
    ..fields['id'] = "${doctor.id}"
    ..fields['users'] = "${user.id}"
    ..fields['name'] = doctor.name
    ..fields['number'] = doctor.number
    ..fields['address'] = doctor.address
    ..fields['policy'] = doctor.policy;
    // Add other fields similarly
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
class Insurance{
Future<List> getAllinsurance(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/insurancesAPI");
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