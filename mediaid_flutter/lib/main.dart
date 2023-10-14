import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/Screens/Profile.dart';
import 'package:mediaid_flutter/Screens/Schedule.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/mychat.dart';
import 'package:mediaid_flutter/pages/patient_list.dart';
import 'package:mediaid_flutter/pages/prescription_list.dart';
import 'package:mediaid_flutter/pages/register_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/pages/home/home.dart';
import 'package:mediaid_flutter/services/chatprovider.dart';

import 'Screens/Doctors.dart';
import 'Screens/Insurance.dart';
// import 'Screens/Home.dart';
import 'constants.dart';
import 'models/user_models.dart';
import 'pages/login_page.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(
    // const MyApp()
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()), // Add your ChatProvider here
        // Other providers if any
      ],
      child: MyApp(),
    ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserCubit(User());
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          // '/': (context) => const Home(), // Define the home route
          '/login': (context) => const SignInPage(), // Define the login route
          '/register': (context) => const SignUpPage(),
          '/prescription_list': (context) => PrescriptionPage(),
          '/patient_list': (context) => PatientPage(),
          '/profile': (context) => Profile(),
          '/insurance': (context) => InsurancePage(),
          '/doctor_list': (context) => Doctors(),
          '/mychat':(context) => mychat(),
          '/schedule':(context) => Schedules(),
        },
        home: FutureBuilder<Box>(
            future: Hive.openBox(tokenBox),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var box = snapshot.data;
                var token = box!.get("token");
                if (token != null) {
                  return FutureBuilder<User?>(
                      future: getUser(token),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            User user = snapshot.data!;
                            user.token = token;
                            context.read<UserCubit>().emit(user);
                            return const Home();
                          } else {
                            return const SignInPage();
                          }
                        } else {
                          return const SignInPage();
                          // return Center(
                          // child: CircularProgressIndicator(),
                          // );
                        }
                      });
                } else {
                  return const SignInPage();
                }
              } else if (snapshot.hasError) {
                return const SignInPage();
              } else {
                // return Center(
                //   child: CircularProgressIndicator(),
                // );
                return const SignInPage();
              }
            }),
        // home: Scaffold(
        //   appBar: AppBar(),

        //   // Add FloatingActionButton
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       // Define what should happen when the button is pressed
        //       Navigator.push(context,
        //           CupertinoPageRoute(builder: (context) => const mychat()));
        //     },
        //     child: const Icon(Icons.support_agent), // Icon for the button
        //   ),
        // ),
      ),
    );
  }
}
