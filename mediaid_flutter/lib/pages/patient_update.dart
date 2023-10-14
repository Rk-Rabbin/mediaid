import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/pages/patient_list.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import '../Widgets/regForms.dart';
import 'package:flutter/cupertino.dart';
import '../functions/patient.dart';
import '../models/patient_model.dart';
import '../models/user_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';



class PatientUpdateForm extends StatefulWidget {
  // final int? userId;
  final PatientModel patient;
  const PatientUpdateForm({
    super.key,
    required this.patient
  });

  @override
  _PatientUpdateFormState createState() => _PatientUpdateFormState();
}

class _PatientUpdateFormState extends State<PatientUpdateForm> {

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
  // File _imageFile = File(''); // Provide an initial empty File or your default image file path
  late final PatientModel patient;

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
    _imageFile = await downloadNetworkImage(patient.profilepic);
    });
  }
  }

  Future<void> _setImage() async {
  if (_imageFile == null) {
    // Perform asynchronous work here
    final File imageFile = await downloadNetworkImage(patient.profilepic);

    // Once the asynchronous work is complete, update the state using setState
    setState(() {
      _imageFile = imageFile;
    });
  }
}

   @override
  void initState() {
    user = context.read<UserCubit>().state;
    patient = widget.patient;
    _nameController.text = patient.name;
    _numberController.text = patient.number;
    _genderController.text = patient.gender;
    _insuranceController.text = patient.insurance;
    _birthdateController.text = patient.birthdate;
    _bloodController.text = patient.blood;
    _medicationsController.text = patient.medications;
    _diseaseController.text = patient.disease;
    _allergyController.text = patient.allergy;
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
      appBar: AppBar(title: Text('Patient Profile Update'),
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
            title: "Insurance Company id",
            logo: Icons.code,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _bloodController,
            title: "Blood Group",
            logo: Icons.local_hospital,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _medicationsController,
            title: "Medications",
            logo: Icons.star,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _diseaseController,
            title: "Diseases",
            logo: CupertinoIcons.book_solid,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _allergyController,
            title: "Allergy",
            logo: CupertinoIcons.calendar,
          ),
          SizedBox(
              height: 15,
            ),
          // regForms(
          //   controller: _birthdateController,
          //   title: "Opening Time",
          //   logo: CupertinoIcons.clock,
          // ),
          // SizedBox(
          //     height: 15,
          //   ),
          regForms(
            controller: _birthdateController,
            title: "Birthdate (yyyy-mm-dd)",
            logo: Icons.calendar_today,
          ),

          SizedBox(
              height: 15,
            ),
            Image.network(
                          patient.profilepic.toString(),
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
                _genderController.text.isNotEmpty && _bloodController.text.isNotEmpty && 
                _birthdateController.text.isNotEmpty && _medicationsController.text.isNotEmpty &&
                _diseaseController.text.isNotEmpty && _allergyController.text.isNotEmpty){
                    patient.name = _nameController.text;
                    patient.number = _numberController.text;
                    patient.gender = _genderController.text;
                    patient.insurance = _insuranceController.text;
                    patient.blood = _bloodController.text;
                    DateTime selectedBirthdate = DateTime(1990, 1, 1);
                    String formattedDate = "1990-01-01";
                    // In your form submission logic, convert the text entered by the user to a DateTime
                    try {
                      selectedBirthdate = DateTime.parse(_birthdateController.text);
                      formattedDate = DateFormat('yyyy-MM-dd').format(selectedBirthdate);
                      patient.birthdate = formattedDate;
                    } catch (e) {
                      // Handle parsing error if the user enters an invalid date format
                      print("Invalid date format: ${_birthdateController.text}");
                    }
                    patient.medications = _medicationsController.text;
                    patient.disease = _diseaseController.text;
                    patient.allergy = _allergyController.text;
                    var a = await updatePatient(user, patient, _imageFile!);
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
                      MaterialPageRoute(builder: (context) => PatientPage() ),
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
                          Text('Could not update your Patient profile',
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
              title: 'Update Patient',
            ),
        ],
      ),
      ),
    );
  }
}