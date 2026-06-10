import 'package:flutter/material.dart';
import 'dart:math';

class ResultsScreen extends StatefulWidget {
  final String examType;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final int totalTimeSpent; // in seconds
  final bool isTestSeries;
  final String testName;

  const ResultsScreen({
    Key? key,
    required this.examType,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedQuestions,
    required this.totalTimeSpent,
    required this.isTestSeries,
    required this.testName,
  }) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late int scorePercentage;
  late int percentileRank;
  late String performanceLevel;
  late Color performanceColor;

  @override
  void initState() {
    super.initState();
    calculateResults();
  }

  void calculateResults() {
    // Calculate percentage
    scorePercentage = ((widget.correctAnswers / widget.totalQuestions) * 100).toInt();

    // Calculate percentile rank (mock calculation)
    // In real app, this would come from backend
    percentileRank = Random().nextInt(40) + (scorePercentage ~/ 2);
    if (percentileRank > 99) percentileRank = 99;

    // Determine performance level
    if (scorePercentage >= 80) {
      performanceLevel = 'Outstanding';
      performanceColor = Colors.green;
    } else if (scorePercentage >= 60) {
      performanceLevel = 'Good';
      performanceColor = Colors.blue;
    } else if (scorePercentage >= 40) {
      performanceLevel = 'Average';
      performanceColor = Colors.orange;
    } else {
      performanceLevel = 'Needs Improvement';
      performanceColor = Colors.red;
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes}m ${secs}s';
  }

  double getAverageTimePerQuestion() {
    return widget.totalTimeSpent / widget.totalQuestions;
  }

  @override
  Widget build(BuildContext context) {
    final averageTimePerQuestion = getAverageTimePerQuestion();

    return WillPopScope(
      onWillPop: () async => false, // Prevent back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Results'),
          backgroundColor: performanceColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Main Score Card
              Container(
                color: performanceColor,
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      performanceLevel,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Large score display
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${widget.correctAnswers}/${widget.totalQuestions}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '$scorePercentage%',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Percentile rank
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'You are in top ${percentileRank}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Score Breakdown
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Score Breakdown',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Correct answers
                      ScoreBreakdownItem(
                        icon: '✅',
                        label: 'Correct',
                        value: widget.correctAnswers.toString(),
                        color: Colors.green,
                        percentage: (widget.correctAnswers / widget.totalQuestions) * 100,
                      ),
                      const SizedBox(height: 16),

                      // Wrong answers
                      ScoreBreakdownItem(
                        icon: '❌',
                        label: 'Wrong',
                        value: widget.wrongAnswers.toString(),
                        color: Colors.red,
                        percentage: (widget.wrongAnswers / widget.totalQuestions) * 100,
                      ),
                      const SizedBox(height: 16),

                      // Skipped questions
                      ScoreBreakdownItem(
                        icon: '⏭️',
                        label: 'Skipped',
                        value: widget.skippedQuestions.toString(),
                        color: Colors.orange,
                        percentage: (widget.skippedQuestions / widget.totalQuestions) * 100,
                      ),
                    ],
                  ),
                ),
              ),

              // Time Analysis
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Time Analysis',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Total time
                      TimeAnalysisItem(
                        label: 'Total Time Spent',
                        value: formatTime(widget.totalTimeSpent),
                        icon: '⏱️',
                      ),
                      const SizedBox(height: 12),

                      // Average time per question
                      TimeAnalysisItem(
                        label: 'Average Time per Question',
                        value: '${averageTimePerQuestion.toStringAsFixed(1)}s',
                        icon: '⏲️',
                      ),
                      const SizedBox(height: 12),

                      // Expected time (mock)
                      TimeAnalysisItem(
                        label: 'Expected Time',
                        value: formatTime((widget.totalQuestions * 90)), // 90 sec per question
                        icon: '📊',
                      ),
                    ],
                  ),
                ),
              ),

              // Performance Tips
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple[300]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Performance Tips',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _getPerformanceTip(),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Retry button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Go back to test/practice
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: performanceColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Retake Test',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Go back button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Go back to test/practice selection
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: Color(0xFF5B4EE8),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5B4EE8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPerformanceTip() {
    if (scorePercentage >= 80) {
      return '🌟 Excellent performance! You have mastered this topic. Try harder questions to improve further.';
    } else if (scorePercentage >= 60) {
      return '👍 Good job! Review the topics you missed and practice more similar questions.';
    } else if (scorePercentage >= 40) {
      return '📚 You need more practice. Go back and study the concepts again before retaking the test.';
    } else {
      return '⚠️ Please review all the concepts thoroughly. Consider taking the practice questions first before retaking this test.';
    }
  }
}

class ScoreBreakdownItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;
  final double percentage;

  const ScoreBreakdownItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(icon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${percentage.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class TimeAnalysisItem extends StatelessWidget {
  final String label;
  final String value;
  final String icon;

  const TimeAnalysisItem({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
