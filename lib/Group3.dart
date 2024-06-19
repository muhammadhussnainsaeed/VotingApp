import 'package:flutter/material.dart';

class Group3 extends StatelessWidget {
  final VoidCallback onPressed;

  Group3({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 298,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF00A153),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Text(
          'Confirm',
          style: TextStyle(
            color: Colors.white,
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
