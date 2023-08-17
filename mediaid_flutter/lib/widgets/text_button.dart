import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final EdgeInsets margin;
  VoidCallback? onTap;
  CustomTextButton({
    super.key,
    this.title = '',
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 64,
        height:62,
        width: 265,
        decoration: BoxDecoration(
            color: const Color(0xff32c1e0),
            borderRadius: BorderRadius.circular(32)),
      // width: double.infinity,
      margin: margin,
      child: TextButton(
        onPressed: onTap,
        child: Center(
           child: Text(
            title,
            style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
      ),
      ),
    );
  }
}
// Footer