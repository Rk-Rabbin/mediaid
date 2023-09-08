import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user_models.dart';


createDoctor(User user, String name, String number, String gender, String licensenum, String hospital, String speciality, String qualification, String availability,
String start, String end, String fees) async {
  var uri = Uri.parse("$baseUrl/register/doctor/");
   Map data = {
     "users":"${user.id}", "name":name, "gender":gender, "number":number, "start":start, "end":end, "fees":fees, "licensenum":licensenum,
     "hospital":hospital, "speciality":speciality, "qualification":qualification, "availability":availability
    };
  print(data);
   var res = await http.post(uri, body: data, headers: {
    'Authorization': ' Token ${user.token}',
  });
  if(res.statusCode == 200 || res.statusCode== 201){
    return true;
  }
  else{
    print(res.statusCode);
    return false;
  }
}

updateDoctor(User user,int id, String name, String number, String start, String end, String fees, String licensenum, String hospital, String speciality,
String qualification, String availability) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/doctor/$id/");
  Map data = {
     "name":name, "number":number, "start":start, "end":end, "fees":fees, "licensenum":licensenum,
     "hospital":hospital, "speciality":speciality, "qualification":qualification, "availability":availability
    };
  var res = await http.put(uri, body:data, headers: {'Authorization':'Token ${user.token}'});
}

deleteDoctor(User user,int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/doctor/$id/");
  var res = await http.delete(uri, headers: {'Authorization':'Token ${user.token}'});
}
getDoctor(){}

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
