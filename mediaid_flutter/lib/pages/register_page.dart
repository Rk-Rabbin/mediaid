import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/widgets/field.dart';
import 'package:mediaid_flutter/widgets/text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediaid_flutter/Widgets/buttons/ActionButton.dart';
import 'package:mediaid_flutter/Widgets/buttons/backbutton.dart';
import 'package:mediaid_flutter/Widgets/formFields.dart';

import '../models/user_models.dart';
import '../theme.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Sign Up',
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
              height: 40,
            ),
            formFields(
              title: "Enter user name",
              logo: CupertinoIcons.person,
              controller: nicknameController,
            ),
            SizedBox(
              height: 15,
            ),
            formFields(
              title: "Enter your email",
              logo: CupertinoIcons.mail,
              controller: emailController,
            ),
            SizedBox(
              height: 15,
            ),
            formFields(
              title: "Enter your password", 
              logo: CupertinoIcons.lock,
              controller: passwordController,
              obsecure: true,
              ),
              SizedBox(
              height: 15,
            ),
            formFields(
              title: "Confirm password", 
              logo: CupertinoIcons.lock,
              controller: confirmPassword,
              obsecure: true,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
            ),

          CustomTextButton(
            title: 'Register',
            margin: EdgeInsets.only(top: 50),
            onTap: () async {
              var authRes = await registerUser(
                  emailController.text,
                  nicknameController.text,
                  passwordController.value.text,
                  confirmPassword.text);

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
              else if (authRes.runtimeType == int) {
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
                  // context: context,
                  // builder: (context) {
                  //   return Dialog(
                  //     child: Container(
                  //         alignment: Alignment.center,
                  //         height: 200,
                  //         width: 250,
                  //         decoration: BoxDecoration(),
                  //         child: Text('Your account has been successfully registered',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.w400,
                  //         color: CupertinoColors.inactiveGray
                  //         ),
                  //         ),
                  //   ),
                  //   );
                  // },
                );
              }
            },
          ),
          Container(
            margin: EdgeInsets.only(
              top: 40,
              bottom: 74,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text(
                    "Have an account? Login",
                      style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),


            // const SizedBox(
            //   height: 50,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     showDialog(context: context, builder: (context)=> AlertDialog(
            //       content: Container(
            //         height: 350,
            //         width: 30,
            //         child: Column(
            //           children: [
            //             Container(
            //               height: 100,
            //               width: 100,
            //               decoration: BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: Color(0xFFfaf6f5),
            //               ),
            //               child: const Icon(
            //                 Icons.check,
            //                 size: 60,
            //                 color: Color(0xff32c1e0),
            //               ),
            //             ),
            //             SizedBox(height: 20,),
            //             Text('Success',style: TextStyle(
            //               fontSize: 23,
            //               fontWeight: FontWeight.w800
            //             ),),
            //             SizedBox(height: 20,),
            //             Text('Your account has been successfully registered',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //               fontSize: 17,
            //               fontWeight: FontWeight.w400,
            //               color: CupertinoColors.inactiveGray
            //             ),),
            //             SizedBox(height: 80,),
            //             ActionButton(title:'Login',route: '/login')
            //           ],
            //         ),
            //       ),
            //     ));
            //   },


          // Container(
          //   margin: EdgeInsets.only(
          //     top: 40,
          //     bottom: 74,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => SignInPage()),
          //           );
          //         },
          //         child: Text(
          //           "Have an account? Login",
          //           style: whiteTextStyle.copyWith(
          //             fontSize: 16,
          //             fontWeight: semiBold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),



    //           child: Container(
    //             height:62,
    //             width: 265,
    //             decoration: BoxDecoration(
    //                 color: const Color(0xff32c1e0),
    //                 borderRadius: BorderRadius.circular(32)),
    //             child: Center(
    //               child: Text(
    //                'Sign Up',
    //                 style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 19,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Text("Already have an account? Login")
          ],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: bgColor,
    //   body: ListView(
    //     padding: EdgeInsets.symmetric(
    //       horizontal: defaultMargin,
    //     ),
    //     children: [
    //       Container(
    //         margin: EdgeInsets.only(top: 100),
    //         child: Text(
    //           "Register",
    //           style: whiteTextStyle.copyWith(
    //             fontSize: 20,
    //             fontWeight: semiBold,
    //           ),
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       CustomField(
    //         iconUrl: 'assets/icon_name.png',
    //         hint: 'Username',
    //         controller: nicknameController,
    //       ),
    //       CustomField(
    //         iconUrl: 'assets/icon_email.png',
    //         hint: 'Email',
    //         controller: emailController,
    //       ),
    //       CustomField(
    //         iconUrl: 'assets/icon_password.png',
    //         hint: 'Password',
    //         controller: passwordController,
    //         obsecure: true,
    //       ),
    //       CustomField(
    //         iconUrl: 'assets/icon_password.png',
    //         hint: 'Confirm Password',
    //         controller: confirmPassword,
    //         obsecure: true,
    //       ),
    //       CustomTextButton(
    //         title: 'Register',
    //         margin: EdgeInsets.only(top: 50),
    //         onTap: () async {
    //           var authRes = await registerUser(
    //               emailController.text,
    //               nicknameController.text,
    //               passwordController.value.text,
    //               confirmPassword.text);

    //           if (authRes.runtimeType == String) {
    //             showDialog(
    //               context: context,
    //               builder: (context) {
    //                 return Dialog(
    //                   child: Container(
    //                       alignment: Alignment.center,
    //                       height: 200,
    //                       width: 250,
    //                       decoration: BoxDecoration(),
    //                       child: Text(authRes)),
    //                 );
    //               },
    //             );
    //           } else if (authRes.runtimeType == User) {
    //             User user = authRes;
    //             context.read<UserCubit>().emit(user);
    //             Navigator.of(context).push(MaterialPageRoute(
    //               builder: (context) {
    //                 return HomePage();
    //               },
    //             ));
    //           }
    //           else if (authRes.runtimeType == int) {
    //             showDialog(
    //               context: context,
    //               builder: (context) {
    //                 return Dialog(
    //                   child: Container(
    //                       alignment: Alignment.center,
    //                       height: 200,
    //                       width: 250,
    //                       decoration: BoxDecoration(),
    //                       child: Text("Registration Successful")),
    //                 );
    //               },
    //             );
    //           }
    //         },
    //       ),
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 40,
          //     bottom: 74,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => SignInPage()),
          //           );
          //         },
          //         child: Text(
          //           "Have an account? Login",
          //           style: whiteTextStyle.copyWith(
          //             fontSize: 16,
          //             fontWeight: semiBold,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
      //   ],
      // ),
    // );
  }
}