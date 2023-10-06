import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Widgets/buttons/backbutton.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
import 'package:mediaid_flutter/pages/doctor_update.dart';
// import 'package:mediaid_flutter/Widgets/docCard.dart';

import '../Widgets/docHomeCard.dart';
import '../functions/doctor.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import '../pages/home/home.dart';
import '../widgets/docHCard.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  Doctor doctorService = Doctor();

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Color(0xFF82BCC4),
        leading: IconButton(
    icon: Icon(Icons.home),
    onPressed: () {
      // Add your navigation logic here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  ),
        title: Row(
          children: [
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  'Top Doctors',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Icon(
                Icons.more_vert_rounded,
                color: Colors.black38,
                size: 25,
              ),
            )
          ],
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
                      // if (doctorList != null)
                        // for (int i = 0; i < doctorList.length; i++)
                          docHCard(
                            image: snapshot.data![i]['profilepic'] != null
                                ? snapshot.data![i]['profilepic'] // Pass the image URL as a String
                                : 'assets/head_sun_flower.png',
                            title: snapshot.data![i]['name'],
                            subtitle: snapshot.data![i]['speciality'],
                            hospital: snapshot.data![i]['hospital'],
                            number: snapshot.data![i]['number'],
                            fees: snapshot.data![i]['fees'],
                            id: snapshot.data![i]['id'],
                            start: snapshot.data![i]['start'],
                            end: snapshot.data![i]['end'],
                          ),
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
                                        builder: (context) => Doctors(),
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
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       SizedBox(height: 10,),
      //       FutureBuilder<List>(
      //         future: doctorService.getAllDoctor(user),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return CircularProgressIndicator();
      //           } else if (snapshot.hasError) {
      //             print('Error: ${snapshot.error}');
      //             return Text('Error: ${snapshot.error}');
      //           } else if (snapshot.hasData) {
      //             final doctorList = snapshot.data;
      //             return Column(
      //               children: [
      //                 if (doctorList != null)
      //                   for (int i = 0; i < doctorList.length; i++)
      //                     docHCard(
      //                       image: doctorList[i]['profilepic'] != null
      //                           ? doctorList[i]['profilepic'] // Pass the image URL as a String
      //                           : 'assets/head_sun_flower.png',
      //                       title: doctorList[i]['name'],
      //                       subtitle: doctorList[i]['speciality'],
      //                       hospital: doctorList[i]['hospital'],
      //                       number: doctorList[i]['number'],
      //                       fees: doctorList[i]['fees'], // Add number parameter
      //                     ),
      //                     if(doctorList[i]['users'].toString() == user.id.toString())
      //                   Center(
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
      //                       children: [
      //                         ElevatedButton(
      //                           onPressed: () async {
      //                             DoctorModel? doctor_ = await getDoctor(user, snapshot.data![i]['id']);
      //                             if (doctor_ == null) {
      //                               showDialog(
      //                                 context: context,
      //                                 builder: (context) {
      //                                   return Dialog(
      //                                     child: Container(
      //                                       alignment: Alignment.center,
      //                                       height: 200,
      //                                       width: 250,
      //                                       decoration: BoxDecoration(),
      //                                       child: Text("Facing Difficulty to Fetch Information\nTry Again Later"),
      //                                     ),
      //                                   );
      //                                 },
      //                               );
      //                             } else {
      //                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorUpdateForm(doctor: doctor_)));
      //                             }
      //                           },
      //                           child: Text("Update"),
      //                         ),
      //                         SizedBox(width: 10), // Add some spacing between the buttons
      //                         ElevatedButton(
      //                           onPressed: () async { // Show the confirmation dialog
      //                             String a = await showDialog(
      //                               context: context,
      //                               builder: (context) {
      //                                 return AlertDialog(
      //                                   title: Text("Confirm Delete"),
      //                                   content: Text("Are you sure you want to delete this item?"),
      //                                   actions: [
      //                                     TextButton(
      //                                       onPressed: () {
      //                                         // User tapped "Confirm"
      //                                         Navigator.of(context).pop("confirm"); // Close the dialog
      //                                         // Add your delete logic here
      //                                       },
      //                                       child: Text("Confirm"),
      //                                     ),
      //                                     TextButton(
      //                                       onPressed: () {
      //                                         // User tapped "No"
      //                                         Navigator.of(context).pop("cancel"); // Close the dialog
      //                                       },
      //                                       child: Text("No"),
      //                                     ),
      //                                   ],
      //                                 );
      //                               },
      //                             );
      //                             if (a == "confirm"){
      //                               var b = await deleteDoctor(user, snapshot.data![i]['id']);
      //                               if(b){
      //                                 showDialog(context: context, builder:(context) => AlertDialog(
      //                                   content: Text("Deleted Successfully"),)
      //                                 );
      //                                 await Future.delayed(Duration(seconds: 2));
      //                                 Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                                   builder: (context) => Doctors(),
      //                                 ));
      //                               }else{
      //                                 showDialog(context: context, builder:(context) => AlertDialog(
      //                                   content: Text("Could not delete Something wnet wrong"),)
      //                                 );
      //                                 }
      //                             }
      //                           },
      //                           style: ElevatedButton.styleFrom(
      //                             primary: Colors.red, // Set button background color to red
      //                           ),
      //                           child: Row(
      //                             children: [
      //                               Icon(
      //                                 Icons.delete,
      //                                 color: Colors.white,
      //                               ),
      //                               SizedBox(width: 5),
      //                               Text("Delete", style: TextStyle(color: Colors.white)),
      //                             ],
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //               ],
      //             );
      //           } else {
      //             return const Center(
      //               child: Text('No data found!!'),
      //             );
      //           }
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
