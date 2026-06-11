 import 'package:flutter/material.dart';
import 'question_screen.dart';
import 'premium_lock_screen.dart';

class TestSeriesScreen extends StatefulWidget {
  final String examType;
  final String subjectName;

  const TestSeriesScreen({
    Key? key,
    required this.examType,
    required this.subjectName,
  }) : super(key: key);

  @override
  State<TestSeriesScreen> createState() => _TestSeriesScreenState();
}

class _TestSeriesScreenState extends State<TestSeriesScreen> {
  // Mock test series data
  late List<Map<String, dynamic>> testSeries;

  @override
  void initState() {
    super.initState();
    loadMockTests();
  }

  void loadMockTests() {
    testSeries = [
      {
        'id': 1,
        'name': 'Mock Test 1: Basic Concepts',
        'description': 'Test your understanding of basic concepts',
        'totalQuestions': 50,
        'duration': 75, // minutes
        'difficulty': 'Easy',
        'isPremium': false,
        'attempts': 2,
        'bestScore': 42,
        'bestScorePercentage': 84,
        'lastAttempted': '2 days ago',
        'topics': 'Chapter 1-3',
      },
      {
        'id': 2,
        'name': 'Mock Test 2: Intermediate Level',
        'description': 'Test intermediate concepts and problem solving',
        'totalQuestions': 50,
        'duration': 75,
        'difficulty': 'Medium',
        'isPremium': false,
        'attempts': 1,
        'bestScore': 35,
        'bestScorePercentage': 70,
        'lastAttempted': '5 days ago',
        'topics': 'Chapter 4-6',
      },
      {
        'id': 3,
        'name': 'Mock Test 3: Advanced Concepts',
        'description': 'Test advanced topics and critical thinking',
        'totalQuestions': 50,
        'duration': 75,
        'difficulty': 'Hard',
        'isPremium': true,
        'attempts': 0,
        'bestScore': 0,
        'bestScorePercentage': 0,
        'lastAttempted': 'Never',
        'topics': 'Chapter 7-9',
      },
      {
        'id': 4,
        'name': 'Mock Test 4: Full Syllabus',
        'description': 'Complete test covering entire syllabus',
        'totalQuestions': 100,
        'duration': 120,
        'difficulty': 'Hard',
        'isPremium': true,
        'attempts': 0,
        'bestScore': 0,
        'bestScorePercentage': 0,
        'lastAttempted': 'Never',
        'topics': 'All Chapters',
      },
      {
        'id': 5,
        'name': 'Previous Year Question 2023',
        'description': 'Actual exam questions from 2023',
        'totalQuestions': 50,
        'duration': 75,
        'difficulty': 'Hard',
        'isPremium': false,
        'attempts': 3,
        'bestScore': 38,
        'bestScorePercentage': 76,
        'lastAttempted': '1 week ago',
        'topics': 'All topics',
      },
    ];
  }

  void startTest(Map<String, dynamic> test) {
  // Check if premium test and user is not premium
  bool userIsPremium = false; // Change to true if user has premium
  
  if (test['isPremium'] && !userIsPremium) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PremiumLockScreen(
          lockReason: 'test_series',
          examType: widget.examType,
        ),
      ),
    );
    return;
  }

  // Start the test
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => QuestionScreen(
        examType: widget.examType,
        isTestSeries: true,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subjectName} - Test Series'),
        backgroundColor: const Color(0xFF5B4EE8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header section
            Container(
              color: const Color(0xFF5B4EE8),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.examType,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${testSeries.length} Tests Available',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Test list
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: List.generate(
                  testSeries.length,
                  (index) {
                    final test = testSeries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TestCard(
                        test: test,
                        onStartTest: () => startTest(test),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final Map<String, dynamic> test;
  final VoidCallback onStartTest;

  const TestCard({
    Key? key,
    required this.test,
    required this.onStartTest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Test header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: test['isPremium']
                  ? Colors.amber[50]
                  : Colors.blue[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with premium badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        test['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (test['isPremium'])
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          '👑 Premium',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  test['description'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

          // Test details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Key stats in grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TestStatItem(
                      icon: '❓',
                      label: 'Questions',
                      value: test['totalQuestions'].toString(),
                    ),
                    TestStatItem(
                      icon: '⏱️',
                      label: 'Duration',
                      value: '${test['duration']} min',
                    ),
                    TestStatItem(
                      icon: '📊',
                      label: 'Difficulty',
                      value: test['difficulty'],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Topics covered
                Row(
                  children: [
                    Text(
                      'Topics: ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        test['topics'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Performance if attempted
                if (test['attempts'] > 0)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Best Score',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              '${test['bestScore']}/${test['totalQuestions']} (${test['bestScorePercentage']}%)',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Progress bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: test['bestScorePercentage'] / 100,
                            backgroundColor: Colors.green[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green[600],
                            ),
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Attempts: ${test['attempts']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              'Last: ${test['lastAttempted']}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Not attempted yet',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Start button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // If already attempted, show "Retake Test" dialog
                  if (test['attempts'] > 0) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Retake Test?'),
                        content: Text(
                          'You have already attempted this test.\n\nYour best score: ${test['bestScore']}/${test['totalQuestions']}\n\nDo you want to retake it?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onStartTest();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF5B4EE8),
                            ),
                            child: const Text('Retake'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    onStartTest();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: test['isPremium'] = true
                      ? Colors.amber
                      : const Color(0xFF5B4EE8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  test['attempts'] > 0 ? 'Retake Test' : 'Start Test',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestStatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const TestStatItem({
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
