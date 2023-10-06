import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:mediaid_flutter/pages/home/home.dart';

import 'models/user_cubit.dart';
import 'models/user_models.dart';

// void main() => runApp(const mychat());

class mychat extends StatelessWidget {
  const mychat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mediaid'),
          backgroundColor: Color(0xff82bcc4),
                leading: IconButton(
    icon: Icon(Icons.home),
    onPressed: () {
      // Add your navigation logic here
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Home()),
      );
    },
  ),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink:
              'https://tawk.to/chat/646f69ca74285f0ec46d9c83/1h19jaglp',
          visitor: TawkVisitor(
            name: user.username,
            email: user.email,
          ),
          onLoad: () {
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
