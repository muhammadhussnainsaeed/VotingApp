import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SixthPage.dart';

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
        _cnicErrorMessage =
        value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
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
        _pinErrorMessage =
        value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)
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
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildPinTextField(_cnicController, 'Enter your CNIC'),
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
                    _buildPinTextField(_pinController, 'Enter your PIN'),
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
                        backgroundColor: _isFormValid
                            ? Color(0xFF00A153)
                            : Color(0x7F8BEEB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        minimumSize: Size(298, 60),
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

  Widget _buildPinTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: label == 'Enter your CNIC' ? 13 : 6,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Color(0xFFD6D6D6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Color(0xFF00A153)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Colors.red),
        ),
        counterText: '',
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(label == 'Enter your CNIC' ? 13 : 6),
      ],
      style: TextStyle(height: 1.5),
      onChanged: (value) {
        if (label == 'Enter your CNIC') {
          _validateCnic(value);
        } else if (label == 'Enter your PIN') {
          _validatePin(value);
        }
      },
    );
  }
}