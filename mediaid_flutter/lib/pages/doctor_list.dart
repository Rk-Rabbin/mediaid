import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import 'doctor_update.dart';
import 'home/home.dart';



class DoctorPage extends StatefulWidget {
  DoctorPage();

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage>{

  Doctor doctorService = Doctor();


  @override
  Widget build(BuildContext context){
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text("Doctor's List"),
      backgroundColor:Color(0xff82bcc4),
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
              future: doctorService.getAllDoctor(user),
              builder: (context, snapshot){
                // print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child:
                      Column( children:[
                      if (snapshot.data![i]['profilepic'] != null)
                        Image.network(
                          snapshot.data![i]['profilepic'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      else
                        Image.asset("assets/head_sun_flower.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            ),
                        // Text('No profile picture available'),
                      ListTile(
                        title: Text('Name: '+snapshot.data![i]['name'], style: TextStyle(fontSize: 20.0, color: Colors.black,),
                        ),
                        subtitle: Text('Number: '+snapshot.data![i]['number'], style: TextStyle(fontSize: 15.0, color: Colors.black,),
                        ),  
                      ),
                      Text('Hospital: '+snapshot.data![i]['hospital'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      Text('Speciality: '+snapshot.data![i]['speciality'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      Text('Start: '+snapshot.data![i]['start'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      Text('End: '+snapshot.data![i]['end'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      Text('Fees: '+snapshot.data![i]['fees'], style: TextStyle(fontSize: 15.0, color: Colors.black,),),
                      if(snapshot.data![i]['users'].toString() == user.id.toString())
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  DoctorModel? doctor_ = await getDoctor(user, snapshot.data![i]['id']);
                                  if (doctor_ == null) {
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
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorUpdateForm(doctor: doctor_)));
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
                                    var b = await deleteDoctor(user, snapshot.data![i]['id']);
                                    if(b){
                                      showDialog(context: context, builder:(context) => AlertDialog(
                                        content: Text("Deleted Successfully"),)
                                      );
                                      await Future.delayed(Duration(seconds: 2));
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => DoctorPage(),
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

                      //   ElevatedButton(
                      //     onPressed: () async {
                      //       DoctorModel? doctor_ = await getDoctor(user, snapshot.data![i]['id']);
                      //       if(doctor_ == null){
                      //         showDialog(
                      //           context: context,
                      //           builder: (context) {
                      //             return Dialog(
                      //               child: Container(
                      //                   alignment: Alignment.center,
                      //                   height: 200,
                      //                   width: 250,
                      //                   decoration: BoxDecoration(),
                      //                   child: Text("facing Difficulty to fetch information\nTry Again Later")),
                      //             );
                      //           },
                      //         );
                      //       }else{
                      //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorUpdateForm(doctor: doctor_)));
                      //       }
                      //     },
                      //     child: Text("Update"),
                      //   ),
                      //   SizedBox(
                      //     height: 10,
                      //   ),
                      //   ElevatedButton(
                      //           onPressed: () {
                      //             // Add code to delete the item here
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             primary: Colors.red, // Set button background color to red
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Icon(
                      //                 Icons.delete,
                      //                 color: Colors.white,
                      //               ),
                      //               SizedBox(width: 5), // Add some spacing between icon and text
                      //               Text("Delete", style: TextStyle(color: Colors.white)),
                      //             ],
                      //           ),
                      //   ),
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