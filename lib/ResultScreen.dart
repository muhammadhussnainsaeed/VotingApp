import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Text(
          'Results Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}