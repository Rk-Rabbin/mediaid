import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediaid_flutter/Widgets/buttons/ActionButton.dart';
import '../models/prescription_model.dart';
import '../Widgets/addpresFormfields.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class AddPresc extends StatefulWidget {
  const AddPresc({Key? key}) : super(key: key);

  @override
  State<AddPresc> createState() => _AddPrescState();
}

class _AddPrescState extends State<AddPresc> {
  TextEditingController _name= TextEditingController();
  TextEditingController _catagory= TextEditingController();
  TextEditingController _details= TextEditingController();
  File? _selectedImage;
  String? _selectedImagePath;
  PrescriptionData? _prescriptionData;
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _selectedImagePath = pickedImage.path;
      });
    }
  }
  void _submitPrescription() {
    final String doctorsName = _name.text;
    final String category = _catagory.text;
    final String typeDetails =_details.text;
    final ImageProvider imagePath =  FileImage(File(_selectedImagePath!));

    final prescriptionData = PrescriptionData(
      image: imagePath,
      title: doctorsName,
      category: category,
      details: typeDetails,
    );
    setState(() {
      _prescriptionData = prescriptionData;
      print(_name.text);
    });
    Navigator.pop(context,prescriptionData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading:IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            splashRadius: 1,
            icon: const Icon(CupertinoIcons.xmark,color: Colors.black,size: 20,)),
        title: Row(
          children: const [
            Expanded(
              flex: 9,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0 , 20,  0),
                child: Text(
                  'Prescription'  ,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
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
            addpresFormfields(hint:'Doctors Name',line: 1,controller: _name,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: InkWell(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(width: 1,color: Color(0xff32c1e0),)
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child:_selectedImage == null ?Column(
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
                      ):Image.file(_selectedImage!),
                    ),
                  ),
                  ),
              ),
            ),

            addpresFormfields(hint:'Catagory',line: 1,controller: _catagory,),
            addpresFormfields(hint:'Type details',line: 4,controller: _details,),

          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(80, 5 , 80,  5),
          child: GestureDetector(
            onTap: () {
              _submitPrescription();
            },
            child: Container(
              height:62,
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
