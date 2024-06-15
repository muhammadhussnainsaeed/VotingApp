import 'package:flutter/material.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final dynamic controller;

  HomeScreen({required this.name, this.controller});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool isNationalSelected = true;

  final List<Map<String, String>> candidates = [
    {
      'name': 'Candidate1',
      'description':
      'The panda, with its endearing black-and-white coat, embodies both charm and conservation...',
      'image': 'assets/images/cand.jpg',
    },
    {
      'name': 'Tiger A.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/uba.jpeg',
    },
    {
      'name': 'Tiger J.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/ali.jpg',
    },
    {
      'name': 'Tiger J.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/tiger.jpg',
    },
  ];

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(
          onLogoutConfirmed: () {
            // Clear the text fields
            _cnicController.clear();
            _pinController.clear();

            // Navigate to FifthPage with the controller
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FifthPage(controller: widget.controller)),
            );
          },
        );
      },
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
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi ${widget.name}',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.black),
                onPressed: () => _logout(context), // Corrected onPressed
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _buildSelectionToggle(screenWidth),
            SizedBox(height: 40),
            _buildCandidatesHeader(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: CandidateCard(candidate: candidate, screenWidth: screenWidth),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionToggle(double screenWidth) {
    double toggleWidth = screenWidth - 60; // 60 accounts for padding on both sides
    double buttonWidth = (toggleWidth - 30) / 2; // 30 accounts for the space between the buttons

    return Container(
      width: toggleWidth,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: toggleWidth,
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
              width: toggleWidth - 24,
              height: 35,
              child: Stack(
                children: [
                  Positioned(
                    left: buttonWidth + 2,
                    top: 2.47,
                    child: Opacity(
                      opacity: 0.80,
                      child: Transform(
                        transform: Matrix4.identity()..rotateZ(1.57),
                        child: Container(
                          width: 30.24,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                color: Color(0xFF939393),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildToggleOption('National Assembly', _selectNational, isNationalSelected, width: buttonWidth - 10),
                  _buildToggleOption('Provincial Assembly', _selectProvincial, !isNationalSelected, left: buttonWidth + 15, width: buttonWidth - 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption(String text, VoidCallback onTap, bool isSelected, {double left = 0, double width = 143}) {
    return Positioned(
      left: left,
      top: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: 35,
          decoration: ShapeDecoration(
            color: isSelected ? Color(0x1900A154) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Color(0xFF00A154) : Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCandidatesHeader() {
    return Row(
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
    );
  }
}

class CandidateCard extends StatelessWidget {
  final Map<String, String> candidate;
  final double screenWidth;

  const CandidateCard({required this.candidate, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: screenWidth - 32,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          padding: const EdgeInsets.only(left: 100, top: 10, right: 8, bottom: 10),
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
              SizedBox(height: 4),
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
              color: Colors.blue,
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
    );
  }
}