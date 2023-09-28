import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid_flutter/Screens/DocProfile.dart';
import 'package:mediaid_flutter/Screens/PatProfile.dart';

class patHCard extends StatelessWidget {
  final String image;
  final title;
  final subtitle;
  final hospital;
  final number;
  final fees;
  final route;
  final id;


  const patHCard({
    Key? key,
    required this.image,
    this.title,
    this.subtitle,
    required this.hospital,
    required this.number,
    required this.fees,
    this.route,
    required this.id,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatProfile(
                name: title,
                image: image,
                spec: subtitle,
                // hospital: hospital,
                // number: number,
              ),
            ),
          );
        },
        child: Container(
          height: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CupertinoColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1.0,
                spreadRadius: 0.2,
              )
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image(
                    image: image is String && image.startsWith('http')
                        ? NetworkImage(image)
                        : AssetImage(image) as ImageProvider<Object>,
                    height: 115,
                    width: 115,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7,),
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                          SizedBox(width: 10), // Add some spacing between the name and ID
                      Text(
                        'ID: $id', // Display the doctor's ID here
                        style: TextStyle(
                          color: const Color.fromARGB(144, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffD8FCEB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bloodtype,
                            color: Color.fromARGB(255, 255, 48, 48),
                            size: 18,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 48, 48),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xffD8FCEB),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Color(0xff38CC86),
                            size: 18,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            number,
                            style: TextStyle(
                              color: Color(0xff38CC86),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.calendar_today,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Container(
  width: 150, // Set a maximum width or adjust this value as needed
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Text(
      hospital,
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
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.money_dollar,
                        size: 18,
                        color: Colors.black26,
                      ),
                      Container(
  width: 150, // Set a maximum width or adjust this value as needed
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Text(
      fees,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
