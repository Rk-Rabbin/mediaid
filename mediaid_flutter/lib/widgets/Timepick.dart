import 'package:flutter/material.dart';

class Timepick extends StatefulWidget {
  final String time;
  final bool available;
  final Function(String) onTimeSelected;
  final bool isSelected;

  Timepick({
    Key? key,
    required this.time,
    required this.available,
    required this.onTimeSelected,
    required this.isSelected,
  }) : super(key: key);

  @override
  _TimepickState createState() => _TimepickState();
}

// class _TimepickState extends State<Timepick> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!widget.isSelected && widget.available) {
//           widget.onTimeSelected(widget.time);
//         }
//       },
//       child: Container(
//         height: 38,
//         width: 105,
//         decoration: BoxDecoration(
//           color: widget.isSelected ? Color(0xff32c1e0) : Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(
//             color: widget.isSelected ? Color(0xff32c1e0) : Colors.grey.shade200,
//             width: 1.5,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             widget.time,
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//               color: widget.isSelected ? Colors.white : Colors.black45,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class _TimepickState extends State<Timepick> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.available) {
          setState(() {
            isSelected = !isSelected;
          });
          widget.onTimeSelected(widget.time);
        }
      },
      child: Container(
        height: 38,
        width: 105,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff32c1e0) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Color(0xff32c1e0) : Colors.grey.shade200,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            widget.time,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black45,
            ),
          ),
        ),
      ),
    );
  }
}
