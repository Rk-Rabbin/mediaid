import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import '../models/user_cubit.dart';
import '../models/user_models.dart';



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
      appBar: AppBar(title: Text('Doctor Registration'),
      backgroundColor:Color(0xff82bcc4),
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
                        Text('No profile picture available'),
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