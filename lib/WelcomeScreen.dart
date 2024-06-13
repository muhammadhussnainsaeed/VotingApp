import 'package:flutter/material.dart';
import 'package:project1/Group1.dart';
import 'package:project1/Group2.dart';
import 'package:project1/FirstPage.dart';
import 'package:project1/SecondPage.dart';
import 'package:project1/ThirdPage.dart';
import 'package:project1/FourthPage.dart';
import 'FifthPage.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handlePageChange);
  }

  void _handlePageChange() {
    setState(() {
      _currentPage = _controller.page!.round();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handlePageChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.00, -4.00),
                end: Alignment(8, 9),
                colors: [Color(0x878494CE), Color(0x89731D60)],
              ),
            ),
          ),
          PageView(
            controller: _controller,
            children: [
              FirstPage(),
              SecondPage(controller: _controller),
              ThirdPage(controller: _controller),
              FourthPage(controller: _controller),
              FifthPage(controller: _controller),
            ],
          ),
          if (_currentPage < 4)
            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == i ? Color(0xFF00A153) : Colors.white,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 35),
                  if (_currentPage < 3) // Only display the button if it's not the last page
                    Group1(controller: _controller),
                  if(_currentPage == 3)
                    Group2(controller: _controller),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
