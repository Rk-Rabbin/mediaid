import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/functions/patient.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Widgets/formFields.dart';
import '../Widgets/regForms.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mediaid_flutter/utils.dart';

class PatientRegistrationForm extends StatefulWidget {
  // final int? userId;

  PatientRegistrationForm();
  @override
  _PatientRegistrationFormState createState() => _PatientRegistrationFormState();
}

class _PatientRegistrationFormState extends State<PatientRegistrationForm> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _insuranceController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  TextEditingController _bloodController = TextEditingController();
  TextEditingController _medicationsController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _allergyController = TextEditingController();
  late User user;
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

   @override
  void initState() {
    user = context.read<UserCubit>().state;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Registration'),
      backgroundColor:Color(0xff82bcc4),

      ),
      body: SingleChildScrollView(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
              height: 15,
          ),
          regForms(
            controller: _nameController,
            title: "Patient's Name",
            logo: Icons.person,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _numberController,
            title: "Phone Number",
            logo: CupertinoIcons.number,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _genderController,
            title: "Gender",
            logo: Icons.male,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _insuranceController,
            title: "Insurance Company Id",
            logo: Icons.code,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _birthdateController,
            title: "Birthdate (yyyy-mm-dd)",
            logo: Icons.calendar_today,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _diseaseController,
            title: "Disease",
            logo: Icons.sick,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _bloodController,
            title: "Blood Group",
            logo: Icons.bloodtype,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _allergyController,
            title: "Allergy",
            logo: Icons.sick_sharp,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _medicationsController,
            title: "Medications",
            logo: Icons.medication_outlined,
          ),
          SizedBox(
              height: 15,
            ),
          // regForms(
          //   controller: _endController,
          //   title: "Closing Time",
          //   logo: CupertinoIcons.clock,
          // ),
          // SizedBox(
          //     height: 15,
          //   ),
          // regForms(
          //   controller: _feesController,
          //   title: "Fees",
          //   logo: CupertinoIcons.money_dollar_circle_fill,
          // ),

          //   SizedBox(
          //     height: 15,
          //   ),
            _imageFile == null
                ? Text('No image selected')
                : Image.file(_imageFile!),

            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Pick from Gallery'),
            ),
          // Other text form fields for password, email, name, number, gender
          CustomTextButton(
              onTap: () async {
                if(_nameController.text.isNotEmpty && _numberController.text.isNotEmpty &&
                _genderController.text.isNotEmpty && _bloodController.text.isNotEmpty &&
                _birthdateController.text.isNotEmpty && _medicationsController.text.isNotEmpty &&
                _diseaseController.text.isNotEmpty && _allergyController.text.isNotEmpty){
                  String insurance = _insuranceController.text.isEmpty ? "-1" : _insuranceController.text;
                  DateTime selectedBirthdate = DateTime(1990, 1, 1);
                  String formattedDate = "1990-01-01";
                  // In your form submission logic, convert the text entered by the user to a DateTime
                  try {
                    selectedBirthdate = DateTime.parse(_birthdateController.text);
                    formattedDate = DateFormat('yyyy-MM-dd').format(selectedBirthdate);
                  } catch (e) {
                    // Handle parsing error if the user enters an invalid date format
                    print("Invalid date format: ${_birthdateController.text}");
                  }
                  var a = await createPatient(user, _nameController.text, _numberController.text,
                  insurance, selectedBirthdate, formattedDate,  _bloodController.text, _genderController.text,
                  _medicationsController.text, _diseaseController.text, _allergyController.text, _imageFile!);

                  if(a){
                    showDialog(
                    context: context, builder: (context)=> AlertDialog(
                    content: Container(
                      height: 150,
                      width: 30,
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFfaf6f5),
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 60,
                              color: Color(0xff32c1e0),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text('Your account has been successfully registered',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: CupertinoColors.inactiveGray,
                          ),),
                          ],
                        ),
                      ),
                    )
                    );
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home()), (route) => false);
                  }
                  else{
                  showDialog(
                  context: context, builder: (context)=> AlertDialog(
                  content: Container(
                    height: 150,
                    width: 30,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFfaf6f5),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 60,
                            color: Color(0xff32c1e0),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Could not register as a Patient',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: CupertinoColors.inactiveGray,
                        ),),
                        ],
                      ),
                    ),
                    )
                    );
                  }
                }
                else{
                  showDialog(
                  context: context, builder: (context)=> AlertDialog(
                  content: Container(
                    height: 150,
                    width: 30,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFfaf6f5),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 60,
                            color: Color(0xff32c1e0),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text('Fill All The Boxes Properly',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: CupertinoColors.inactiveGray,
                        ),),
                        ],
                      ),
                    ),
                    )
                    );
                }
              },
              title: 'Register as Patient',
            ),
        ],
      ),
      ),
    );
  }
}