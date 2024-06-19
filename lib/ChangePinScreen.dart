import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Group3.dart'; // Ensure this is the correct import path for Group3
import 'ConfirmationDialog.dart'; // Import the ConfirmationDialog

class ChangePinScreen extends StatefulWidget {
  @override
  _ChangePinScreenState createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController _oldPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  bool _isValid() {
    String oldPin = _oldPinController.text;
    String newPin = _newPinController.text;
    String confirmPin = _confirmPinController.text;

    if (oldPin.length != 6 || newPin.length != 6 || confirmPin.length != 6) {
      return false;
    }

    if (newPin != confirmPin) {
      return false;
    }

    return true;
  }

  void _confirmChangePin() {
    if (_isValid()) {
      // Show confirmation dialog before changing PIN
      _showConfirmationDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid and matching PINs!')),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onConfirmationConfirmed: () {
            // Perform PIN change action here
            _performPinChange();
          },
        );
      },
    );
  }

  void _performPinChange() {
    // Perform PIN change operation here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PIN changed successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change your account PIN'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To change your PIN, please enter the following:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Your current PIN (Old PIN)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '2. Your new PIN (New PIN)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3. Confirm your new PIN (Confirm PIN)',
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 20),
            _buildPinTextField(_oldPinController, 'Old PIN'),
            SizedBox(height: 26),
            _buildPinTextField(_newPinController, 'New PIN'),
            SizedBox(height: 20),
            _buildPinTextField(_confirmPinController, 'Confirm PIN'),
            SizedBox(height: 30), // Increase space between text fields and button
            Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 50),
                child: Group3(onPressed: _confirmChangePin),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey[400]!, // Default border color
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Color(0xFF00A153), // Green border color when focused
            width: 2.0,
          ),
        ),
        counterText: "", // Hide the counter text
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(6), // Limit the length to 6 digits
        FilteringTextInputFormatter.digitsOnly, // Allow only numbers
      ],
      style: TextStyle(height: 1.5), // Reduce the height of the text box
    );
  }
}
