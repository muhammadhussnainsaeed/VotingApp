import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ResultsScreen extends StatefulWidget {
  final String userDistrict;

  ResultsScreen({required this.userDistrict});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isNationalSelected = true;
  List<Map<String, dynamic>> candidates = [];
  Map<String, int> voteCounts = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final nationalCandidates = await fetchCandidates('Candidates/national', widget.userDistrict);
      final provincialCandidates = await fetchCandidates('Candidates/provincial', widget.userDistrict);
      final category = isNationalSelected ? 'national' : 'provincial';
      final votes = await fetchVotes(category);

      setState(() {
        candidates = isNationalSelected ? nationalCandidates : provincialCandidates;
        voteCounts = votes;
        candidates = updateCandidatesWithVotes(candidates, voteCounts);
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCandidates(String endpoint, String constituency) async {
    final response = await http.get(Uri.parse('https://localhost:7177/api/$endpoint/$constituency'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((candidate) {
        return {
          'name': candidate['name'] ?? 'No Name',
          'image': candidate['candImage'] ?? '',
          'party': candidate['party'] ?? 'No Party',
          'cnic': candidate['cnic'] ?? '',
        };
      }).toList();
    } else {
      throw Exception('Failed to load candidates');
    }
  }

  Future<Map<String, int>> fetchVotes(String category) async {
    final response = await http.get(Uri.parse('https://localhost:7177/api/votes/countVotes/$category'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final Map<String, int> voteCount = {};

      for (var vote in data) {
        final String candidateCnic = vote['candidateCNIC'] ?? '';
        final int count = vote['voteCount'] ?? 0;
        voteCount[candidateCnic] = count;
      }

      return voteCount;
    } else {
      throw Exception('Failed to load votes');
    }
  }

  List<Map<String, dynamic>> updateCandidatesWithVotes(List<Map<String, dynamic>> candidates, Map<String, int> voteCounts) {
    for (var candidate in candidates) {
      candidate['votes'] = voteCounts[candidate['cnic']] ?? 0;
    }
    candidates.sort((a, b) => b['votes'].compareTo(a['votes']));
    for (int i = 0; i < candidates.length; i++) {
      candidates[i]['position'] = i + 1;
    }
    return candidates;
  }

  void _selectNational() {
    setState(() {
      isNationalSelected = true;
      fetchData(); // Refetch data to update the UI
    });
  }

  void _selectProvincial() {
    setState(() {
      isNationalSelected = false;
      fetchData(); // Refetch data to update the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Results', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            _buildSelectionToggle(screenWidth),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  final candidate = candidates[index];
                  return _buildCandidateCard(candidate);
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

  Uint8List _decodeBase64Image(String? base64String) {
    try {
      if (base64String != null && base64String.isNotEmpty) {
        return base64Decode(base64String);
      } else {
        return Uint8List(0); // Return an empty Uint8List if base64String is null or empty
      }
    } catch (e) {
      print('Error decoding base64 image: $e');
      return Uint8List(0); // Return an empty Uint8List in case of an error
    }
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    Uint8List imageBytes = _decodeBase64Image(candidate['image']);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (candidate['image'] != null && candidate['image'].isNotEmpty)
              CircleAvatar(
                radius: 30,
                backgroundImage: MemoryImage(imageBytes),
              ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    candidate['name'] ?? 'Candidate Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Votes: ${candidate['votes']}',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            if (candidate['position'] != null)
              Text(
                '#${candidate['position']}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
