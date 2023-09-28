import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Screens/AddPresc.dart';
import 'package:mediaid_flutter/Widgets/PresCard2.dart';
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/functions/prescription.dart';
import 'package:mediaid_flutter/models/prescription_model.dart';
import 'package:mediaid_flutter/pages/patient_update.dart';
import 'package:mediaid_flutter/pages/prescription_reg.dart';
import 'package:mediaid_flutter/pages/prescription_update.dart';
import 'package:mediaid_flutter/widgets/docHCard.dart';
import 'package:mediaid_flutter/widgets/patHcard.dart';
import '../functions/patient.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import 'doctor_update.dart';
import 'home/home.dart';



class PrescriptionPage extends StatefulWidget {
  PrescriptionPage();

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage>{

  Prescription prescriptionService = Prescription();

  List<PrescriptionModel> _prescriptionList = []; // Define the list to store prescriptions

  Future<List<PrescriptionModel>> getPrescriptions(User user) async {
    List<PrescriptionModel> prescriptions = [];
    var uri = Uri.parse("$baseUrl/prescriptionsAPI");

    var res = await http.get(uri, headers: {
      'Authorization': 'Token ${user.token}',
    });
    if (res.statusCode == 200) {
      var jsons = jsonDecode(res.body);
      for (var json in jsons) {
        if (json['users'] == user.id) {
          prescriptions.add(PrescriptionModel.fromJson(json));
        }
      }
    }
    return prescriptions;
  }

  Future<void> _fetchAndDisplayPrescriptions() async {
    User user = context.read<UserCubit>().state;
    try {
      List<PrescriptionModel> prescriptions = await getPrescriptions(user);

      setState(() {
        // Update the state with the fetched prescriptions
        _prescriptionList = prescriptions;
      });
    } catch (e) {
      // Handle errors, e.g., show an error message
      print('Error fetching prescriptions: $e');
    }
  }

  Future<void> _navigateToAddPresc() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrescriptionRegistrationForm(),
      ),
    );
    if (result != null && result is PrescriptionModel) {
      setState(() {
        // _prescriptionList.add(result);print("Number of prescriptions: ${_prescriptionList.length}");
      });
    }
  }

    @override
  void initState() {
    super.initState();

    // Call the function to fetch and display prescriptions when the page loads
    _fetchAndDisplayPrescriptions();
  }

  @override
  Widget build(BuildContext context){
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text("Prescription's List"),
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
      body: FutureBuilder<List<PrescriptionModel>>(
  future: getPrescriptions(user), // Call the getPrescriptions method
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // Show a loading indicator while fetching data
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else if (!snapshot.hasData) {
      return Center(
        child: Text('No prescriptions found.'),
      );
    } else {
      // Display the prescriptions using a ListView.builder
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final prescription = snapshot.data?[index];
          return Card(
            child: Column(
              children: [
                PresCard2(
                  image: prescription!.upload,
                  title: prescription.disease,
                  category: prescription.date,
                  details: prescription.hospital,
                  doctor: prescription.doctor.toString(),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                                  PrescriptionModel? prescription_ = await getPrescription(user,prescription.id);
                                  if (prescription_ == null) {
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
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrescriptionUpdateForm(prescription: prescription_)));
                                  }
                                },
                        child: Text("Update"),
                      ),
                      SizedBox(width: 10),
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
                                    var b = await deletePrescription(user, prescription.id);
                                    if(b){
                                      showDialog(context: context, builder:(context) => AlertDialog(
                                        content: Text("Deleted Successfully"),)
                                      );
                                      await Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => PrescriptionPage(),
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
                SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    }
  },
),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: _navigateToAddPresc,
            child: Icon(
              CupertinoIcons.plus_app_fill,
              color: Color(0xff32c1e0),
              size: 60,
            ),
          ),
        ),
      ),
    ); 
   }
}

