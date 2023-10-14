import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mediaid_flutter/Widgets/addpresFormfields.dart';
import 'package:mediaid_flutter/functions/prescription.dart';
import 'package:mediaid_flutter/models/prescription_model.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/pages/prescription_list.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_models.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class PrescriptionUpdateForm extends StatefulWidget {
  // final int? userId;
  final PrescriptionModel prescription;
  const PrescriptionUpdateForm({
    super.key,
    required this.prescription
  });

  @override
  _PrescriptionUpdateFormState createState() => _PrescriptionUpdateFormState();
}

class _PrescriptionUpdateFormState extends State<PrescriptionUpdateForm> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _doctoridController = TextEditingController();
  TextEditingController _patientidController = TextEditingController();
  TextEditingController _diseaseController = TextEditingController();
  TextEditingController _hospitalController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();


  late User user;
  File? _imageFile;
  // File _imageFile = File(''); // Provide an initial empty File or your default image file path
  late final PrescriptionModel prescription;

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
    _imageFile = await downloadNetworkImage(prescription.upload);
    });
  }
  }

  Future<void> _setImage() async {
  if (_imageFile == null) {
    // Perform asynchronous work here
    final File imageFile = await downloadNetworkImage(prescription.upload);

    // Once the asynchronous work is complete, update the state using setState
    setState(() {
      _imageFile = imageFile;
    });
  }
}

   @override
  void initState() {
    user = context.read<UserCubit>().state;
    prescription = widget.prescription;
    _diseaseController.text = prescription.disease;
    _dateController.text = prescription.date;
    _detailsController.text = prescription.presctext;
    _hospitalController.text = prescription.hospital;
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
      appBar: AppBar(title: Text('Prescription Update'),
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
          SizedBox(height: 30,),
          addpresFormfields(hint:'Disease',line: 1,controller: _diseaseController,),
          addpresFormfields(hint:'Hospital',line: 1,controller: _hospitalController,),
          addpresFormfields(hint:'Date (yyyy-mm-dd)',line: 1,controller: _dateController,),
          addpresFormfields(hint:'Type details',line: 4,controller: _detailsController,),
          SizedBox(
              height: 15,
            ),
            Image.network(
                          prescription.upload.toString(),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Pick from Gallery'),
            ),
            SizedBox(height: 165,),
          CustomTextButton(
              onTap: () async {
                if(_diseaseController.text.isNotEmpty && _detailsController.text.isNotEmpty &&
                _hospitalController.text.isNotEmpty && _dateController.text.isNotEmpty){
                    prescription.disease = _diseaseController.text;
                    prescription.presctext = _detailsController.text;
                    prescription.date = _dateController.text;
                    prescription.hospital = _hospitalController.text;
                    var a = await updatePrescription(user, prescription, _imageFile!);
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
                            Text('Your prescription has been successfully updated',
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
                      MaterialPageRoute(builder: (context) => PrescriptionPage() ),
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
                          Text('Could not update your Prescription',
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
              title: 'Update Prescription',
            ),
        ],
      ),
      ),
    );
  }
}