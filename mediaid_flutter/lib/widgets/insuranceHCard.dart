import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid_flutter/Widgets/insuranceDetailsRow.dart';

class insuranceHCard extends StatefulWidget {
  final String name;
  final String number;
  final String address;
  final String policy;
  final int id;

  insuranceHCard({required this.name, required this.number , required this.address, required this.policy,required this.id});

  @override
  _insuranceCardState createState() => _insuranceCardState();
}

class _insuranceCardState extends State<insuranceHCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffe1ebfc),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                        child: Text(
                          '${widget.name}',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                        child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Color(0xff38CC86),
                            size: 20,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            widget.number,
                            style: TextStyle(
                              color: Color(0xff38CC86),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 20, 5),
                        child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            color: Color(0xff38CC86),
                            size: 20,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            widget.address,
                            style: TextStyle(
                              color: Color(0xff38CC86),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ),
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children:  [
                     insuranceDetailsRow(icon: CupertinoIcons.person_crop_square,title: 'Insurance Company ID: ${widget.id}'),
                     insuranceDetailsRow(icon: CupertinoIcons.checkmark_shield_fill,title: widget.policy),
                     insuranceDetailsRow(icon: Icons.clean_hands,title: 'Call to the insurance company \nto get your desired plan & \nregister it to your patient profile.'),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}