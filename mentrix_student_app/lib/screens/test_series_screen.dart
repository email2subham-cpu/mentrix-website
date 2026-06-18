 import 'package:flutter/material.dart';
import '../providers/exam_constants.dart';
import 'question_screen.dart';
import 'premium_lock_screen.dart';
import 'results_screen.dart';

class TestSeriesScreen extends StatefulWidget {
  final String examType;
  final String subjectName;

  const TestSeriesScreen({
    super.key,
    required this.examType,
    required this.subjectName,
  });

  @override
  State<TestSeriesScreen> createState() => _TestSeriesScreenState();
}

class _TestSeriesScreenState extends State<TestSeriesScreen> {
  bool userIsPremium = false;

  List<Map<String, dynamic>> getTestSeries() {
    switch (widget.examType) {
      case 'JEE Mains':
        return [
          {
            'id': 1,
            'subject': 'Physics',
            'name': 'JEE Physics Full Test',
            'questions': ExamConstants.getQuestionCount('JEE Mains', 'Physics'),
            'duration': ExamConstants.getExamDuration('JEE Mains'),
            'isPremium': false,
            'bestScore': 18,
            'attempts': 2,
            'icon': '⚡',
            'color': Colors.blue,
          },
          {
            'id': 2,
            'subject': 'Chemistry',
            'name': 'JEE Chemistry Full Test',
            'questions': ExamConstants.getQuestionCount('JEE Mains', 'Chemistry'),
            'duration': ExamConstants.getExamDuration('JEE Mains'),
            'isPremium': false,
            'bestScore': 20,
            'attempts': 1,
            'icon': '⚗️',
            'color': Colors.green,
          },
          {
            'id': 3,
            'subject': 'Mathematics',
            'name': 'JEE Mathematics Full Test',
            'questions': ExamConstants.getQuestionCount('JEE Mains', 'Mathematics'),
            'duration': ExamConstants.getExamDuration('JEE Mains'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🔢',
            'color': Colors.orange,
          },
        ];
      case 'NEET':
        return [
          {
            'id': 1,
            'subject': 'Physics',
            'name': 'NEET Physics Full Test',
            'questions': ExamConstants.getQuestionCount('NEET', 'Physics'),
            'duration': ExamConstants.getExamDuration('NEET'),
            'isPremium': false,
            'bestScore': 35,
            'attempts': 3,
            'icon': '⚡',
            'color': Colors.blue,
          },
          {
            'id': 2,
            'subject': 'Chemistry',
            'name': 'NEET Chemistry Full Test',
            'questions': ExamConstants.getQuestionCount('NEET', 'Chemistry'),
            'duration': ExamConstants.getExamDuration('NEET'),
            'isPremium': false,
            'bestScore': 40,
            'attempts': 2,
            'icon': '⚗️',
            'color': Colors.green,
          },
          {
            'id': 3,
            'subject': 'Biology',
            'name': 'NEET Biology Full Test',
            'questions': ExamConstants.getQuestionCount('NEET', 'Biology'),
            'duration': ExamConstants.getExamDuration('NEET'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🌿',
            'color': Colors.teal,
          },
        ];
      case 'WBJEE':
        return [
          {
            'id': 1,
            'subject': 'Physics',
            'name': 'WBJEE Physics Full Test',
            'questions': ExamConstants.getQuestionCount('WBJEE', 'Physics'),
            'duration': ExamConstants.getExamDuration('WBJEE'),
            'isPremium': false,
            'bestScore': 30,
            'attempts': 2,
            'icon': '⚡',
            'color': Colors.blue,
          },
          {
            'id': 2,
            'subject': 'Chemistry',
            'name': 'WBJEE Chemistry Full Test',
            'questions': ExamConstants.getQuestionCount('WBJEE', 'Chemistry'),
            'duration': ExamConstants.getExamDuration('WBJEE'),
            'isPremium': false,
            'bestScore': 25,
            'attempts': 1,
            'icon': '⚗️',
            'color': Colors.green,
          },
          {
            'id': 3,
            'subject': 'Mathematics',
            'name': 'WBJEE Mathematics Full Test',
            'questions': ExamConstants.getQuestionCount('WBJEE', 'Mathematics'),
            'duration': ExamConstants.getExamDuration('WBJEE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🔢',
            'color': Colors.orange,
          },
        ];
      case 'WBCHSE':
      default:
        return [
          {
            'id': 1,
            'subject': 'Physics',
            'name': 'WBCHSE Physics Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Physics'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': false,
            'bestScore': 28,
            'attempts': 2,
            'icon': '⚡',
            'color': Colors.blue,
          },
          {
            'id': 2,
            'subject': 'Chemistry',
            'name': 'WBCHSE Chemistry Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Chemistry'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': false,
            'bestScore': 30,
            'attempts': 1,
            'icon': '⚗️',
            'color': Colors.green,
          },
          {
            'id': 3,
            'subject': 'Biology',
            'name': 'WBCHSE Biology Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Biology'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': false,
            'bestScore': 25,
            'attempts': 1,
            'icon': '🌿',
            'color': Colors.teal,
          },
          {
            'id': 4,
            'subject': 'Mathematics',
            'name': 'WBCHSE Mathematics Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Mathematics'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🔢',
            'color': Colors.orange,
          },
          {
            'id': 5,
            'subject': 'History',
            'name': 'WBCHSE History Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'History'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '📜',
            'color': Colors.brown,
          },
          {
            'id': 6,
            'subject': 'Geography',
            'name': 'WBCHSE Geography Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Geography'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🌍',
            'color': Colors.indigo,
          },
          {
            'id': 7,
            'subject': 'Bengali',
            'name': 'WBCHSE Bengali Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'Bengali'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '📖',
            'color': Colors.purple,
          },
          {
            'id': 8,
            'subject': 'English',
            'name': 'WBCHSE English Full Test',
            'questions': ExamConstants.getQuestionCount('WBCHSE', 'English'),
            'duration': ExamConstants.getExamDuration('WBCHSE'),
            'isPremium': true,
            'bestScore': 0,
            'attempts': 0,
            'icon': '🔤',
            'color': Colors.red,
          },
        ];
    }
  }

  void startTest(Map<String, dynamic> test) {
    final isPremium = test['isPremium'] as bool;
    final isLocked = isPremium && !userIsPremium;

    if (isLocked) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PremiumLockScreen(
            lockReason: 'test_limit',
            examType: widget.examType,
          ),
        ),
      );
    } else {
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
  }

  void retakeTest(Map<String, dynamic> test) {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tests = getTestSeries();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.examType} Test Series',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Subject-wise full mock tests',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatChip(context, '${tests.length}', 'Tests'),
                      const SizedBox(width: 12),
                      _buildStatChip(
                        context,
                        '${tests.where((t) => t['attempts'] > 0).length}',
                        'Attempted',
                      ),
                      const SizedBox(width: 12),
                      _buildStatChip(
                        context,
                        '${tests.where((t) => t['isPremium'] == true).length}',
                        'Premium',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Test Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: tests.map((test) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: TestCard(
                      test: test,
                      userIsPremium: userIsPremium,
                      onStart: () => startTest(test),
                      onRetake: () => retakeTest(test),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(BuildContext context, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF5B4EE8).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF5B4EE8).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF5B4EE8),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

class TestCard extends StatelessWidget {
  final Map<String, dynamic> test;
  final bool userIsPremium;
  final VoidCallback onStart;
  final VoidCallback onRetake;

  const TestCard({
    super.key,
    required this.test,
    required this.userIsPremium,
    required this.onStart,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPremium = test['isPremium'] as bool;
    final isLocked = isPremium && !userIsPremium;
    final attempts = test['attempts'] as int;
    final bestScore = test['bestScore'] as int;
    final questions = test['questions'] as int;
    final color = test['color'] as Color;
    final bestScorePercentage = questions > 0 ? (bestScore / questions) : 0.0;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLocked
              ? Colors.grey.withOpacity(0.3)
              : color.withOpacity(0.3),
          width: 1,
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
          // Card Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isLocked
                    ? [Colors.grey.withOpacity(0.1), Colors.grey.withOpacity(0.05)]
                    : [color.withOpacity(0.15), color.withOpacity(0.05)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isLocked
                        ? Colors.grey.withOpacity(0.2)
                        : color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    test['icon'],
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        test['name'],
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isLocked ? Colors.grey : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.quiz_outlined,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$questions Questions',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.timer_outlined,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${test['duration']} mins',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isLocked)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(8),
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
          ),

          // Card Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress (if attempted)
                if (attempts > 0) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Score: $bestScore/$questions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(bestScorePercentage * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: bestScorePercentage >= 0.7
                              ? Colors.green
                              : bestScorePercentage >= 0.5
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: bestScorePercentage,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        bestScorePercentage >= 0.7
                            ? Colors.green
                            : bestScorePercentage >= 0.5
                                ? Colors.orange
                                : Colors.red,
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Attempts: $attempts',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                ],

                // Buttons
                Row(
                  children: [
                    if (attempts > 0) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onRetake,
                          icon: const Icon(Icons.replay, size: 16),
                          label: const Text('Retake'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: color,
                            side: BorderSide(color: color),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onStart,
                        icon: Icon(
                          isLocked ? Icons.lock : Icons.play_arrow,
                          size: 16,
                        ),
                        label: Text(
                          isLocked
                              ? 'Unlock'
                              : attempts > 0
                                  ? 'Start Again'
                                  : 'Start Test',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isLocked ? Colors.amber : color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
