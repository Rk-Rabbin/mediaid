import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Screens/Insurance.dart';
import 'package:mediaid_flutter/functions/insurance.dart';
import 'package:mediaid_flutter/models/insurance_model.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import '../Widgets/regForms.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_models.dart';


class InsuranceUpdateForm extends StatefulWidget {
  // final int? userId;
  final InsuranceModel insurance;
  const InsuranceUpdateForm({
    super.key,
    required this.insurance
  });

  @override
  _InsuranceUpdateFormState createState() => _InsuranceUpdateFormState();
}

class _InsuranceUpdateFormState extends State<InsuranceUpdateForm> {

  final _formKey = GlobalKey<FormState>();  
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _policyController = TextEditingController();


  late User user;
  late final InsuranceModel insurance;

   @override
  void initState() {
    user = context.read<UserCubit>().state;
    insurance = widget.insurance;
    _nameController.text = insurance.name;
    _numberController.text = insurance.number;
    _addressController.text = insurance.address;
    _policyController.text = insurance.policy;
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
      appBar: AppBar(title: Text('Insurance Company Update'),
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
            title: "Company Name",
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
            controller: _addressController,
            title: "Address",
            logo: CupertinoIcons.location,
          ),
          SizedBox(
              height: 15,
            ),
          regForms(
            controller: _policyController,
            title: "Policy",
            logo: CupertinoIcons.book,
          ),
          SizedBox(
              height: 15,
            ),

          CustomTextButton(
              onTap: () async {
                if(_nameController.text.isNotEmpty && _numberController.text.isNotEmpty &&
                _addressController.text.isNotEmpty && _policyController.text.isNotEmpty){
                    insurance.name = _nameController.text;
                    insurance.number = _numberController.text;
                    insurance.address = _addressController.text;
                    insurance.policy = _policyController.text;
                    var a = await updateInsurance(user, insurance);
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
                      MaterialPageRoute(builder: (context) => InsurancePage() ),
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
                          Text('Could not update your Insurance profile',
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
              title: 'Update Insurance Info',
            ),
        ],
      ),
      ),
    );
  }
}