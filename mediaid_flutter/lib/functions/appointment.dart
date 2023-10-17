import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mediaid_flutter/models/appointment_model.dart';
import 'package:mediaid_flutter/models/comission_model.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
import 'package:mediaid_flutter/models/fees_model.dart';
import '../constants.dart';
import '../models/user_models.dart';



Future<String> getDoctorFees(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/doctor/${id}/");
  var res = await http.get(uri, headers: {'Authorization': 'Token ${user.token}'});
  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);
    print("Received JSON data 1: $json");
    var doctor = DoctorFeesModel.fromJson(json);
    return doctor.fees.toString(); // Convert the fees to a string
  } else {
    print(uri);
    print(res.statusCode);
    print(res.body);
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}


Future<bool> checkPatient(User user, String userId) async {
  try {
    var uri = Uri.parse("$baseUrl/patientsListAPI");
    var response = await http.get(uri, headers: {
      'Authorization': 'Token ${user.token}'
    });

    if (response.statusCode == 200) {
      List<dynamic> patientList = jsonDecode(response.body);

      // Debugging: Print the patientList and userId
      print("Received patientList: $patientList");
      print("Searching for userId: $userId");

      // Check if userId exists in the patientList
      bool userExists = patientList.any((patient) {
        int userIdAsNumber = int.tryParse(userId) ?? -1;
        return patient['id'] == userIdAsNumber;
      });

      // Debugging: Print the result
      print("User exists: $userExists");

      return userExists;
    } else {
      return false; // Server returned an error
    }
  } catch (e) {
    // Debugging: Print any errors
    print("Error in checkPatient: $e");
    return false; // Error occurred during the request
  }
}


Future<ComissionModel?> getDoctorComission(User user, int doctorId) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/comission/${doctorId}/");
  var res = await http.get(uri, headers: {'Authorization': 'Token ${user.token}'});

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);
    return ComissionModel.fromJson(json);
  } else {
    return null;
  }
}


Future<bool> createCommission(
    User user, int doctor) async {
  // Step 1: Get the current commission
  ComissionModel? commission = await getDoctorComission(user, doctor);
  String fees = await getDoctorFees(user, doctor);

  
  if (commission != null) {
    // Step 2: Update patient number and total earnings
    commission.patient_num += 1;
    commission.total_earnings += int.parse(fees);

    // Step 3: Send a PUT request to update the commission on the server
    bool updateSuccessful = await updateComission(user, doctor, commission);

    if (updateSuccessful) {
      return true; // Commission updated successfully
    }
  }

  // Handle the cases where the commission couldn't be retrieved or updated
  return false;
}



Future<bool> updateComission(User user, int doctor, ComissionModel commission) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/comission/${doctor}/");
  var body = jsonEncode(commission.toJson());

  var headers = {
    'Authorization': 'Token ${user.token}',
    'Content-Type': 'application/json',
  };

  var res = await http.put(uri, headers: headers, body: body);

  if (res.statusCode == 200) {
    return true; // Commission updated successfully
  } else {
    // Handle the case where the commission couldn't be updated
    return false;
  }
}


createAppointment(User user, String doctor_name, String patient_name, String phone,
    String disease, String expected_date, String expected_time, String payment, String doctor, String patient) async {
  int doc = int.parse(doctor);
  int pat = int.parse(patient);
  print(expected_date);
  final now = DateTime.now();
  final formatter = DateFormat('yyyy-MM-dd HH:mm:ss'); // You can adjust the format
  final formattedDate = formatter.format(now);

  final patientExists = await checkPatient(user, patient);

  if (!patientExists) {
    // Handle the case where the doctor or patient ID does not exist
    print('Patient ID does not exist.');
    return false;
  }
  var uri = Uri.parse("$baseUrl/register/appointment/");
  final request = http.MultipartRequest('POST', uri);
  final headers = {
    'Authorization': 'Token ${user.token}',
  };

  // Set the headers on the request
  request.headers.addAll(headers);

  // Add the image file to the request
  request.fields['doctor_name'] = doctor_name;
  request.fields['patient_name'] = patient_name;
  request.fields['email'] = user.email.toString();
  request.fields['phone'] = phone;
  request.fields['disease'] = disease;
  request.fields['expected_date'] = expected_date;
  request.fields['expected_time'] = expected_time;
  request.fields['payment'] = payment;
  request.fields['requested_at'] = formattedDate;
  request.fields['accepted'] = "false";
  request.fields['doctor'] = doctor;
  request.fields['patient'] = patient;
  print(request);
  final res = await request.send();
  if (res.statusCode == 200 || res.statusCode == 201) {
    if(payment == 'On-Site'){
      bool commissionCreated = await createCommission(user, doc); // You need to pass the correct values for patient_num and total_earnings
    if (commissionCreated) {
      print("comission created");
      return true; // Both appointment and commission created successfully
    }
    return true;
    // Handle the success case
  } else {
    return false;
    // Handle the failure case
  }
}
}





Future<bool> deleteAppointment(User user, int id) async {
  print(id);
  final uri = Uri.parse('$baseUrl/deleteUpdate/appointment/${id}/');
  var response = await http.delete(uri, headers: {'Authorization':'Token ${user.token}'});
  if (response.statusCode == 200 || response.statusCode==204) {
    print(response.statusCode);
    return true;
  } else {
   print(response.statusCode);
    return false;
  }
}



Future <AppointmentModel?> getAppointment(User user, int id) async {
  var uri = Uri.parse("$baseUrl/deleteUpdate/appointment/$id/");
  var res = await http.get(uri, headers: {'Authorization':'Token ${user.token}'});
  if(res.statusCode == 200){
    var json = jsonDecode(res.body);
    var patient = AppointmentModel.fromJson(json);
    return patient;
  } else {
    throw Exception('Server Error'); // Throw an exception instead of returning a string
  }
}






Future<bool> updateAppointment(User user, AppointmentModel appointment) async {
  print("Update PAT : ");
  final uri = Uri.parse('$baseUrl/deleteUpdate/appointment/${appointment.id}/');
  final request = http.MultipartRequest('PUT', uri)
    ..headers['Authorization'] = 'Token ${user.token}'
    ..fields['id'] = "${appointment.id}"
    ..fields['doctor_name'] = appointment.doctor_name
    ..fields['patient_name'] = appointment.patient_name
    ..fields['email'] = appointment.email
    ..fields['phone'] = appointment.phone
    ..fields['disease'] = appointment.disease
    ..fields['expected_date'] = appointment.expected_date
    ..fields['expected_time'] = appointment.expected_time
    ..fields['payment'] = appointment.payment
    ..fields['requested_at'] = appointment.requested_at
    ..fields['accepted'] = "false"
    ..fields['doctor'] = appointment.doctor.toString()
    ..fields['patient'] = appointment.patient.toString();

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
class Appointment{
Future<List> getAllappointment(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/appointmentsListAPI");
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