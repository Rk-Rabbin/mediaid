import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Screens/Schedule.dart';
import 'package:mediaid_flutter/Widgets/buttons/SCustomButton2.dart';
import 'package:mediaid_flutter/functions/appointment.dart';
import 'package:mediaid_flutter/pages/appointment_update.dart';

import '../models/user_cubit.dart';
import '../models/user_models.dart';

class ScheduleCard extends StatelessWidget {
  final name;
  final disease;
  final expected_date;
  final expected_time;
  final requested_at;
  final accepted;
  final id;
  const ScheduleCard({Key? key, this.name, this.disease, this.accepted, this.expected_date, this.expected_time,
  this.requested_at, this.id })
      : super(key: key);

Future<void> viewAppointmentDetails(BuildContext context) async {
  User user = context.read<UserCubit>().state;

  try {
    final appointment = await getAppointment(user, id);
    if (appointment != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AppointmentUpdate(
            appointment: appointment,
          ),
        ),
      );
    } else {
      // Handle the case where the appointment is not found
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Appointment not found."),
        ),
      );
    }
  } catch (e) {
    // Handle any errors that occur during the appointment fetch
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Failed to fetch appointment: $e"),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: .5,
                      spreadRadius: 0.1,
                    )
                  ]),
              child: Column(
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          disease,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 20, 0, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Colors.black54,
                          size: 22,
                        ),
                        Text(
                          expected_date,
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Icon(
                            CupertinoIcons.clock,
                            color: Colors.black54,
                            size: 22,
                          ),
                        ),
                        Text(
                          expected_time,
                          style: TextStyle(fontSize: 17, color: Colors.black54),
                        ),
                        Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          accepted == false ? "Pending" : 'Confirmed',
                          style: TextStyle(
                            fontSize: 17,
                            color: accepted == false ? Colors.red : Colors.greenAccent, // Customize the color as needed
                          ),
                        ),
                        )
                      ],
                    ),
                  ),
                  //buttons
                  Padding(
  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
child: Row(
  children: [
Expanded(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(14, 20, 10, 0),
    child: ElevatedButton(
      onPressed: () async {
        // Show the confirmation dialog
        String a = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Confirm Cancel"),
              content: Text("Are you sure you want to cancel this?"),
              actions: [
                TextButton(
                  onPressed: () {
                    // User tapped "Confirm"
                    Navigator.of(context).pop("confirm"); // Close the dialog
                    // Add your delete logic here
                  },
                  child: Text("Confirm"),
                ),
                TextButton(
                  onPressed: () {
                    // User tapped "No"
                    Navigator.of(context).pop("cancel"); // Close the dialog
                  },
                  child: Text("No"),
                ),
              ],
            );
          },
        );
        if (a == "confirm") {
          var b = await deleteAppointment(user, id);
          if (b) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Cancelled Successfully"),
              ),
            );
            await Future.delayed(Duration(seconds: 2));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Schedules(),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Could not cancel. Something went wrong"),
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // Set button background color to red
        minimumSize: Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Add a slight border radius
        ), // Set the minimum height
      ),
      child: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text("Cancel", style: TextStyle(color: Colors.white,fontSize: 16, // Increase the text size
              fontWeight: FontWeight.bold, )),
        ],
      ),
    ),
  ),
),


    Expanded(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(14, 20, 10, 0),
    child: ElevatedButton(
  onPressed: () async {
    await viewAppointmentDetails(context); // Call the function to view appointment details
  },
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 74, 206, 246),
    minimumSize: Size(double.infinity, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Row(
    children: [
      Icon(
        Icons.watch_later,
        color: Colors.white,
      ),
      SizedBox(width: 5),
      Text(
        "Reschedule",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
)

  ),
),
  ],
),

),
                ],
              )),
        ],
      ),
    );
  }
}
