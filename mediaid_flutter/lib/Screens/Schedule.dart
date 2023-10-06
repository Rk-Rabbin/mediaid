import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Widgets/ScheduleCard.dart';
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/appointment.dart';
import 'package:mediaid_flutter/models/appointment_model.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';

class Schedules extends StatefulWidget {
  Schedules();

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  Appointment appService = Appointment();

  List<AppointmentModel> _appointmentlist = [];

  Future<int?> getDoctorIdForUser(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/doctorsListAPI");
      var response = await http.get(uri, headers: {
        'Authorization': 'Token ${user.token}'
      });
      if (response.statusCode == 200) {
        List<dynamic> doctorList = jsonDecode(response.body);

        // Find the doctor associated with the user
        for (var doctorData in doctorList) {
          if (doctorData['users'] == user.id) {
            return doctorData['id']; // Return the doctor ID
          }
        }
      }
      return null; // Return null if no doctor is found or there's a server error
    } catch (e) {
      return null; // Return null in case of an error
    }
  }

  Future<int?> getPatientIdForUser(User user) async {
    try {
      var uri = Uri.parse("$baseUrl/patientsListAPI");
      var response = await http.get(uri, headers: {
        'Authorization': 'Token ${user.token}'
      });
      if (response.statusCode == 200) {
        List<dynamic> patientList = jsonDecode(response.body);

        // Find the patient associated with the user
        for (var patientData in patientList) {
          if (patientData['users'] == user.id) {
            return patientData['id']; // Return the patient ID
          }
        }
      }
      return null; // Return null if no patient is found or there's a server error
    } catch (e) {
      return null; // Return null in case of an error
    }
  }

Future<List<AppointmentModel>> getAppointments(User user) async {
  // List<AppointmentModel> appointments = [];
  int? doctorId = await getDoctorIdForUser(user);
  int? patientId = await getPatientIdForUser(user);
  print('Doctor ID: $doctorId');
  print('Patient ID: $patientId');

  if (doctorId == null && patientId == null) {
    return _appointmentlist;
  }

  var uri = Uri.parse("$baseUrl/appointmentsListAPI");
  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    var jsons = jsonDecode(res.body);
    print('JSON Response: $jsons');
    if (doctorId != null) {
      print('Filtering for Doctor ID: $doctorId');
      for (var json in jsons) {
  print('Doctor ID in JSON: ${json['doctor']}');
  print('Comparison Result: ${json['doctor'] == doctorId}');
  if (json['doctor'] == doctorId) {
    print("hello");
try {
  _appointmentlist.add(AppointmentModel.fromJson(json));
} catch (e) {
  print('Error parsing JSON: $e');
}
  }
}
    }
    if (patientId != null) {
      print('Filtering for Patient ID: $patientId');
      for (var json in jsons) {
        print('Patient ID in JSON: ${json['patient']}');
        if (json['patient'] == patientId) {
try {
  _appointmentlist.add(AppointmentModel.fromJson(json));
} catch (e) {
  print('Error parsing JSON: $e');
}
        }
      }
    }
  } else {
    print("HTTP Error: ${res.statusCode}");
  }
    print('Appointments: $_appointmentlist');
  return _appointmentlist;
}




Future<void> _fetchAndDisplayAppointments() async {
  User user = context.read<UserCubit>().state;
  try {
    List<AppointmentModel> appointments = await getAppointments(user);

    setState(() {
      // Clear the list before adding new appointments
      _appointmentlist.clear();
      _appointmentlist.addAll(appointments);
    });
  } catch (e) {
    print('Error fetching appointments: $e');
  }
}

@override
Widget build(BuildContext context) {
  User user = context.read<UserCubit>().state;

  return Scaffold(
    appBar: AppBar(
      title: Text("Appointment's List"),
      backgroundColor: Color(0xFF82BCC4),
      leading: IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
      ),
    ),
    body: FutureBuilder<List<AppointmentModel>>(
      future: getAppointments(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(
            child: Text('No appointments found.'),
          );
        } else {
          // Debug prints to check the contents of _appointmentlist
          print("_appointmentlist length: ${_appointmentlist.length}");
          for (final appointment in _appointmentlist) {
            print("Doctor Name: ${appointment.doctor_name}");
            print("Expected Date: ${appointment.expected_date}");
          }

          return ListView.builder(
            itemCount: _appointmentlist.length,
            itemBuilder: (context, index) {
              final appointment = _appointmentlist[index];
              return Card(
                child: Column(
                  children: [
                    ScheduleCard(
                      disease: appointment.disease,
                      expected_date: appointment.expected_date,
                      expected_time: appointment.expected_time,
                      requested_at: appointment.requested_at,
                      accepted: appointment.accepted,
                      name: appointment.doctor_name,
                      id: appointment.id,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            },
          );
        }
      },
    ),
  );
}
}
