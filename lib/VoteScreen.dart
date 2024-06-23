import 'package:flutter/material.dart';
import 'ResultScreen.dart';
import 'VoteConfirmationDialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class VoteScreen extends StatefulWidget {
  final String userDistrict; // User's district/constituency
  final String userCNIC;

  VoteScreen({required this.userCNIC, required this.userDistrict});

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  bool isNationalSelected = true;
  String? votedNationalCandidateCNIC;
  String? votedProvincialCandidateCNIC;
  List<Map<String, dynamic>> candidates = [];

  @override
  void initState() {
    super.initState();
    _fetchCandidatesAndCheckVotes();
  }

  Future<void> _fetchCandidatesAndCheckVotes() async {
    await _fetchCandidates();
    await _checkVotes();
  }

  Future<void> _fetchCandidates() async {
    try {
      final response = await http.get(Uri.parse('https://localhost:7177/api/Candidates/${isNationalSelected ? "national" : "provincial"}/${widget.userDistrict}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          candidates = data.map((candidate) {
            final name = candidate['name'] ?? 'No Name';
            final image = candidate['candImage'];
            final party = candidate['party'] ?? 'No Party';
            final cnic = candidate['cnic'] ?? ''; // Handle null case for 'cnic'

            return {
              'name': name,
              'image': image,
              'party': party,
              'cnic': cnic,
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      print('Error fetching candidates: $e');
    }
  }

  Future<void> _checkVotes() async {
    try {
      final response = await http.get(Uri.parse('https://localhost:7177/api/Votes/checkVotes/${widget.userCNIC}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> voteStatus = jsonDecode(response.body);

        setState(() {
          votedNationalCandidateCNIC = voteStatus['votedNationalCandidate'];
          votedProvincialCandidateCNIC = voteStatus['votedProvincialCandidate'];
        });

      } else {
        throw Exception('Failed to check vote status');
      }
    } catch (e) {
      print('Error checking votes: $e');
    }
  }

  void _showVoteConfirmationDialog(BuildContext context, Map<String, dynamic> candidate) {
    if (isNationalSelected) {
      if (votedNationalCandidateCNIC == null) {
        VoteConfirmationHelper.showNationalConfirmationDialog(context, candidate, _onVoteConfirmation);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have already voted in the National category.'),
          ),
        );
      }
    } else {
      if (votedProvincialCandidateCNIC == null) {
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

  void _onVoteConfirmation(String candidateCNIC) async {
    setState(() {
      if (isNationalSelected) {
        votedNationalCandidateCNIC = candidateCNIC;
      } else {
        votedProvincialCandidateCNIC = candidateCNIC;
      }
    });

    final vote = {
      'CNIC': widget.userCNIC,
      'CandidateCNIC': candidateCNIC,
      'Constituency': widget.userDistrict,
      'NationalAssembly': isNationalSelected,
      'ProvincialAssembly': !isNationalSelected,
    };

    try {
      final response = await http.post(
        Uri.parse('https://localhost:7177/api/Votes'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(vote),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vote submitted successfully.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit vote.'),
          ),
        );
      }
    } catch (e) {
      print('Error submitting vote: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting vote.'),
        ),
      );
    }
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
                  String candidateCNIC = candidate['cnic'] ?? ''; // Handle null case for 'cnic'
                  bool isAlreadyVoted = (isNationalSelected && votedNationalCandidateCNIC == candidateCNIC) ||
                      (!isNationalSelected && votedProvincialCandidateCNIC == candidateCNIC);

                  return _buildCandidateCard(candidate, isAlreadyVoted);
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
              onTap: () {
                setState(() {
                  isNationalSelected = true;
                  _fetchCandidatesAndCheckVotes(); // Fetch new candidates and check votes when category changes
                });
              },
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
              onTap: () {
                setState(() {
                  isNationalSelected = false;
                  _fetchCandidatesAndCheckVotes(); // Fetch new candidates and check votes when category changes
                });
              },
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Candidates (${candidates.length})',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Uint8List _decodeBase64Image(String? base64String) {
    try {
      if (base64String != null) {
        return base64Decode(base64String);
      } else {
        return Uint8List(0); // Return an empty Uint8List if base64String is null
      }
    } catch (e) {
      return Uint8List(0); // Return an empty Uint8List in case of an error
    }
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate, bool isAlreadyVoted) {
    Uint8List imageBytes = _decodeBase64Image(candidate['image']);

    return GestureDetector(
      onTap: isAlreadyVoted
          ? null
          : () {
        _showVoteConfirmationDialog(context, candidate);
      },
      child: Card(
        color: isAlreadyVoted ? Colors.grey[400] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: imageBytes.isNotEmpty ? MemoryImage(imageBytes) : null,
              child: imageBytes.isEmpty ? const Icon(Icons.error) : null,
            ),
            title: Text(
              candidate['name'],
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(candidate['party']),
          ),
        ),
      ),
    );
  }
}
