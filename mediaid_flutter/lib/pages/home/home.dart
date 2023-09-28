import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
import 'package:mediaid_flutter/models/user_models.dart';
import 'package:mediaid_flutter/pages/doctor_reg.dart';
import 'package:mediaid_flutter/pages/doctor_list.dart';
import 'package:mediaid_flutter/pages/insurance_reg.dart';
import 'package:mediaid_flutter/pages/login_page.dart';
import 'package:mediaid_flutter/pages/patient_reg.dart';
import 'package:mediaid_flutter/pages/search_result.dart';
import 'package:mediaid_flutter/theme.dart';
import '../../models/user_cubit.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid_flutter/widgets/docHomeCard.dart';
import 'package:mediaid_flutter/widgets/buttons/homebuttons.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Doctor doctorService = Doctor();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    // final int userId = user.id?.toInt();
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children:[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff82bcc4)
                ),
                accountName: Text('${user.username} || User Id: ${user.id}',style: TextStyle(
                  fontSize: 22
                ),), accountEmail: Text('${user.email}')),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading:Icon(CupertinoIcons.home),
              title: Text('Home',style: TextStyle(
                fontSize: 18
              ),),
            ),
            ListTile(
              onTap: (){
                Navigator.pushNamed(context, '/profile');
              },
              leading:Icon(CupertinoIcons.person),
              title: Text('Profile',style: TextStyle(
                  fontSize: 18
              ),),
            ),

            ListTile(
              onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorRegistrationForm() ),
                    );
                  },
              leading: Icon(CupertinoIcons.person_badge_plus),
              title: Text('Doctor Registration',style: TextStyle(
                fontSize: 18
              ),),
            ),

            ListTile(
              onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientRegistrationForm() ),
                    );
                  },
              leading: Icon(CupertinoIcons.person_badge_plus),
              title: Text("Patient Registration",style: TextStyle(
                fontSize: 18
              ),),
            ),

            ListTile(
              onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InsuranceRegistrationForm() ),
                    );
                  },
              leading: Icon(CupertinoIcons.person_badge_plus),
              title: Text("Insurance Registration",style: TextStyle(
                fontSize: 18
              ),),
            ),

            ListTile(
              leading:Icon( Icons.contact_page_outlined),
              title: Text('Medical Records',style: TextStyle(
                  fontSize: 18
              ),),
            ),ListTile(
              onTap: (){
                Navigator.pushNamed(context, '');
              },
              leading:Icon(Icons.history),
              title: Text('History',style: TextStyle(
                  fontSize: 18
              ),),
            ),ListTile(
              onTap: (){
                Navigator.pushNamed(context, '');
              },
              leading:Icon(CupertinoIcons.text_bubble),
              title: Text('Messages',style: TextStyle(
                  fontSize: 18
              ),),
            ),ListTile(
              onTap: (){
                Navigator.pushNamed(context, '');
              },
              leading:Icon(CupertinoIcons.calendar_today),
              title: Text('Appointment',style: TextStyle(
                  fontSize: 18
              ),),
            ),ListTile(
              onTap: (){
                Navigator.pushNamed(context, '');
              },
              leading:Icon(CupertinoIcons.checkmark_shield),
              title: Text('Insurance',style: TextStyle(
                  fontSize: 18
              ),),
            ),ListTile(
              onTap: () async {
                await logOut(user.token!);
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false);
              },
              leading:Icon(Icons.logout),
              title: Text('Sign Out',style: TextStyle(
                  fontSize: 18
              ),),
            ),
          ]
        ),
      ),
      appBar: AppBar(
        iconTheme:IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0 , 20,  0),
                child: Text(
                  'Find your desired \nhealth solution'  ,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 25,
                    color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
            child: Container(
            height: 56,
            decoration: BoxDecoration(
                color: const Color(0xFFfaf6f5),
                borderRadius: BorderRadius.circular(35),
              boxShadow: const [BoxShadow(
            color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 0.5,
            )]
            ),
            child:   Padding(
              padding: const EdgeInsets.fromLTRB(19, 8, 10, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController, // Assign the controller here
                      decoration: InputDecoration(
                        hintText: 'Search doctors...',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                        focusColor: Colors.transparent,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.black45,
                      cursorHeight: 25,
                      cursorWidth: 1, 
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.search,
                        color: Colors.blue, // Customize the color of the search button
                        size: 28, // Customize the size of the search button
                      ),
                      onPressed: () {
                        String searchText = searchController.text; // Get the text from the controller

                        // Navigate to the search result page with the search text as a parameter.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Search(
                              searchText: searchText,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
          ),
        ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                homebuttons(title: 'Doctors', image: 'assets/steth.png', route:'/doctor_list'),
                homebuttons(title: 'Insurance', image: 'assets/hospital.png', route: '/insurance',),
                homebuttons(title: 'Patients', image: 'assets/care.png', route: '/patient_list',),
                homebuttons(title: 'Prescription', image: 'assets/pill.png', route: '/prescription_list',),

              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffcff2ff),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              'Early protection for your family health',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.cyan
                              ),
                              child: Center(
                                child: Text(
                                  'Learn More',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Image(image: AssetImage(
                          'assets/lady2.png'
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Top Doctors',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17
                  ),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context,'/doctor_list');
                    },
                    child: Text('See all',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: CupertinoColors.systemGreen
                    ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 10, 0, 0),
              child: Container(
                height: 200,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:[
                      FutureBuilder<List>(
      future: doctorService.getAllDoctor(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator.
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final doctorList = snapshot.data;
          return Row(
            children: [
              if (doctorList != null) // Check if doctorList is not null.
                for (int i = 0; i < doctorList.length; i++)
                  docHomeCard(
                    image: doctorList[i]['profilepic'] != null
                           ? doctorList[i]['profilepic'] // Pass the image URL as a String
                           : 'assets/head_sun_flower.png',
                    title: doctorList[i]['name'],
                    subtitle: doctorList[i]['speciality'],
                    rating: doctorList[i]['number'],
                    distance: doctorList[i]['hospital'],
                  ),
            ],
          );
        } else {
          return const Center(
            child: Text('No data found!!'),
          );
        }
      },
    ),
                ]
                ),
              ),
            ),],
        ),
      ),


    );
  }
}
