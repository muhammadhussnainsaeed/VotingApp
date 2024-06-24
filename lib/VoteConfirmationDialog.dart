import 'package:flutter/material.dart';

class VoteConfirmationHelper {
  static void showProvincialConfirmationDialog(BuildContext context, Map<String, dynamic> candidate, Function(String) onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Confirm',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Confirm Vote for ${candidate['name']} as Provincial Candidate?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF00A153),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onConfirm(candidate['cnic']!); // Execute the callback with candidate name
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Vote Confirmed for ${candidate['name']} as Provincial Candidate!'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Confirm!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showNationalConfirmationDialog(BuildContext context, Map<String, dynamic> candidate, Function(String) onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Confirm National Candidate',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Confirm Vote for ${candidate['name']} as National Candidate?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF00A153),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                onConfirm(candidate['cnic']!); // Execute the callback with candidate name
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Vote Confirmed for ${candidate['name']} as National Candidate!'),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Confirm!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}