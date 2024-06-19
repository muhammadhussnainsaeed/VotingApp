import 'package:flutter/material.dart';
import 'ChangePinScreen.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';
import 'PersonalDetailsScreen.dart';

class SettingsScreen extends StatefulWidget {
  final String name;
  final String image;
  final PageController controller;
  final String cnic;

  SettingsScreen({
    required this.name,
    required this.image,
    required this.controller,
    required this.cnic,
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
            _cnicController.clear();
            _pinController.clear();
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
                  backgroundImage: AssetImage(widget.image),
                  onBackgroundImageError: (_, __) => const Icon(Icons.error),
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalDetailsScreen(cnic: widget.cnic)));
                },
              ),
              SizedBox(height: 8),
              _buildSettingItem(
                icon: Icons.logout_outlined,
                label: 'Logout',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => LogoutDialog(
                      onLogoutConfirmed: () {
                        _logout(context);
                      },
                    ),
                  );
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
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePinScreen()));
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
