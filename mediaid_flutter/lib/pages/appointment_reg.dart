import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/functions/appointment.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/widgets/textwidget.dart';
import '../Widgets/regForms.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_models.dart';

class AppointmentPage extends StatefulWidget {
  final doctorName;
  final doctorId;
  final selectedDate;
  final selectedTime;

  const AppointmentPage({
    Key? key,
    required this.doctorName,
    required this.doctorId,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _patientNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _patientIdController = TextEditingController();

  late User user;

  @override
  void initState() {
    user = context.read<UserCubit>().state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Appointment'),
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
      body: SingleChildScrollView(
        key: _formKey,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            TextWidget(
            text: widget.doctorName,
            logo: Icons.person_outline,
          ),
            SizedBox(height: 5),
            SizedBox(height: 20),
            regForms(
              controller: _patientNameController,
              title: "Patient Name",
              logo: Icons.person,
            ),
            SizedBox(height: 20),
            regForms(
              controller: _patientIdController,
              title: "Patient Id",
              logo: Icons.format_list_numbered_rounded,
            ),
            SizedBox(height: 20),
            regForms(
              controller: _phoneNumberController,
              title: "Phone Number",
              logo: Icons.phone,
            ),
            SizedBox(height: 20),
            regForms(
              controller: _diseaseController,
              title: "Disease",
              logo: Icons.local_hospital,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
bottomNavigationBar: BottomAppBar(
  elevation: 0,
  child: Padding(
    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    child: Row(
      children: [
        Expanded(
          flex: 7,
          child: GestureDetector(
            onTap: () async {
              if (_patientNameController.text.isNotEmpty &&
                  _phoneNumberController.text.isNotEmpty &&
                  _diseaseController.text.isNotEmpty) {
                  print(widget.selectedDate);
                var a = await createAppointment(
                    user,
                    widget.doctorName,
                    _patientNameController.text,
                    _phoneNumberController.text,
                    _diseaseController.text,
                    widget.selectedDate,
                    widget.selectedTime,
                    widget.doctorId.toString(),
                    _patientIdController.text);

                if (a) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Container(
                        height: 150,
                        width: 50,
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFfaf6f5),
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 60,
                                color: Color(0xff32c1e0),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Your appointment has been successfully registered, keep an eye on your email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  await Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red, // You can choose the color you want
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Could not register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        content: Text(
                          'The information you provided is invalid. Please check and try again.',
                          style: TextStyle(fontSize: 16),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue, // You can choose the color you want
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xff32c1e0),
                  borderRadius: BorderRadius.circular(32)),
              child: const Center(
                child: Text(
                  'Confirm Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),
    );
  }
}