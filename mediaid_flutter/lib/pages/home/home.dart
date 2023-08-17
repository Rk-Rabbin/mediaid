import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediaid_flutter/api/auth/auth_api.dart';
import 'package:mediaid_flutter/models/user_models.dart';
import 'package:mediaid_flutter/pages/login_page.dart';
import '../../models/user_cubit.dart';


class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Home of ${user.id} ${user.email} ${user.username}"),
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
    );
  }
}