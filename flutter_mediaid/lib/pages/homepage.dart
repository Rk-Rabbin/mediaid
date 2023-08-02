import 'package:flutter/material.dart';
import 'package:flutter_mediaid/pages/Userpage.dart';
import 'package:flutter_mediaid/pages/patient_page.dart';
import 'package:flutter_mediaid/pages/doctor_page.dart';
import 'package:flutter_mediaid/pages/insurance_page.dart';
import 'package:flutter_mediaid/pages/prescription_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  final List<Tab> toptabs = <Tab>[
    Tab(text: 'Users'),
    Tab(text: 'Patients'),
    Tab(text: 'Doctors'),
    Tab(text: 'Insurance'),
    Tab(text: 'Prescription'),
  ];

  @override
  void initState(){
    _tabController = TabController(length: 5, vsync: this)
    ..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: toptabs,),
      ),
      
      body: TabBarView(
        controller: _tabController,
        children: [
          UserPage(title: 'Users API'),
          PatientPage(title: 'Patient API'),
          DoctorPage(title: 'Doctor API'),
          InsurancePage(title: 'Insurance API'),
          PrescriptionPage(title: 'Prescription API'),

        ]),
      );
  }
}