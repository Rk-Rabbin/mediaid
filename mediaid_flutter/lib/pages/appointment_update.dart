import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mediaid_flutter/Screens/Doctors.dart';
import 'package:mediaid_flutter/Screens/Schedule.dart';
import 'package:mediaid_flutter/functions/appointment.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/models/appointment_model.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import 'package:mediaid_flutter/widgets/textwidget.dart';
import '../Widgets/regForms.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class AppointmentUpdate extends StatefulWidget {
  final AppointmentModel appointment;
  const AppointmentUpdate({
    super.key,
    required this.appointment
  });

  @override
  _AppointmentUpdateState createState() => _AppointmentUpdateState();
}

class _AppointmentUpdateState extends State<AppointmentUpdate> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  late User user;
  late final AppointmentModel appointment;

 @override
  void initState() {
    user = context.read<UserCubit>().state;
    appointment = widget.appointment;
    _timeController.text = appointment.expected_time;
    _dateController.text = appointment.expected_date;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Reschedule'),
      backgroundColor:Color(0xff82bcc4),
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
      body: SingleChildScrollView(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
              height: 15,
          ),
          TextWidget(
            text: appointment.doctor_name,
            logo: Icons.person_outline,
          ),
          SizedBox(
              height: 15,
            ),
          TextWidget(
            text: appointment.patient_name,
            logo: Icons.person,
          ),
          SizedBox(
              height: 15,
            ),
          TextWidget(
            text: appointment.disease,
            logo: Icons.local_hospital,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _dateController,
            title: "Expected Date (yyyy-mm-dd)",
            logo: Icons.calendar_month,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _timeController,
            title: "Exoected Time (HH:MM)",
            logo: Icons.watch_later,
          ),
          SizedBox(
              height: 15,
            ),

          // Other text form fields for password, email, name, number, gender
          CustomTextButton(
              onTap: () async {
                if(_dateController.text.isNotEmpty && _timeController.text.isNotEmpty){
                    appointment.expected_date = _dateController.text;
                    appointment.expected_time = _timeController.text;
                    // appointment.patient = appointment.patient;
                    var a = await updateAppointment(user, appointment);
                    if(a){
                      setState(() {});
                      showDialog(
                      context: context, builder: (context)=> AlertDialog(
                      content: Container(
                        height: 200,
                        width: 30,
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
                            SizedBox(height: 20,),
                            Text('Successfully Rescheduled',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: CupertinoColors.inactiveGray,
                            ),),
                                      SizedBox(height: 20),
          // Add your button here
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Schedules() ),
                    );
            },
            child: Text(
              "Exit",
              style: TextStyle(color: Colors.white),
            ),
          ),
                            ],
                          ),
                        ),
                      )
                      );
                    }
                    else{
                    showDialog(
                    context: context, builder: (context)=> AlertDialog(
                    content: Container(
                      height: 150,
                      width: 30,
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
                              Icons.close,
                              size: 60,
                              color: Color(0xff32c1e0),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('Could not reschedule',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: CupertinoColors.inactiveGray,
                          ),),
                          ],
                        ),
                      ),
                      )
                      );
                    }
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                }
                else{
                  showDialog(
                  context: context, builder: (context)=> AlertDialog(
                  content: Container(
                    height: 150,
                    width: 30,
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
                            Icons.close,
                            size: 60,
                            color: Color(0xff32c1e0),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Fill All The Boxes Properly',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: CupertinoColors.inactiveGray,
                        ),),
                        ],
                      ),
                    ),
                    )
                    );
                }
                // if (widget.userId != null) {
                //   registerDoctor(widget.userId!);
                // }
              },
              title: 'Reschedule',
            ),
        ],
      ),
      ),
    );
  }
}