import 'package:flutter/material.dart';
import 'package:flutter_mediaid/functions/prescription.dart';


class PrescriptionPage extends StatefulWidget {
  const PrescriptionPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PrescriptionPage> createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage>{

  Prescription prescriptionService = Prescription();


  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List>(
              future: prescriptionService.getAllPrescription(),
              builder: (context, snapshot){
                print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child: ListTile(
                        title: Text('Patient Id: '+snapshot.data![i]['patient'].toString(), style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text('Doctor id: '+snapshot.data![i]['doctor'].toString()+'\nDisease: '+snapshot.data![i]['disease'], style: TextStyle(fontSize: 20.0),
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