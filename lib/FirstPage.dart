import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Voting App',
                  textAlign: TextAlign.left, // Align text to the left
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Use theme color for text
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to Voting App, your gateway to secure and convenient voting. Stay informed and make your vote count!',
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
    );
  }
}