import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool isNationalSelected = true;

  List<Map<String, dynamic>> nationalCandidates = [
    {
      'name': 'Candidate1',
      'image': 'assets/images/cand.jpg',
      'votes': 1234,
      'position': 1,
    },
    {
      'name': 'Tiger A.',
      'image': 'assets/images/uba.jpeg',
      'votes': 5678,
      'position': 2,
    },
  ];

  List<Map<String, dynamic>> provincialCandidates = [
    {
      'name': 'Tiger J.',
      'image': 'assets/images/ali.jpg',
      'votes': 2345,
      'position': 1,
    },
    {
      'name': 'Tiger K',
      'votes': 6789,
      'position': 2,
      'image': 'assets/images/tiger.jpg',
    },
    {
      'name': 'Tiger C',
      'image': 'assets/images/panda.jpg',
      'votes': 3456,
      'position': 3,
    },
  ];

  void _selectNational() {
    setState(() {
      isNationalSelected = true;
    });
  }

  void _selectProvincial() {
    setState(() {
      isNationalSelected = false;
    });
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

  List<Map<String, dynamic>> get candidates {
    List<Map<String, dynamic>> sortedCandidates = List.from(isNationalSelected ? nationalCandidates : provincialCandidates);

    // Sort candidates by votes in descending order
    sortedCandidates.sort((a, b) => b['votes'].compareTo(a['votes']));

    // Update positions based on sorted order
    for (int i = 0; i < sortedCandidates.length; i++) {
      sortedCandidates[i]['position'] = i + 1;
    }

    return sortedCandidates;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the default back button
        title: Text('Results', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back when close icon is pressed
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

  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (candidate['image'] != null)
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(candidate['image']!),
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
                    'Votes: ${candidate['votes'] ?? 0}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '#${candidate['position'] ?? 0}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A153),
              ),
            ),
          ],
        ),
      ),
    );
  }
}