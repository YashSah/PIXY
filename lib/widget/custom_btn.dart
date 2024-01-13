import 'package:flutter/material.dart';
import 'package:pixy/main.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
              elevation: 0,
              backgroundColor: Theme.of(context).buttonColor,
              minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 50),
          ),
          onPressed: onTap,
          child: Text(text),
      ),
    );
  }
}
