import 'package:flutter/material.dart';
import 'ChangePinScreen.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';
import 'PersonalDetailsScreen.dart';

class SettingsScreen extends StatefulWidget {
  final String name;
  final String image;
  final PageController controller;

  SettingsScreen({required this.name, required this.image, required this.controller});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Declare controllers outside of the build method
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

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

  @override
  void dispose() {
    _cnicController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75), // Increase the height of the AppBar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow
          backgroundColor: Colors.white,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(widget.image), // Use AssetImage for local assets
                  onBackgroundImageError: (_, __) => const Icon(Icons.error), // Handle error
                ),
                SizedBox(width: 10), // Add some space between the picture and the name
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildSettingItem(
              icon: Icons.person,
              label: 'Personal Details',
              onTap: () {
                // Navigate to Personal Details screen
                Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalDetailsScreen()));
              },
            ),
            SizedBox(height: 12),
            _buildSettingItem(
              icon: Icons.logout_outlined,
              label: 'Logout',
              onTap: () {
                // Show logout dialog
                showDialog(
                  context: context,
                  builder: (_) => LogoutDialog(
                    onLogoutConfirmed: () {
                      // Handle logout logic here
                      _logout(context);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Security',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildSettingItem(
              icon: Icons.pin,
              label: 'Change PIN',
              onTap: () {
                // Navigate to Change PIN screen
                Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePinScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 30),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Color(0xFF00A154)), // Set the icon color to green
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // Decrease font size to 11
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
