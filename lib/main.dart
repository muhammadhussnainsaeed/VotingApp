import 'package:flutter/material.dart';
import 'package:project1/Group1.dart';
import 'package:project1/Group2.dart';
import 'package:project1/Group3.dart';
import 'package:project1/Group4.dart';

void main() {
  runApp(const VotingApp());
}

class VotingApp extends StatelessWidget {
  const VotingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String name = 'John Doe';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.teal, // Change the primary color to teal
        hintColor: Colors.tealAccent, // Change the accent color to tealAccent
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal, // Change the background color of the ElevatedButton to teal
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}

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

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you ready to vote?',
                  textAlign: TextAlign.right, // Align text to the left
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.headline1!.color, // Use theme color for text
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to BallotChain, the app that makes voting secure & transparent. Take part in elections, wherever you are.',
                  textAlign: TextAlign.left, // Align text to the left
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).textTheme.bodyText1!.color, // Use theme color for text
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final PageController controller;

  SecondPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          } else {
            controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you ready for the next step?',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color, // Use theme color for text
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Get ready to explore more features of BallotChain. Your participation matters!',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1!.color, // Use theme color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final PageController controller;

  ThirdPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you ready for the next step? (Third Page)',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color, // Use theme color for text
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Get ready to explore more features of BallotChain. Your participation matters!',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1!.color, // Use theme color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  final PageController controller;

  FourthPage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0), // Added padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you ready for the next step? (Third Page)',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline1!.color, // Use theme color for text
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Get ready to explore more features of BallotChain. Your participation matters!',
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1!.color, // Use theme color for text
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FifthPage extends StatefulWidget {
  final PageController controller;

  FifthPage({required this.controller});

  @override
  _FifthPageState createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _cnicFocusNode = FocusNode();
  final FocusNode _pinFocusNode = FocusNode();

  bool _isCnicValid = false;
  bool _isPinValid = false;
  String _cnicErrorMessage = '';
  String _pinErrorMessage = '';

  @override
  void initState() {
    super.initState();
    _cnicFocusNode.addListener(_handleFocusChange);
    _pinFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _cnicController.dispose();
    _pinController.dispose();
    _cnicFocusNode.removeListener(_handleFocusChange);
    _pinFocusNode.removeListener(_handleFocusChange);
    _cnicFocusNode.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_cnicFocusNode.hasFocus || _pinFocusNode.hasFocus) {
      // Trigger a rebuild when the focus state changes
      setState(() {});
    }
  }

  void _validateCnic(String value) {
    setState(() {
      if (value.length == 13 && RegExp(r'^[0-9]+$').hasMatch(value)) {
        _isCnicValid = true;
        _cnicErrorMessage = '';
      } else {
        _isCnicValid = false;
        _cnicErrorMessage = value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
            ? 'Only 13 numbers are allowed'
            : '';
      }
    });
  }

  void _validatePin(String value) {
    setState(() {
      if (value.length == 6 && RegExp(r'^[0-9]+$').hasMatch(value)) {
        _isPinValid = true;
        _pinErrorMessage = '';
      } else {
        _isPinValid = false;
        _pinErrorMessage = value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
            ? 'Only 6 numbers are allowed'
            : '';
      }
    });
  }

  bool get _isFormValid => _isCnicValid && _isPinValid;

  void _onNextPressed() {
    // Simulate verification process
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SixthPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              widget.controller.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login with your CNIC',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00A153),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Your CNIC is used to fetch your data and verify that you have voted.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      focusNode: _cnicFocusNode,
                      controller: _cnicController,
                      onChanged: _validateCnic,
                      cursorColor: Color(0xFF00A153), // Change the cursor color
                      decoration: InputDecoration(
                        hintText: 'Enter your CNIC',
                        hintStyle: TextStyle(
                          color: Color(0xFF939393),
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Color(0xFFD6D6D6)), // Color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Color(0xFF00A153)), // Change border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    if (_cnicErrorMessage.isNotEmpty)
                      Text(
                        _cnicErrorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    SizedBox(height: 20),
                    TextField(
                      focusNode: _pinFocusNode,
                      controller: _pinController,
                      onChanged: _validatePin,
                      cursorColor: Color(0xFF00A153), // Change the cursor color
                      decoration: InputDecoration(
                        hintText: 'Enter your PIN',
                        hintStyle: TextStyle(
                          color: Color(0xFF939393),
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Color(0xFFD6D6D6)), // Color when not focused
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: BorderSide(color: Color(0xFF00A153)), // Change border color when focused
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    if (_pinErrorMessage.isNotEmpty)
                      Text(
                        _pinErrorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: _isFormValid ? _onNextPressed : null,
                      style: ElevatedButton.styleFrom(
                        primary: _isFormValid ? Color(0xFF00A153) : Color(0x7F8BEEB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        minimumSize: Size(298, 60), // Set the size
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SixthPage extends StatefulWidget {
  @override
  _SixthPageState createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/verified.png', // Ensure this image is added to your assets folder and mentioned in pubspec.yaml
                width: 300,
                height: 300,
              ),
              SizedBox(height: 15),
              Text(
                'Verification Successful',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00A153),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Voting App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[

    HomeScreen(name: name),
    VoteScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        width: 390, // Set the width of the container
        height: 95, // Set the height of the container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0), // Adjust the border radius as needed
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30, // Set the width of the icon
                height: 30, // Set the height of the icon
                child: ImageIcon(
                  AssetImage(_selectedIndex == 0
                      ? 'assets/icons/homegreen.png'
                      : 'assets/icons/home.png'),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30, // Set the width of the icon
                height: 30, // Set the height of the icon
                child: ImageIcon(
                  AssetImage(_selectedIndex == 1
                      ? 'assets/icons/votegreen.png'
                      : 'assets/icons/vote.png'),
                ),
              ),
              label: 'Vote',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 30, // Set the width of the icon
                height: 30, // Set the height of the icon
                child: ImageIcon(
                  AssetImage(_selectedIndex == 2
                      ? 'assets/icons/settingsgreen.png'
                      : 'assets/icons/settings.png'),
                ),
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFF00A153),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Custom font size for selected label
          unselectedLabelStyle: TextStyle(fontSize: 12), // Custom font size for unselected label
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({required this.name});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {
                // Add your logout logic here
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}



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

