import 'package:flutter/material.dart';
import 'ResultScreen.dart';

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  bool isNationalSelected = true;

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

  Widget _buildToggleOption(String label, VoidCallback onTap, bool isSelected, {double? left, required double width}) {
    return Positioned(
      left: left,
      top: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: 35,
          decoration: ShapeDecoration(
            color: isSelected ? Color(0xFF00A153) : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: Color(0xFF00A153),
                width: isSelected ? 0 : 1,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFF00A153),
              fontWeight: FontWeight.bold,
            ),
          ),
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
                  _buildToggleOption(
                    'National Assembly',
                    _selectNational,
                    isNationalSelected,
                    width: buttonWidth - 10,
                  ),
                  _buildToggleOption(
                    'Provincial Assembly',
                    _selectProvincial,
                    !isNationalSelected,
                    left: buttonWidth + 15,
                    width: buttonWidth - 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          title: Text('Vote', style: TextStyle(color: Colors.black)), // Set text color to black
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A153), // Green color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Slightly curved corners
                  ),
                ),
                child: Text(
                  'Results',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSelectionToggle(screenWidth),
          SizedBox(height: 40),
          Text(
            'Vote Screen',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}

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