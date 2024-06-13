import 'package:flutter/material.dart';

class VoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          title: Text('Vote'),
          backgroundColor: Colors.white,
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Text(
          'Vote Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}