import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class PersonalDetailsScreen extends StatelessWidget {
  final String cnic;
  final String name;
  final String district;
  final String dob;
  final String image;

  PersonalDetailsScreen({required this.image,required this.cnic,required this.name,required this.district,required this.dob});

  String get profilePic => 'assets/images/panda.jpg';

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = _decodeBase64Image(image);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false, // Disable the back button
        actions: [
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop(); // Close the screen
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300], // Set the background color to grey
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imageBytes.isNotEmpty ? MemoryImage(imageBytes) : null,
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
            SizedBox(height: 20),
            _buildDetailRow('Name', name),
            _buildDetailRow('CNIC', cnic),
            _buildDetailRow('Date of Birth', dob),
            _buildDetailRow('District', district),
          ],
        ),
      ),
    );
  }

  Uint8List _decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return Uint8List(0); // Return an empty Uint8List in case of an error
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold, // Make the label text bold
            ),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600, // Make the value text slightly bolder
            ),
          ),
        ],
      ),
    );
  }
}
