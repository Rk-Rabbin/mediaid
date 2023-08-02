import 'package:flutter/material.dart';
import 'package:flutter_mediaid/functions/patient.dart';


class PatientPage extends StatefulWidget {
  const PatientPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PatientPage> createState() => _PatientPage();
}

class _PatientPage extends State<PatientPage>{

  Patient patientService = Patient();


  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List>(
              future: patientService.getAllPatient(),
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