import 'dart:convert';
import 'package:flutter/material.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class HomeScreen extends StatefulWidget {
  final String name;
  final dynamic controller;

  HomeScreen({required this.name, this.controller});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool isNationalSelected = true;
  List<Map<String, dynamic>> candidates = [];

  @override
  void initState() {
    super.initState();
    fetchCandidates();
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(
          onLogoutConfirmed: () {
            _cnicController.clear();
            _pinController.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => FifthPage(controller: widget.controller)),
            );
          },
        );
      },
    );
  }

  Uint8List _decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String);
    } catch (e) {
      return Uint8List(0); // Return an empty Uint8List in case of an error
    }
  }

  Future<void> fetchCandidates() async {
    try {
      final response = await http.get(Uri.parse('https://localhost:7177/api/Candidates/${isNationalSelected ? "national" : "provincial"}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          candidates = data.map((candidate) {

            // Extract individual fields with null checks
            final name = candidate['name'] ?? 'No Name';
            final description = candidate['description'] ?? 'No description available';
            final image = candidate['candImage'];
            final party = candidate['party'] ?? 'No Party';
            final constituency = candidate['constituency'] ?? 'No Constituency';

            return {
              'name': name,
              'description': description,
              'image': image,
              'party': party,
              'constituency': constituency,
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _selectNational() {
    setState(() {
      isNationalSelected = true;
      fetchCandidates();
    });
  }

  void _selectProvincial() {
    setState(() {
      isNationalSelected = false;
      fetchCandidates();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi ${widget.name}',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.black),
                onPressed: () => _logout(context),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _buildSelectionToggle(screenWidth),
            SizedBox(height: 40),
            _buildCandidatesHeader(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return GestureDetector(
                    onTap: () {
                      showMoreDescription(context, candidate['name'] ?? 'Candidate', candidate['description'] ?? 'No description available');
                    },
                    child: _buildCandidateCard(candidate),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionToggle(double screenWidth) {
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[400],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _selectNational,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isNationalSelected ? Color(0xFF00A153) : Colors.grey[400],
                ),
                child: Center(
                  child: Text(
                    'National',
                    style: TextStyle(
                      color: isNationalSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _selectProvincial,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isNationalSelected ? Colors.grey[400] : Color(0xFF00A153),
                ),
                child: Center(
                  child: Text(
                    'Provincial',
                    style: TextStyle(
                      color: isNationalSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidatesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Candidates (${candidates.length})',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    Uint8List imageBytes = _decodeBase64Image(candidate['image']);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (candidate['image'] != null)
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: imageBytes.isNotEmpty ? MemoryImage(imageBytes) : null,
                    child: imageBytes.isEmpty ? const Icon(Icons.error) : null,
                  ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate['name'] ?? 'Candidate Name',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      candidate['party'] ?? 'Party',
                      style: TextStyle(fontSize: 14, color: Color(0xFF00A153)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              candidate['description'] ?? 'No description available',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  showMoreDescription(context, candidate['name'] ?? 'Candidate', candidate['description'] ?? 'No description available');
                },
                child: Text(
                  'See more',
                  style: TextStyle(color: Color(0xFF00A153)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMoreDescription(BuildContext context, String name, String description) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(description),
            ],
          ),
        );
      },
    );
  }
}
