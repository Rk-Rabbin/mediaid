import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/models/patient_model.dart';
import 'package:mediaid_flutter/pages/patient_update.dart';
import 'package:mediaid_flutter/widgets/docHCard.dart';
import 'package:mediaid_flutter/widgets/patHcard.dart';
import '../functions/patient.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import 'doctor_update.dart';
import 'home/home.dart';



class PatientPage extends StatefulWidget {
  PatientPage();

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>{

  Patient patientService = Patient();


  @override
  Widget build(BuildContext context){
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text("Patient's List"),
      backgroundColor:Color(0xFF82BCC4),
            leading: IconButton(
    icon: Icon(Icons.home),
    onPressed: () {
      // Add your navigation logic here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  ),
      ),
      body: FutureBuilder<List>(
              future: patientService.getAllpatient(user),
              builder: (context, snapshot){
                // print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child:
                      Column( children:[
                      patHCard(
                            image: snapshot.data![i]['profilepic'] != null
                                ? snapshot.data![i]['profilepic'] // Pass the image URL as a String
                                : 'assets/head_sun_flower.png',
                            title: snapshot.data![i]['name'],
                            subtitle: snapshot.data![i]['blood'],
                            hospital: snapshot.data![i]['birthdate'],
                            number: snapshot.data![i]['number'],
                            // fees: snapshot.data![i]['insurance'],
                            fees: snapshot.data![i]['insurance'] == "-1"
                                ? "No Insurance available" // Pass the image URL as a String
                                : snapshot.data![i]['insurance'], 
                            id: snapshot.data![i]['id']     // Add number parameter
                          ),
                      // if(snapshot.data![i]['insurance'] == "-1")
                      //   Text('Insurance: No Insurance Available', style: TextStyle(fontSize: 15.0, color: Colors.black,),)
                      //   else
                      //   Text('Insurance: '+snapshot.data![i]['insurance'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      if(snapshot.data![i]['users'].toString() == user.id.toString())
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  PatientModel? patient_ = await getPatient(user, snapshot.data![i]['id']);
                                  if (patient_ == null) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 200,
                                            width: 250,
                                            decoration: BoxDecoration(),
                                            child: Text("Facing Difficulty to Fetch Information\nTry Again Later"),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PatientUpdateForm(patient: patient_)));
                                  }
                                },
                                child: Text("Update"),
                              ),
                              SizedBox(width: 10), // Add some spacing between the buttons
                              ElevatedButton(
                                onPressed: () async { // Show the confirmation dialog
                                  String a = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text("Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // User tapped "Confirm"
                                              Navigator.of(context).pop("confirm"); // Close the dialog
                                              // Add your delete logic here
                                            },
                                            child: Text("Confirm"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // User tapped "No"
                                              Navigator.of(context).pop("cancel"); // Close the dialog
                                            },
                                            child: Text("No"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (a == "confirm"){
                                    var b = await deletePatient(user, snapshot.data![i]['id']);
                                    if(b){
                                      showDialog(context: context, builder:(context) => AlertDialog(
                                        content: Text("Deleted Successfully"),)
                                      );
                                      await Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => PatientPage(),
                                      ));
                                    }else{
                                      showDialog(context: context, builder:(context) => AlertDialog(
                                        content: Text("Could not delete Something wnet wrong"),)
                                      );
                                      }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // Set button background color to red
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 5),
                                    Text("Delete", style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                     SizedBox(height: 10), // Add some spacing between the buttons
                    ])
                    );
                  }); 
                } else{
                  return const Center(
                    child: Text('No data found!!'),
                  );
                }
              },
            ),
    ); 
   }
}

