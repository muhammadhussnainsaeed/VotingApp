import 'package:flutter/material.dart';
import 'ResultScreen.dart';
import 'VoteConfirmationDialog.dart'; // Import your helper class here

class VoteScreen extends StatefulWidget {
  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  bool isNationalSelected = true;
  String? votedNationalCandidate;
  String? votedProvincialCandidate;

  List<Map<String, String>> national = [
    {
      'name': 'Candidate1',
      'image': 'assets/images/cand.jpg',
      'party': 'PMLN',
    },
    {
      'name': 'Tiger A.',
      'image': 'assets/images/uba.jpeg',
      'party': 'PMLN',
    },
  ];

  List<Map<String, String>> provincial = [
    {
      'name': 'Tiger J.',
      'image': 'assets/images/ali.jpg',
      'party': 'Party A',
    },
    {
      'name': 'Tiger K',
      'party': 'abc',
      'image': 'assets/images/tiger.jpg',
    },
    {
      'name': 'Tiger C',
      'image': 'assets/images/panda.jpg',
      'party': 'Party B',
    },
  ];

  List<Map<String, String>> candidates = [];

  @override
  void initState() {
    super.initState();
    candidates = national;
  }

  void _selectNational() {
    setState(() {
      isNationalSelected = true;
      candidates = national;
    });
  }

  void _selectProvincial() {
    setState(() {
      isNationalSelected = false;
      candidates = provincial;
    });
  }

  void _showVoteConfirmationDialog(BuildContext context, Map<String, String> candidate) {
    if (isNationalSelected) {
      if (votedNationalCandidate == null) {
        VoteConfirmationHelper.showNationalConfirmationDialog(context, candidate, _onVoteConfirmation);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have already voted in the National category.'),
          ),
        );
      }
    } else {
      if (votedProvincialCandidate == null) {
        VoteConfirmationHelper.showProvincialConfirmationDialog(context, candidate, _onVoteConfirmation);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have already voted in the Provincial category.'),
          ),
        );
      }
    }
  }

  void _onVoteConfirmation(String candidateName) {
    setState(() {
      if (isNationalSelected) {
        votedNationalCandidate = candidateName;
      } else {
        votedProvincialCandidate = candidateName;
      }
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
          title: Text(
            'Elections',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A153),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Results',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
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
                      if ((isNationalSelected && votedNationalCandidate == null) ||
                          (!isNationalSelected && votedProvincialCandidate == null)) {
                        _showVoteConfirmationDialog(context, candidate);
                      }
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

  Widget _buildCandidateCard(Map<String, String> candidate) {
    bool isVotedCandidate = (isNationalSelected && candidate['name'] == votedNationalCandidate) ||
        (!isNationalSelected && candidate['name'] == votedProvincialCandidate);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: isVotedCandidate ? Colors.grey : Colors.white,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  candidate['name'] ?? 'Candidate Name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isVotedCandidate ? Colors.grey[600] : Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  candidate['party'] ?? 'Party',
                  style: TextStyle(
                    fontSize: 14,
                    color: isVotedCandidate ? Colors.grey[600] : Color(0xFF00A153),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
