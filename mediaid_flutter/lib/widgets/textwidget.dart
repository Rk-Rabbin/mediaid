import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final IconData logo;

  TextWidget({
    Key? key,
    required this.text,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 390,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
        color: const Color(0xFFfaf6f5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Icon(
                logo,
                color: Colors.black26,
                size: 18,
              ),
            ),
            SizedBox(width: 10), // Add spacing between icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
