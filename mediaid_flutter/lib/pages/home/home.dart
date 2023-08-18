import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/models/user_models.dart';
import 'package:mediaid_flutter/pages/login_page.dart';
import 'package:mediaid_flutter/theme.dart';
import '../../models/user_cubit.dart';


class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Home"),
        actions: [
          OutlinedButton(
              onPressed: () async {
                await logOut(user.token!);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SignInPage()),
                    (route) => false);
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),

      body: Padding(
        padding: EdgeInsets.only(left: 70.0, right: 20.0, bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "User Id: ${user.id} \nEmail: ${user.email} \nUsername: ${user.username}",
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            ],
        ),
      ),
    );
  }
}