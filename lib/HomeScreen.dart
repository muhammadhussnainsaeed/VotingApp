import 'package:flutter/material.dart';
import 'FifthPage.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final dynamic controller;

  HomeScreen({required this.name, this.controller});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Declare controllers outside of the build method
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool isNationalSelected = true; // Initial selection state

  // Sample candidate data
  final List<Map<String, String>> candidates = [
    {
      'name': 'Panda B.',
      'description': 'The panda, with its endearing black-and-white coat, embodies both charm and conservation wqeqwe qweq wequwe qwg4 32hdjg suqwbe qwue',
      'image': 'assets/images/panda.jpg', // Example image path
    },
    {
      'name': 'Tiger A.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/tiger.jpg', // Example image path
    },
    {
      'name': 'Tiger j.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/tiger.jpg', // Example image path
    },
    {
      'name': 'Tiger j.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/tiger.jpg', // Example image path
    },
    // Add more candidates here
  ];

  void _logout() {
    // Clear the text fields
    _cnicController.clear();
    _pinController.clear();

    // Navigate to FifthPage with the controller
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FifthPage(controller: widget.controller)),
    );
  }

  void _selectNational() {
    setState(() {
      isNationalSelected = true;
    });
  }

  void _selectProvincial() {
    setState(() {
      isNationalSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi ${widget.name}',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.black),
                onPressed: _logout,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Add padding around the content
        child: Column(
          children: [
            Container(
              width: 331,
              height: 55,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 331,
                      height: 55,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 11,
                    child: Container(
                      width: 308,
                      height: 35,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 154,
                            top: 2.47,
                            child: Opacity(
                              opacity: 0.80,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..translate(0.0, 0.0)
                                  ..rotateZ(1.57),
                                child: Container(
                                  width: 30.24,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        strokeAlign: BorderSide.strokeAlignCenter,
                                        color: Color(0xFF939393),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: _selectNational,
                              child: Container(
                                width: 143,
                                height: 35,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 143,
                                        height: 35,
                                        decoration: ShapeDecoration(
                                          color: isNationalSelected
                                              ? Color(0x1900A154)
                                              : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 10,
                                      top: 10,
                                      child: Text(
                                        'National Assembly',
                                        style: TextStyle(
                                          color: isNationalSelected
                                              ? Color(0xFF00A154)
                                              : Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 166,
                            top: 0,
                            child: GestureDetector(
                              onTap: _selectProvincial,
                              child: Container(
                                width: 142,
                                height: 35,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 5,
                                      top: 10,
                                      child: Text(
                                        'Provincial Assembly',
                                        style: TextStyle(
                                          color: isNationalSelected
                                              ? Colors.black
                                              : Color(0xFF00A154),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 142,
                                        height: 35,
                                        decoration: ShapeDecoration(
                                          color: isNationalSelected
                                              ? Colors.white.withOpacity(0.1)
                                              : Color(0x1900A154),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Add some space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Candidates',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${candidates.length} candidates',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Add some space between the title and the candidate boxes
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Add space between candidate boxes
                    child: Stack(
                      children: [
                        Container(
                          width: screenWidth - 32, // Subtract padding from screen width
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(left: 100, top: 10, right: 8, bottom: 10 ), // Add padding for the text
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                candidate['name'] ?? 'Candidate',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4), // Add some space between the texts
                              Text(
                                candidate['description'] ?? '',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.clip,
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
                              color: Colors.blue, // Placeholder for image
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: candidate['image'] != null
                                ? Image.asset(
                              candidate['image']!,
                              fit: BoxFit.cover,
                            )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}