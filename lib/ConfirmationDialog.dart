import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirmationConfirmed;

  ConfirmationDialog({required this.onConfirmationConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust border radius here
      ),
      title: Text(
        'Confirm',
        style: TextStyle(
          fontWeight: FontWeight.bold, // Increase font weight
        ),
      ),
      content: Text('Are you sure you want to change PIN?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Color(0xFF00A153),
              borderRadius: BorderRadius.circular(8.0), // Adjust border radius here
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
            Navigator.of(context).pop(); // Close the dialog
            onConfirmationConfirmed();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8.0), // Adjust border radius here
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
  }
}
