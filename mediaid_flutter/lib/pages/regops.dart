import 'package:flutter/material.dart';
import 'package:mediaid_flutter/pages/doctor_reg.dart';
import 'package:mediaid_flutter/pages/insurance_reg.dart';
import 'package:mediaid_flutter/pages/patient_reg.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor:Color(0xFF82BCC4),
      title: Text('Registration Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose Your Role',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            RegistrationOption(
              title: 'Doctor',
              description: 'Register as a Doctor',
              color: Colors.blue,
              onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorRegistrationForm() ),
                    );
                  },
            ),
            SizedBox(height: 20),
            RegistrationOption(
              title: 'Patient',
              description: 'Register as a Patient',
              color: Colors.green,
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientRegistrationForm() ),
                    );
              },
            ),
            SizedBox(height: 20),
            RegistrationOption(
              title: 'Insurance',
              description: 'Register as an Insurance Provider',
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InsuranceRegistrationForm() ),
                    );
                            },
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationOption extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  RegistrationOption({
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}