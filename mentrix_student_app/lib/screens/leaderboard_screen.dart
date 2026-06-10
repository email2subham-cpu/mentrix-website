import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  final String examType;
  final String subjectName;

  const LeaderboardScreen({
    Key? key,
    required this.examType,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedFilter = 'overall'; // 'overall', 'monthly', 'weekly'
  late List<Map<String, dynamic>> leaderboardData;
  late int userRank;
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    loadLeaderboardData();
  }

  void loadLeaderboardData() {
    // Mock leaderboard data
    leaderboardData = [
      {
        'rank': 1,
        'name': 'Raj Kumar',
        'score': 950,
        'attempts': 25,
        'accuracy': 95.0,
        'avatar': '👨‍🎓',
      },
      {
        'rank': 2,
        'name': 'Priya Singh',
        'score': 920,
        'attempts': 22,
        'accuracy': 92.0,
        'avatar': '👩‍🎓',
      },
      {
        'rank': 3,
        'name': 'Arjun Patel',
        'score': 890,
        'attempts': 20,
        'accuracy': 89.0,
        'avatar': '👨‍🎓',
      },
      {
        'rank': 4,
        'name': 'Neha Sharma',
        'score': 850,
        'attempts': 19,
        'accuracy': 85.0,
        'avatar': '👩‍🎓',
      },
      {
        'rank': 5,
        'name': 'Vikram Gupta',
        'score': 820,
        'attempts': 18,
        'accuracy': 82.0,
        'avatar': '👨‍🎓',
      },
      {
        'rank': 6,
        'name': 'Ananya Desai',
        'score': 800,
        'attempts': 17,
        'accuracy': 80.0,
        'avatar': '👩‍🎓',
      },
      {
        'rank': 7,
        'name': 'Rohan Verma',
        'score': 780,
        'attempts': 16,
        'accuracy': 78.0,
        'avatar': '👨‍🎓',
      },
      {
        'rank': 8,
        'name': 'Divya Nair',
        'score': 750,
        'attempts': 15,
        'accuracy': 75.0,
        'avatar': '👩‍🎓',
      },
      {
        'rank': 9,
        'name': 'Aditya Kumar',
        'score': 720,
        'attempts': 14,
        'accuracy': 72.0,
        'avatar': '👨‍🎓',
      },
      {
        'rank': 10,
        'name': 'Shreya Iyer',
        'score': 690,
        'attempts': 13,
        'accuracy': 69.0,
        'avatar': '👩‍🎓',
      },
    ];

    // Mock current user data
    userData = {
      'rank': 47,
      'name': 'You (Subham)',
      'score': 520,
      'attempts': 12,
      'accuracy': 65.0,
      'avatar': '🎯',
      'isUser': true,
    };

    userRank = userData['rank'];
  }

  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  Color getRankColor(int rank) {
    if (rank == 1) return Colors.amber;
    if (rank == 2) return Colors.grey;
    if (rank == 3) return const Color(0xFFCD7F32);
    return const Color(0xFF5B4EE8);
  }

  String getRankMedal(int rank) {
    if (rank == 1) return '🥇';
    if (rank == 2) return '🥈';
    if (rank == 3) return '🥉';
    return '#$rank';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: const Color(0xFF5B4EE8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with exam info
            Container(
              color: const Color(0xFF5B4EE8),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.examType,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Top performers across all students',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Last updated: Today at 3:45 PM',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white60,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Filter tabs
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Overall', 'overall'),
                  _buildFilterButton('Monthly', 'monthly'),
                  _buildFilterButton('Weekly', 'weekly'),
                ],
              ),
            ),

            // Your rank card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Rank',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '#$userRank',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5B4EE8),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        '🎯',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Score',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${userData['score']}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Top 10 leaderboard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              'Rank',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Student',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              'Score',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Text(
                              'Accuracy',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Leaderboard rows
                    ...List.generate(
                      leaderboardData.length,
                      (index) {
                        final student = leaderboardData[index];
                        final isTopThree = student['rank'] <= 3;

                        return Column(
                          children: [
                            Divider(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 14,
                              ),
                              color: isTopThree
                                  ? getRankColor(student['rank'])
                                      .withOpacity(0.1)
                                  : Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Center(
                                      child: isTopThree
                                          ? Text(
                                              getRankMedal(student['rank']),
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            )
                                          : Text(
                                              '#${student['rank']}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          student['avatar'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            student['name'],
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: isTopThree
                                                  ? FontWeight.bold
                                                  : FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${student['score']}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isTopThree
                                            ? getRankColor(student['rank'])
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${student['accuracy'].toStringAsFixed(0)}%',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Your position (if not in top 10)
            if (userRank > 10)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange[300]!),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Center(
                          child: Text(
                            '#${userData['rank']}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              userData['avatar'],
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['name'],
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'That\'s you!',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.orange[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${userData['score']}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            '${userData['accuracy'].toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Stats section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Statistics',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StatItem(
                          icon: '📝',
                          label: 'Attempts',
                          value: '${userData['attempts']}',
                        ),
                        StatItem(
                          icon: '🎯',
                          label: 'Accuracy',
                          value: '${userData['accuracy'].toStringAsFixed(0)}%',
                        ),
                        StatItem(
                          icon: '⭐',
                          label: 'Best Score',
                          value: '${userData['score']}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Motivation message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      '💪 Keep Practicing!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You are ${leaderboardData[0]['score'] - userData['score']} points away from the top position. Keep solving questions to climb up!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, String value) {
    final isSelected = selectedFilter == value;

    return GestureDetector(
      onTap: () => updateFilter(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5B4EE8) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const StatItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
