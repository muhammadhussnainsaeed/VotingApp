import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final PageController controller;

  ThirdPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Secure Login',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Use theme color for text
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Login using your CNIC and PIN for a secure experience. Easily update your PIN to keep your account safe.',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black, // Use theme color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
