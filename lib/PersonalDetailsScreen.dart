import 'package:flutter/material.dart';

class PersonalDetailsScreen extends StatelessWidget {
  final String cnic;

  PersonalDetailsScreen({required this.cnic});

  String get profilePic => 'assets/images/panda.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profilePic),
              onBackgroundImageError: (_, __) => const Icon(Icons.error),
            ),
            SizedBox(height: 20),
            _buildDetailRow('Name', 'John Doe'),
            _buildDetailRow('CNIC', cnic),
            _buildDetailRow('Date of Birth', '01-01-1990'),
            _buildDetailRow('District', 'XYZ District'),

          ],
        ),
      ),
    );
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
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}