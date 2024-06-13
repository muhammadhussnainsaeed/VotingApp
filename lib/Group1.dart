import 'package:flutter/material.dart';
class Group1 extends StatelessWidget {
  final PageController controller;

  Group1({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          controller.nextPage(duration: Duration(milliseconds: 900), curve: Curves.ease);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Text(
          'Next',
          style: TextStyle(
            color: Color(0xFF00A153),
            fontSize: 17,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ),
    );
  }
}