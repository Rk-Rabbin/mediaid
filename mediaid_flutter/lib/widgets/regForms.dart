import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class regForms extends StatelessWidget {
    final title;
    final IconData logo;
  TextEditingController? controller;
    final bool obsecure;

  regForms({Key? key,
     this.title, required this.logo, this.controller, this.obsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: 390,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
               color: Colors.black12
            ),
            color: const Color(0xFFfaf6f5),
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0,0,0),
          child: TextField(
            obscureText: obsecure,
            controller: controller,
            decoration: InputDecoration(
              icon:  Padding(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Icon( logo,
                color: Colors.black26,
                size: 18,),
              ),
              hintText: title,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.black26,
              ),
              focusColor: Colors.transparent,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
            cursorColor: Colors.black45,
            cursorHeight: 18,
            cursorWidth: 1,
          ),
        ));
  }
}
