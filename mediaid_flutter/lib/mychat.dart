import 'package:flutter/material.dart';

import 'package:flutter_tawk/flutter_tawk.dart';

void main() => runApp(const mychat());

class mychat extends StatelessWidget {
  const mychat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mediaid'),
          backgroundColor: Color.fromARGB(255, 162, 206, 235),
          elevation: 0,
        ),
        body: Tawk(
          directChatLink:
              'https://tawk.to/chat/646f69ca74285f0ec46d9c83/1h19jaglp',
          visitor: TawkVisitor(
            name: 'User',
            email: 'user@gmail.com',
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
