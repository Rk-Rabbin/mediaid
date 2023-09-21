import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
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

class DoctorRegistrationForm extends StatefulWidget {
  // final int? userId;

  DoctorRegistrationForm();
  @override
  _DoctorRegistrationFormState createState() => _DoctorRegistrationFormState();
}

class _DoctorRegistrationFormState extends State<DoctorRegistrationForm> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _licenseController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _availabilityController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _feesController = TextEditingController();
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
      appBar: AppBar(title: Text('Doctor Registration'),
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
            title: "Doctor's Name",
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
            controller: _licenseController,
            title: "License Number",
            logo: Icons.code,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _hospitalController,
            title: "Hospital Name",
            logo: Icons.local_hospital,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _specialityController,
            title: "Speciality",
            logo: Icons.star,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _qualificationController,
            title: "Qualification",
            logo: CupertinoIcons.book_solid,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _availabilityController,
            title: "Availability",
            logo: CupertinoIcons.calendar,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _startController,
            title: "Opening Time",
            logo: CupertinoIcons.clock,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _endController,
            title: "Closing Time",
            logo: CupertinoIcons.clock,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _feesController,
            title: "Fees",
            logo: CupertinoIcons.money_dollar_circle_fill,
          ),

            SizedBox(
              height: 15,
            ),
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
                _genderController.text.isNotEmpty && _licenseController.text.isNotEmpty &&
                 _hospitalController.text.isNotEmpty && _specialityController.text.isNotEmpty &&
                 _qualificationController.text.isNotEmpty && _availabilityController.text.isNotEmpty &&
                  _startController.text.isNotEmpty && _endController.text.isNotEmpty &&
                  _feesController.text.isNotEmpty){
                  var a = await createDoctor(user, _nameController.text, _numberController.text,
                  _genderController.text, _licenseController.text, _hospitalController.text,
                  _specialityController.text,_qualificationController.text,
                  _availabilityController.text, _startController.text, _endController.text,
                  _feesController.text, _imageFile!);

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
                        Text('Could not register a a Doctor',
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
              title: 'Register as Doctor',
            ),
        ],
      ),
      ),
    );
  }
}