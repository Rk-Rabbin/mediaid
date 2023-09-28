import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Widgets/insuranceHCard.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/functions/insurance.dart';
import 'package:mediaid_flutter/models/insurance_model.dart';
import 'package:mediaid_flutter/models/patient_model.dart';
import 'package:mediaid_flutter/pages/insurance_update.dart';
import 'package:mediaid_flutter/pages/patient_update.dart';
import 'package:mediaid_flutter/widgets/docHCard.dart';
import 'package:mediaid_flutter/widgets/patHcard.dart';
import '../functions/patient.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import '../pages/home/home.dart';



class InsurancePage extends StatefulWidget {
  InsurancePage();

  @override
  State<InsurancePage> createState() => _InsurancePageState();
}

class _InsurancePageState extends State<InsurancePage>{

  Insurance insuranceService = Insurance();


  @override
  Widget build(BuildContext context){
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text("Insurance List"),
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
              future: insuranceService.getAllinsurance(user),
              builder: (context, snapshot){
                // print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child:
                      Column( children:[
                      insuranceHCard(
                            name: snapshot.data![i]['name'],
                            number: snapshot.data![i]['number'],
                            address: snapshot.data![i]['address'],
                            policy: snapshot.data![i]['policy'],
                            id: snapshot.data![i]['id'], 
                          ),
                      if(snapshot.data![i]['users'].toString() == user.id.toString())
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  InsuranceModel? insurance_ = await getInsurance(user, snapshot.data![i]['id']);
                                  if (insurance_ == null) {
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
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => InsuranceUpdateForm(insurance: insurance_)));
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
                                    var b = await deleteInsurance(user, snapshot.data![i]['id']);
                                    if(b){
                                      showDialog(context: context, builder:(context) => AlertDialog(
                                        content: Text("Deleted Successfully"),)
                                      );
                                      await Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => InsurancePage(),
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
