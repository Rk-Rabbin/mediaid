import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mediaid_flutter/Widgets/addpresFormfields.dart';
import 'package:mediaid_flutter/constants.dart';
import 'package:mediaid_flutter/functions/doctor.dart';
import 'package:mediaid_flutter/functions/patient.dart';
import 'package:mediaid_flutter/functions/prescription.dart';
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

class PrescriptionRegistrationForm extends StatefulWidget {
  // final int? userId;

  PrescriptionRegistrationForm();
  @override
  _PrescriptionRegistrationFormState createState() => _PrescriptionRegistrationFormState();
}

class _PrescriptionRegistrationFormState extends State<PrescriptionRegistrationForm> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _doctoridController = TextEditingController();
  TextEditingController _patientidController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
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
            addpresFormfields(hint:'Doctors Id',line: 1,controller: _doctoridController,),
            addpresFormfields(hint:'Patient Id',line: 1,controller: _patientidController,),
            addpresFormfields(hint:'Disease',line: 1,controller: _diseaseController,),
            addpresFormfields(hint:'Hospital',line: 1,controller: _hospitalController,),
            addpresFormfields(hint:'Date (yyyy-mm-dd)',line: 1,controller: _dateController,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: InkWell(
              onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(width: 1,color: Color(0xff32c1e0),)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child:_imageFile == null ?Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Icon(
                              CupertinoIcons.plus_circle_fill,
                              color: CupertinoColors.systemGrey3,
                              size: 150,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                            child: Text(
                              'Add image'  ,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21,
                                  color: Colors.black26
                              ),
                            ),
                          ),
                        ],
                      ):Image.file(_imageFile!),
                    ),
                  ),
                  ),
              ),
            ),
            // addpresFormfields(hint:'Catagory',line: 1,controller: _catagory,),
            addpresFormfields(hint:'Type details',line: 4,controller: _detailsController,),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 5 , 80,  5),
          child: GestureDetector(
            onTap: () async {
                if(_doctoridController.text.isNotEmpty && _patientidController.text.isNotEmpty &&
                _diseaseController.text.isNotEmpty && _detailsController.text.isNotEmpty &&
                _hospitalController.text.isNotEmpty && _dateController.text.isNotEmpty){
                  var a = await createPrescription(user, _diseaseController.text, _dateController.text,
                  _hospitalController.text, _detailsController.text,_doctoridController.text, _patientidController.text, _imageFile!);
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
                          Text('Your prescription has been successfully uploaded',
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
                        Text('Could not upload prescription',
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
            child: Container(
              height:50,
              width: 200,
              decoration: BoxDecoration(
                  color: const Color(0xff32c1e0),
                  borderRadius: BorderRadius.circular(32)),
              child: Center(
                child: Text(
                  'Submit',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}