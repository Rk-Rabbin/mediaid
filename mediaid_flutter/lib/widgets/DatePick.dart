import 'package:flutter/material.dart';

class DatePick extends StatefulWidget {
  final String date;
  final String day;
  final bool isSelected;
  final bool available;
  final Function(String) onDateSelected;

  DatePick({
    Key? key,
    required this.date,
    required this.day,
    required this.isSelected,
    required this.available,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickState createState() => _DatePickState();
}

class _DatePickState extends State<DatePick> {
  bool isSelected = false; // Add a local isSelected state

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected; // Initialize isSelected from the widget property
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.available) {
          setState(() {
            isSelected = !isSelected; // Update the local isSelected state
          });
        widget.onDateSelected(widget.date);
        }
      },
      child: Container(
        height: 85,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: isSelected ? Color(0xff32c1e0) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              spreadRadius: 0.1,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.day,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
              Text(
                widget.date,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
