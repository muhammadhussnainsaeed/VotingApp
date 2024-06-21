import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SettingsScreen.dart';
import 'VoteScreen.dart';
import 'FifthPage.dart'; // Import your LoginScreen

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(isLoggedIn: true), // Set MainPage as the home widget
    );
  }
}

class MainPage extends StatefulWidget {
  final bool isLoggedIn;

  MainPage({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _controller = PageController();
  int _selectedIndex = 0;
  DateTime? _lastPressedAt; // Track the last time the back button was pressed

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(name: 'John Doe', controller: _controller,),
      VoteScreen(),
      SettingsScreen(name: 'John Doe', image: 'assets/images/panda.jpg', cnic: '1231231232131', controller: _controller,),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0; // Navigate to the home screen on back press if not already on home screen
          });
          return false;
        } else {
          // Handle double tap to exit app
          DateTime now = DateTime.now();
          if (_lastPressedAt == null || now.difference(_lastPressedAt!) > Duration(seconds: 1)) {
            _lastPressedAt = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to Logout'),
                duration: Duration(seconds: 1),
              ),
            );
            return false;
          }
          return true;
        }
      },
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          width: 390,
          height: 95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 30,
                  height: 30,
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
                  width: 30,
                  height: 30,
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
                  width: 30,
                  height: 30,
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
            selectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontSize: 12),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
