import 'package:flutter/material.dart';
import 'package:mediaid_flutter/pages/home/home.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;

  ErrorPage({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error Page'),
        backgroundColor: Color(0xff82bcc4),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              size: 100,
              color: Colors.red,
            ),
            Text(
              'An error occurred:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              errorMessage,
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back when the button is pressed
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
