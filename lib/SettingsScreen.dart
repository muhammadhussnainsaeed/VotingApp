import 'package:flutter/material.dart';
import 'ChangePinScreen.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';
import 'PersonalDetailsScreen.dart';
import 'dart:convert';
import 'dart:typed_data';

class SettingsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String cnic;
  final String district;
  final String dob;
  final PageController controller;

  SettingsScreen({
    required this.name,
    required this.image,
    required this.cnic,
    required this.district,
    required this.dob,
    required this.controller,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
            Navigator.pushReplacement(
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

  Uint8List _decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return Uint8List(0); // Return an empty Uint8List in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = _decodeBase64Image(widget.image);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 19.0),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: imageBytes.isNotEmpty ? MemoryImage(imageBytes) : null,
                  child: imageBytes.isEmpty ? const Icon(Icons.error) : null,
                ),
                SizedBox(width: 10),
                Text(
                  widget.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              _buildSettingItem(
                icon: Icons.person,
                label: 'Personal Details',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalDetailsScreen(image: widget.image,cnic: widget.cnic,name: widget.name,district: widget.district,dob: widget.dob)));
                },
              ),
              SizedBox(height: 8),
              _buildSettingItem(
                icon: Icons.logout_outlined,
                label: 'Logout',
                onTap: () {
                  _logout(context);
                },
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Security',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              _buildSettingItem(
                icon: Icons.pin,
                label: 'Change PIN',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePinScreen(cnic: widget.cnic)));
                },
              ),
            ],
          ),
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
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 35),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Color(0xFF00A154)),
            SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
