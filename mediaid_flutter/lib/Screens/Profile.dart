import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Widgets/diagnosis.dart';
import 'package:mediaid_flutter/Widgets/diagnosisSmaller.dart';

import '../Widgets/buttons/ActionButton.dart';
import '../Widgets/buttons/ActionButtonSmall.dart';
import '../Widgets/buttons/backbutton.dart';
import '../functions/doctor.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';
import '../pages/home/home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Doctor doctorService = Doctor();

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:Color.fromARGB(255, 41, 179, 229),
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
        body: Stack(children: <Widget>[
          Container(
            height: 700,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff32B1E0),
                Color(0xff32c1e0),
                Color(0xff8FF4F2),
                Color(0xff8FF4F2),
                Color(0xff8FF4F2),
                Color(0xff8FF4F2),
              ],
            )),
          ),
          Positioned(
              top: 70,
              right: 100,
              left: 100,
              child: Column(
              children: [
            //   FutureBuilder<List>(
            //     future: doctorService.getAllDoctor(user),
            //     builder: (context, snapshot){
            //       // print(snapshot.data);
            //       if(snapshot.hasData){
            //         return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
            //             if(snapshot.data![i]['users'].toString() == user.id.toString())
            //               if(snapshot.data![i]['profilepic'] != null)
            //               Image.network(
            //                 snapshot.data![i]['profilepic'],
            //                 width: 80,
            //                 height: 80,
            //                 fit: BoxFit.cover,
            //               );
            //         }); 
            //       } else{
            //         return const Center(
            //           child: Text('No data found!!'),
            //         );
            //       }
            //     },
            //  ),
                  const Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10,),
                  Text('${user.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.white
                  ),),
                  Text('${user.email}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xff4b8099)
                  ),),
                ], 
              )),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              height: 400,
              width: 410,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/health');
                    },
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffCEECEC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            CupertinoIcons.heart,
                            color: Color(0xff32c1e0),
                          ),
                        )),
                    title: Text(
                      'My Health',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/schedule');
                    },
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffCEECEC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            CupertinoIcons.calendar,
                            color: Color(0xff32c1e0),
                          ),
                        )),
                    title: Text(
                      'Appointment',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.pushNamed(context, '/presc');
                    },
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffCEECEC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            Icons.sticky_note_2,
                            color: Color(0xff32c1e0),
                          ),
                        )),
                    title: Text(
                      'Add Prescription',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                  ListTile(
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffCEECEC),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Icon(
                            Icons.history,
                            color: Color(0xff32c1e0),
                          ),
                        )),
                    title: Text(
                      'History',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Icon(CupertinoIcons.forward),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (context)=> AlertDialog(
                        content: Container(
                          height: 350,
                          width: 30,
                          child: Column(
                            children: [
                              Expanded( flex:4,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFfaf6f5),
                                  ),
                                  child: const Icon(
                                    Icons.logout,
                                    size: 60,
                                    color: Color(0xff32c1e0),
                                  ),
                                ),
                              ),
                              Expanded(flex:2 ,
                                child: Text ('Are u sure you want to log out?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800
                                ),),
                              ),
                               Expanded(flex:2,child: ActionButtonSmall(title:'Log Out',route: '/login', color:Colors.black12 )),
                               Expanded(flex:2,child: ActionButtonSmall(title:'Cancel',route: '', color:Color(0xff32c1e0), )),
                            ],
                          ),
                        ),
                      ));
                    },
                    child: ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(7.5),
                            child: Icon(
                              Icons.logout,
                              color: Colors.redAccent,
                            ),
                          )),
                      title: Text(
                        'Log out',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.redAccent),
                      ),
                      trailing: Icon(CupertinoIcons.forward),
                    ),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
