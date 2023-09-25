import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/main.dart';
import 'package:mediaid_flutter/models/user_models.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediaid_flutter/Widgets/buttons/ActionButton.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Widgets/buttons/backbutton.dart';
import '../Widgets/formFields.dart';

import '../api/auth/auth_api.dart';
import '../models/user_cubit.dart';
import '../theme.dart';
import '../widgets/field.dart';
import '../widgets/text_button.dart';
import 'forgotpass_page.dart';
import 'register_page.dart';
import 'package:url_launcher/url_launcher.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
       leading: const backbutton(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            formFields(
              title: "Enter your username",
              logo: CupertinoIcons.person,
              controller: emailController,

            ),
            SizedBox(
              height: 15,
            ),
            formFields(
              title: "Enter your password", 
              logo: CupertinoIcons.lock,
              controller: passwordController,
              obsecure: true,),
            const SizedBox(
              height: 20,
            ),

Align(
  alignment: Alignment.center,
  child: GestureDetector(
    onTap: () async {
      const url = 'http://127.0.0.1:8000/password-reset/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    },
    child: Container(
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // You can customize the text color
        ),
      ),
    ),
  ),
),






          //   Align(
          //   alignment: Alignment.center,
          //   child: Container(
          //     child: TextButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => ForgotPassPage()),
          //         );
          //       },
          //       child: Text(
          //         "Forgot Password?",
          //           style: blackTextStyle.copyWith(
          //           fontSize: 16,
          //           fontWeight: semiBold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(
              height: 30,
            ),

            CustomTextButton(
            onTap: () async {
              var authRes =
                  await userAuth(emailController.text, passwordController.text);
              if (authRes.runtimeType == String) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                          alignment: Alignment.center,
                          height: 200,
                          width: 250,
                          decoration: BoxDecoration(),
                          child: Text(authRes)),
                    );
                  },
                );
              } else if (authRes.runtimeType == User) {
                User user = authRes;
                context.read<UserCubit>().emit(user);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
              }
            },
            title: 'Login',
          ),

          Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register now.",
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ],
        ),
      ),      
    );
  }
}