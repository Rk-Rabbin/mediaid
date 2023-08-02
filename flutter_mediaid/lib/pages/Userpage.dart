import 'package:flutter/material.dart';
import 'package:flutter_mediaid/functions/user.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>{

  User userService = User();


  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder<List>(
              future: userService.getAllUser(),
              builder: (context, snapshot){
                print(snapshot.data);
                if(snapshot.hasData){
                  return ListView.builder(itemCount: snapshot.data?.length, itemBuilder: (context, i){
                    return Card(
                      child: ListTile(
                        title: Text('Name: '+snapshot.data![i]['username'], style: TextStyle(fontSize: 30.0),
                        ),
                        subtitle: Text('Email: '+snapshot.data![i]['email'], style: TextStyle(fontSize: 20.0),
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