import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          title: Text('Settings'),
          backgroundColor: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[300], // Set the background color to a light gray
      body: Center(
        child: Text(
          'Settings Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}