import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Screens/Doctors.dart';
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

class Search extends StatefulWidget {
  final String searchText;

  Search({required this.searchText});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
                  'Search Results',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: Icon(
            //     Icons.more_vert_rounded,
            //     color: Colors.black38,
            //     size: 25,
            //   ),
            // )
          ],
        ),
      ),
      body: FutureBuilder<List>(
  future: doctorService.getAllDoctor(user),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final doctorList = snapshot.data;
      
      // Null check added here
      if (doctorList != null) {
        // Filter the doctorList based on the searchText
        final filteredDoctors = doctorList.where((doctor) {
          final doctorName = doctor['name'].toString().toLowerCase();
          final doctorSpeciality = doctor['speciality'].toString().toLowerCase();
          final searchText = widget.searchText.toLowerCase();
          return doctorName.contains(searchText) || doctorSpeciality.contains(searchText);
        }).toList();

        if (filteredDoctors.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No doctors found for the search query visit Doctor's list"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Doctors()),
                    );
                  },
                  child: Text('Go Back to Doctors List'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredDoctors.length,
          itemBuilder: (context, i) {
          return Card(
            child: Column(
              children: [
                docHCard(
                  image: filteredDoctors[i]['profilepic'] != null
                      ? filteredDoctors[i]['profilepic']
                      : 'assets/head_sun_flower.png',
                  title: filteredDoctors[i]['name'],
                  subtitle: filteredDoctors[i]['speciality'],
                  hospital: filteredDoctors[i]['hospital'],
                  number: filteredDoctors[i]['number'],
                  fees: filteredDoctors[i]['fees'],
                  id: filteredDoctors[i]['id'],
                ),
                if (filteredDoctors[i]['users'].toString() == user.id.toString())
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            DoctorModel? doctor_ =
                                await getDoctor(user, filteredDoctors[i]['id']);
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
                                      child: Text(
                                          "Facing Difficulty to Fetch Information\nTry Again Later"),
                                    ),
                                  );
                                },
                              );
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorUpdateForm(doctor: doctor_)));
                            }
                          },
                          child: Text("Update"),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            String a = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Confirm Delete"),
                                  content:
                                      Text("Are you sure you want to delete this item?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop("confirm");
                                      },
                                      child: Text("Confirm"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop("cancel");
                                      },
                                      child: Text("No"),
                                    ),
                                  ],
                                );
                              },
                            );
                            if (a == "confirm") {
                              var b =
                                  await deleteDoctor(user, filteredDoctors[i]['id']);
                              if (b) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Text("Deleted Successfully"),
                                        ));
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => Doctors(),
                                    ));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Text("Could not delete. Something went wrong."),
                                        ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
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
      } else {
        return const Center(
          child: Text('No data found!!'),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  },
),
    );
  }
}
