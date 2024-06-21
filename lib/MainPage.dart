import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'SettingsScreen.dart';
import 'VoteScreen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _controller = PageController();
  int _selectedIndex = 0;


  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomeScreen(name: 'John Doe',controller: _controller,),
      VoteScreen(),
      SettingsScreen(name: 'John Doe',image: 'assets/images/panda.jpg',cnic: '1231231232131',controller: _controller,),
    ];
  }

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
