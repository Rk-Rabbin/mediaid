import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid_flutter/Widgets/Timepick.dart';
import 'package:mediaid_flutter/Widgets/buttons/CustActionButton.dart';
import 'package:mediaid_flutter/pages/appointment_reg.dart';

import '../models/appointment_model.dart';
import '../Widgets/DatePick.dart';
import '../Widgets/buttons/backbutton.dart';
import 'package:flutter/physics.dart';
import 'package:intl/intl.dart';


class DocProfile extends StatefulWidget {
  final name;
  final String image;
  final spec;
  final hospital;
  final number;
  final fees;
  final id;
  final start;
  final end;

  const DocProfile({Key? key, this.name, required this.image, this.spec, this.hospital,
  this.number, this.fees, this.id, this.start, this.end}) : super(key: key);

  @override
  State<DocProfile> createState() => _DocProfileState();
}

class _DocProfileState extends State<DocProfile> {
  String selectedTime = ''; // Use a Set to store selected dates
  String selectedDate = '';


  void _handleDateSelected(String date) {
    setState(() {
      if (selectedDate == date) {
        // If the same date is tapped again, unselect it
        selectedDate = '';
      } else {
        // Only one date should be selected at a time, so clear the set before adding the new date
        selectedDate = date;
        // Additional code if needed when a new date is selected
      }
    });
  }



// Add this variable to store the selected time

void _handleTimeSelected(String time) {
  setState(() {
    if (selectedTime == time) {
      // If the same time is tapped again, unselect it
      selectedTime = '';
    } else {
      // Unselect the previously selected time slot
      selectedTime = time;
    }
  });
}


List<Map<String, String>> generateDates() {
  final List<Map<String, String>> dateAndDayList = [];
  final now = DateTime.now();
  final formatterDate = DateFormat('d');
  final formatterDay = DateFormat('E');

  for (int i = 0; i < 7; i++) {
    final date = now.add(Duration(days: i));
    final formattedDate = formatterDate.format(date);
    final formattedDay = formatterDay.format(date);
    dateAndDayList.add({
      'date': formattedDate,
      'day': formattedDay,
    });
  }

  return dateAndDayList;
}


String getDayFromDate(String dateStr) {
  final date = DateFormat('d').parse(dateStr);
  return DateFormat('E').format(date); // This will return the day of the week (e.g., 'Mon', 'Tue', etc.)
}

List<String> generateTimeSlots(String start, String end) {
  final List<String> timeSlots = [];

  var startTime = TimeOfDay.fromDateTime(DateTime.parse("2023-08-18 $start"));
  final endTime = TimeOfDay.fromDateTime(DateTime.parse("2023-08-18 $end"));

  while (startTime.hour < endTime.hour ||
      (startTime.hour == endTime.hour && startTime.minute <= endTime.minute)) {
    timeSlots.add(startTime.format(context));
    final nextTime = DateTime(2023, 8, 18, startTime.hour, startTime.minute)
        .add(Duration(minutes: 30));
    startTime = TimeOfDay.fromDateTime(nextTime);
  }

  return timeSlots;
}





  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = generateTimeSlots(widget.start, widget.end);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: backbutton(),
        title: Row(
          children: const [
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Text(
                  'Doctor Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 125,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image(
                              image: widget.image is String && widget.image.startsWith('http')
                                      ? NetworkImage(widget.image)
                                      : AssetImage("assets/head_sun_flower.png") as ImageProvider<Object>,
                              // image: NetworkImage(
                              //   widget.image,
                              // ),
                              height: 115,
                              width: 115,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.spec,
                              style: TextStyle(
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Color(0xffD8FCEB),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  children:[
                                    Icon(
                                      Icons.star,
                                      color: Color(0xff38CC86),
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.number,
                                      style: TextStyle(
                                          color: Color(0xff38CC86),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Container(
                        width: 150, // Set a maximum width or adjust this value as needed
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.hospital,
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 0, 5),
                    child:const Text(
                      'About',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Text(
                      'Dr. ${widget.name}, renowned in ${widget.spec} field, practices at ${widget.hospital}, providing exceptional care for ${widget.spec} disese patients.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                  Padding(
  padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
  child: Container(
    height: 90,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: generateDates().length,
      itemBuilder: (context, index) {
        final dateAndDay = generateDates()[index];
        final date = dateAndDay['date'] ?? ''; // Provide a default value if it's nullable
        final day = dateAndDay['day'] ?? ''; // Provide a default value if it's nullable
        final isSelected = selectedDate == date;
        final available = true;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0), // Adjust the padding as needed
          child: DatePick(
            date: date,
            day: day,
            available: available,
            isSelected: isSelected,
            onDateSelected: _handleDateSelected,
          ),
        );
      },
    ),
  ),
),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust the horizontal spacing as needed
  child: Wrap(
    children: List<Widget>.generate(timeSlots.length, (index) {
      final time = timeSlots[index];
      final isSelected = selectedTime == time;
      final available = true;
      final parts = time.split(':');
      var hours = int.parse(parts[0].trim());
      final minutes = parts[1].replaceAll('AM', '').replaceAll('PM', '').trim();

      // Check if it's "PM" and the hour is less than 12, then add 12 to the hour
      if (time.contains('PM') && hours < 12) {
        hours += 12;
      }
      // Format the hours and minutes as a 24-hour time string
      final formattedTime = '$hours:$minutes';

      return Padding(
        padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
        child: Timepick(
          time: formattedTime,
          available: available,
          onTimeSelected: _handleTimeSelected,
          isSelected: isSelected,
        ),
      );
    }),
  ),
),
                //   Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust the horizontal spacing as needed
                //   child: Wrap(
                //     children: List<Widget>.generate(timeSlots.length, (index) {
                //       final time = timeSlots[index];
                //       final isSelected = selectedTime == time;
                //       final available = true;
                      
                //       selectedTime = time;
                //       final parts = time.split(':');
                //       var hours = int.parse(parts[0].trim());
                //       final minutes = parts[1].replaceAll('AM', '').replaceAll('PM', '').trim();

                //       // Check if it's "PM" and the hour is less than 12, then add 12 to the hour
                //       if (time.contains('PM') && hours < 12) {
                //         hours += 12;
                //     }
                //     // Format the hours and minutes as a 24-hour time string
                //     selectedTime = '$hours:$minutes'; // You can set this based on your availability logic
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                //         child: Timepick(
                //           time: time,
                //           available: available,
                //           onTimeSelected: _handleTimeSelected,
                //           isSelected: isSelected,
                //         ),
                //       );
                //     }),
                //   ),
                // ),
                ],
              ),
            ),


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
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffd4f7fc),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/mychat');
                        },
                        child: const Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: Color(0xff32c1e0),
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 7,
                  child: GestureDetector(
                    onTap: () {
                      if (selectedTime.isNotEmpty && selectedDate.isNotEmpty) {
                        DateTime now = DateTime.now();
                        selectedDate = now.year.toString()+"-"+now.month.toString()+"-"+selectedDate;
                        print(selectedDate);
                        print(selectedTime);
                        // DateTime now = DateTime.now();
                        // selectedDate = now.year.toString()+"-"+now.month.toString()+"-"+selectedDate;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentPage(
                              doctorName: widget.name,
                              doctorId: widget.id,
                              selectedDate: selectedDate,
                              selectedTime: selectedTime,
                              fees: widget.fees, // Use the formatted time you need
                            ),
                          ),
                        );
                      } else if(selectedTime=='' || selectedDate==''){
                        // print("No date/time selected");
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
                                  'Invalid Info',
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
                    },
                    child: Container(
                      height:60,
                      decoration: BoxDecoration(
                          color: const Color(0xff32c1e0),
                          borderRadius: BorderRadius.circular(32)),
                      child: const Center(
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),))
            ],
          ),
        ),
      ),
    );

  }
}
