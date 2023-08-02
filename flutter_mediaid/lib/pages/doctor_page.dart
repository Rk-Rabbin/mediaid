import 'package:flutter/material.dart';
import 'package:flutter_mediaid/functions/doctor.dart';


class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage>{

  Doctor doctorService = Doctor();


  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List>(
              future: doctorService.getAllDoctor(),
              builder: (context, snapshot){
                print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child: ListTile(
                        title: Text('Name: '+snapshot.data![i]['name'], style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text('Number: '+snapshot.data![i]['number'], style: TextStyle(fontSize: 20.0),
                        ),
                      ),
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