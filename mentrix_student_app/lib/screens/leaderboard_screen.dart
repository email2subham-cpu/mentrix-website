import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  final String examType;
  final String subjectName;

  const LeaderboardScreen({
    super.key,
    required this.examType,
    required this.subjectName,
  });

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String selectedFilter = 'All Time'; // All Time, This Week, Today
  String selectedSubject = 'All Subjects';

  // Mock leaderboard data - will be replaced with Supabase data in Phase 2
  List<Map<String, dynamic>> getLeaderboardData() {
    return [
      {
        'rank': 1,
        'name': 'Rahul Kumar',
        'score': 950,
        'accuracy': 95.0,
        'tests': 45,
        'avatar': '👨‍💻',
        'isCurrentUser': false,
        'badge': '🥇',
      },
      {
        'rank': 2,
        'name': 'Priya Singh',
        'score': 920,
        'accuracy': 92.0,
        'tests': 40,
        'avatar': '👩‍🎓',
        'isCurrentUser': false,
        'badge': '🥈',
      },
      {
        'rank': 3,
        'name': 'Arjun Patel',
        'score': 890,
        'accuracy': 89.0,
        'tests': 38,
        'avatar': '👨‍🎓',
        'isCurrentUser': false,
        'badge': '🥉',
      },
      {
        'rank': 4,
        'name': 'Subham Kumar',
        'score': 850,
        'accuracy': 85.0,
        'tests': 35,
        'avatar': '😊',
        'isCurrentUser': true,
        'badge': null,
      },
      {
        'rank': 5,
        'name': 'Neha Sharma',
        'score': 820,
        'accuracy': 82.0,
        'tests': 32,
        'avatar': '👩‍💻',
        'isCurrentUser': false,
        'badge': null,
      },
      {
        'rank': 6,
        'name': 'Amit Roy',
        'score': 800,
        'accuracy': 80.0,
        'tests': 30,
        'avatar': '👨‍🔬',
        'isCurrentUser': false,
        'badge': null,
      },
      {
        'rank': 7,
        'name': 'Sneha Das',
        'score': 780,
        'accuracy': 78.0,
        'tests': 28,
        'avatar': '👩‍🔬',
        'isCurrentUser': false,
        'badge': null,
      },
      {
        'rank': 8,
        'name': 'Rohan Ghosh',
        'score': 760,
        'accuracy': 76.0,
        'tests': 25,
        'avatar': '🧑‍💻',
        'isCurrentUser': false,
        'badge': null,
      },
      {
        'rank': 9,
        'name': 'Anjali Bose',
        'score': 740,
        'accuracy': 74.0,
        'tests': 22,
        'avatar': '👩‍🏫',
        'isCurrentUser': false,
        'badge': null,
      },
      {
        'rank': 10,
        'name': 'Vikram Sen',
        'score': 720,
        'accuracy': 72.0,
        'tests': 20,
        'avatar': '👨‍🏫',
        'isCurrentUser': false,
        'badge': null,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final leaderboard = getLeaderboardData();
    final top3 = leaderboard.take(3).toList();
    final rest = leaderboard.skip(3).toList();
    final currentUser = leaderboard.firstWhere(
      (e) => e['isCurrentUser'] == true,
      orElse: () => {},
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1A1A2E), const Color(0xFF0D0D1F)]
                      : [const Color(0xFF5B4EE8).withOpacity(0.1), const Color(0xFF00D9FF).withOpacity(0.1)],
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '🏆 ${widget.examType} Leaderboard',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Top performers this month',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Filter Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['Today', 'This Week', 'All Time'].map((filter) {
                      final isSelected = selectedFilter == filter;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF5B4EE8)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF5B4EE8)
                                    : Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : null,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Your Rank Card
            if (currentUser.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF5B4EE8), Color(0xFF7C6EFF)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            currentUser['avatar'],
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Your Ranking',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              currentUser['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '#${currentUser['rank']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            '${currentUser['score']} pts',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Podium (Top 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      '🏆 Top Performers',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // 2nd Place
                        _buildPodiumItem(
                          context,
                          top3[1],
                          height: 80,
                          color: Colors.grey[400]!,
                        ),
                        // 1st Place
                        _buildPodiumItem(
                          context,
                          top3[0],
                          height: 110,
                          color: Colors.amber,
                        ),
                        // 3rd Place
                        _buildPodiumItem(
                          context,
                          top3[2],
                          height: 60,
                          color: Colors.brown[300]!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Rankings List (4th onwards)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rankings',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...rest.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildRankCard(context, entry, isDark),
                    );
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumItem(
    BuildContext context,
    Map<String, dynamic> entry, {
    required double height,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          entry['badge'] ?? '',
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 4),
        Text(
          entry['avatar'],
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 4),
        Text(
          entry['name'].split(' ')[0],
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '${entry['score']} pts',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: Border.all(
              color: color.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              '#${entry['rank']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankCard(
    BuildContext context,
    Map<String, dynamic> entry,
    bool isDark,
  ) {
    final isCurrentUser = entry['isCurrentUser'] as bool;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? const Color(0xFF5B4EE8).withOpacity(0.1)
            : isDark
                ? const Color(0xFF1A1A2E)
                : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser
              ? const Color(0xFF5B4EE8).withOpacity(0.5)
              : Colors.grey.withOpacity(0.2),
          width: isCurrentUser ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCurrentUser
                  ? const Color(0xFF5B4EE8)
                  : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#${entry['rank']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: isCurrentUser ? Colors.white : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          Text(
            entry['avatar'],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(width: 12),

          // Name & Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      entry['name'],
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5B4EE8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'You',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${entry['tests']} tests',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${entry['accuracy']}% accuracy',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Score
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry['score']}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5B4EE8),
                ),
              ),
              Text(
                'points',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
