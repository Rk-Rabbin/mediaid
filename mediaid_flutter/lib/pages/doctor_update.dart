import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mediaid_flutter/Screens/Doctors.dart';
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/models/doctor_model.dart';
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
import 'package:path_provider/path_provider.dart';


class DoctorUpdateForm extends StatefulWidget {
  final DoctorModel doctor;
  const DoctorUpdateForm({
    super.key,
    required this.doctor
  });

  @override
  _DoctorUpdateFormState createState() => _DoctorUpdateFormState();
}

class _DoctorUpdateFormState extends State<DoctorUpdateForm> {

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
  // File _imageFile = File(''); // Provide an initial empty File or your default image file path
  late final DoctorModel doctor;

  Future<File> downloadNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/downloaded_image.jpg');

    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
    else if (_imageFile == null) {
    // Set _imageFile to doctor.profilepic if it's still null
    setState(() async {
    _imageFile = await downloadNetworkImage(doctor.profilepic);
    });
  }
  }

  Future<void> _setImage() async {
  if (_imageFile == null) {
    // Perform asynchronous work here
    final File imageFile = await downloadNetworkImage(doctor.profilepic);

    // Once the asynchronous work is complete, update the state using setState
    setState(() {
      _imageFile = imageFile;
    });
  }
}


   @override
  void initState() {
    user = context.read<UserCubit>().state;
    doctor = widget.doctor;
    _nameController.text = doctor.name;
    _numberController.text = doctor.number;
    _genderController.text = doctor.gender;
    _licenseController.text = doctor.licensenum;
    _hospitalController.text = doctor.hospital;
    _specialityController.text = doctor.speciality;
    _qualificationController.text = doctor.qualification;
    _availabilityController.text = doctor.availability;
    _startController.text = doctor.start;
    _endController.text = doctor.end;
    _feesController.text = doctor.fees;
    if (_imageFile == null) {
      _setImage();
    }
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
      appBar: AppBar(title: Text('Doctor Profile Update'),
      backgroundColor:Color(0xff82bcc4),
      leading: IconButton(
    icon: Icon(Icons.home),
    onPressed: () {
      // Add your navigation logic here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  ),
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
            Image.network(
                          doctor.profilepic.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
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
                    doctor.name = _nameController.text;
                    doctor.number = _numberController.text;
                    doctor.gender = _genderController.text;
                    doctor.licensenum = _licenseController.text;
                    doctor.hospital = _hospitalController.text;
                    doctor.speciality = _specialityController.text;
                    doctor.qualification = _qualificationController.text;
                    doctor.availability = _availabilityController.text;
                    doctor.start = _startController.text;
                    doctor.end = _endController.text;
                    doctor.fees = _feesController.text;
                    var a = await updateDoctor(user, doctor, _imageFile!);
                    if(a){
                      setState(() {});
                      showDialog(
                      context: context, builder: (context)=> AlertDialog(
                      content: Container(
                        height: 200,
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
                            Text('Your account has been successfully updated',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: CupertinoColors.inactiveGray,
                            ),),
                                      SizedBox(height: 20),
          // Add your button here
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Doctors() ),
                    );
            },
            child: Text(
              "Exit",
              style: TextStyle(color: Colors.white),
            ),
          ),
                            ],
                          ),
                        ),
                      )
                      );
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
                          Text('Could not update your Doctor profile',
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
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
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
                // if (widget.userId != null) {
                //   registerDoctor(widget.userId!);
                // }
              },
              title: 'Update Doctor',
            ),
        ],
      ),
      ),
    );
  }
}