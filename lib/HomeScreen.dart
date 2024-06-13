import 'package:flutter/material.dart';
import 'FifthPage.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final dynamic controller;

  // Declare controllers outside of the build method
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  HomeScreen({required this.name, this.controller});

  @override
  Widget build(BuildContext context) {
    void _logout() {
      // Clear the text fields
      _cnicController.clear();
      _pinController.clear();

      // Navigate to FifthPage with the controller
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FifthPage(controller: controller)),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow
          backgroundColor: Colors.white,
          title: Text(
            'Hi $name',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: Colors.black),
              onPressed: _logout,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(25.0), // Add padding around the content
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth - 32, // Subtract padding from screen width
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(left: 100, top: 10, right: 8), // Add padding for the text
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Panda B.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4), // Add some space between the texts
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 250) {
                            return Text(
                              "The panda, with its endearing black-and-white coat, embodies both charm and conservation... ",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            );
                          } else {
                            return Text(
                              "The panda, with its endearing black-and-white coat, embodies both charm and conservation... Read more",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 13,
                  child: Container(
                    width: 72,
                    height: 69,
                    decoration: BoxDecoration(
                      color: Colors.blue, // You can change the color to whatever you prefer
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}