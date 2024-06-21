import 'package:flutter/material.dart';
import 'FifthPage.dart';
import 'LogoutDialog.dart';

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

  List<Map<String, String>> national = [
    {
      'name': 'Candidate1',
      'description':
      'It is indeed possible to increase minSdkVersion, '
          'but it took me way too much time to find it out because google searches '
          'mostly yields as result discussions about the absolute minimum Sdk version flutter '
          'should be able to support, not how to increase it in your own project.',
      'image': 'assets/images/cand.jpg',
      'party': 'PMLN',
      'flag': 'assets/images/ali.jpg',
    },
    {
      'name': 'Tiger A.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/uba.jpeg',
    },
  ];

  List<Map<String, String>> provincial = [
    {
      'name': 'Tiger J.',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/ali.jpg',
    },
    {
      'name': 'Tiger K',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/tiger.jpg',
    },
    {
      'name': 'Tiger C',
      'description': 'The tiger is known for its majestic appearance and strength...',
      'image': 'assets/images/panda.jpg',
    },
  ];

  List<Map<String, String>> candidates = [];

   //candidates = national;
  @override
  void initState()
  {
    super.initState();
    candidates= national;
  }


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
                onPressed: () => _logout(context), // Corrected onPressed
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
                  borderRadius: BorderRadius.circular(20),
                  color: isNationalSelected ? Color(0xFF00A153) : Colors.grey[400],
                ),
                child: Center(
                  child: Text(
                    'National',
                    style: TextStyle(
                      color: isNationalSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                  borderRadius: BorderRadius.circular(20),
                  color: isNationalSelected ? Colors.grey[400] : Color(0xFF00A153),
                ),
                child: Center(
                  child: Text(
                    'Provincial',
                    style: TextStyle(
                      color: isNationalSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCandidateCard(Map<String, String> candidate) {
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
                    backgroundImage: AssetImage(candidate['image']!),
                  ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate['name'] ?? 'Candidate Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      candidate['party'] ?? 'Party',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              candidate['description'] ?? 'No description available',
              maxLines: 3,
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
                  style: TextStyle(color: Colors.blue),
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
