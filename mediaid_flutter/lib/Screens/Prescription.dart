// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mediaid_flutter/Widgets/PresCard.dart';

// import '../models/prescription_model.dart';
//  import '../Widgets/PresCard2.dart';
// import '../Widgets/buttons/backbutton.dart';
// import 'AddPresc.dart';
// class Prescriptionl extends StatefulWidget {
//   const Prescriptionl({Key? key}) : super(key: key);

//   @override
//   State<Prescriptionl> createState() => _PrescriptionlState();
// }

// class _PrescriptionlState extends State<Prescriptionl> {
//   List<PrescriptionModel> _prescriptionList = [];
//   Future<void> _navigateToAddPresc() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => AddPresc(),
//       ),
//     );
//     if (result != null && result is PrescriptionModel) {
//       setState(() {
//         _prescriptionList.add(result);print("Number of prescriptions: ${_prescriptionList.length}");
//       });
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         toolbarHeight: 70,
//         backgroundColor: Colors.white,
//         leading:const backbutton (),
//         title: Row(
//           children: const [
//             Expanded(
//               flex: 9,
//               child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 0 , 20,  0),
//                 child: Text(
//                   'Prescription'  ,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 21,
//                       color: Colors.black
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
//               child: Container(
//                 height: 56,
//                 decoration: BoxDecoration(
//                     color: const Color(0xFFfaf6f5),
//                     borderRadius: BorderRadius.circular(35),
//                     boxShadow: const [BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 2.0,
//                       spreadRadius: 0.5,
//                     )]
//                 ),
//                 child:   const Padding(
//                   padding: EdgeInsets.fromLTRB(19, 5, 10, 0),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       icon: Icon(CupertinoIcons.search,
//                         color: Colors.grey,),
//                       hintText: 'Find prescription',
//                       hintStyle: TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                       focusColor: Colors.transparent,
//                       focusedBorder: InputBorder.none,
//                       border: InputBorder.none,
//                     ),
//                     cursorColor: Colors.black45,
//                     cursorHeight: 25,
//                     cursorWidth: 1,
//                   ),
//                 ),
//               ),
//             ),
//               PresCard2(image: 'assets/pres.png',title: 'Dr. Murcus Horizon',category: 'Chardiologist',  details: 'Cardiac Arrest',  ),
//               PresCard2(image: 'assets/eco.png',title: 'Dr. Murcus Horizon',category: 'Chardiologist',  details: 'Echocardiogram',  ),
//             // for (int index = 0; index < _prescriptionList.length; index++)
//             //   PresCard(
//             //     imageProvider: _prescriptionList[index].image ,
//             //     title: _prescriptionList[index].title,
//             //     category: _prescriptionList[index].category,
//             //     details: _prescriptionList[index].details,

//             //     // Define the callback to delete the specific prescription
//             //     onDeletePressed: () {
//             //       setState(() {
//             //         _prescriptionList.removeAt(index);
//             //       });
//             //     },
//             //   ),
//           ],
//         ),
//       ),
      // floatingActionButton: Align(
      //   alignment: Alignment.bottomRight,
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: GestureDetector(
      //       onTap: _navigateToAddPresc,
      //       child: Icon(
      //         CupertinoIcons.plus_app_fill,
      //         color: Color(0xff32c1e0),
      //         size: 60,
      //       ),
      //     ),
      //   ),
      // ),
//     );
//   }
// }
