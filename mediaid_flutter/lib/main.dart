import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/register_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/models/user_cubit.dart';
import 'package:mediaid_flutter/pages/home/home.dart';

import 'constants.dart';
import 'models/user_models.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
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
        home: const SignUpPage(),
      ),
    );
  }
}