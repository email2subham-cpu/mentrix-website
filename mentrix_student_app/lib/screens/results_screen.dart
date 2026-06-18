import 'package:flutter/material.dart';
import 'dart:math';

class ResultsScreen extends StatefulWidget {
  final String examType;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int skippedQuestions;
  final int totalTimeSpent;
  final bool isTestSeries;
  final String testName;

  const ResultsScreen({
    super.key,
    required this.examType,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.skippedQuestions,
    required this.totalTimeSpent,
    required this.isTestSeries,
    required this.testName,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scoreAnimation;
  late int scorePercentage;
  late String performanceLevel;
  late Color performanceColor;
  late String performanceEmoji;
  late int percentileRank;

  @override
  void initState() {
    super.initState();
    calculateResults();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _scoreAnimation = Tween<double>(
      begin: 0,
      end: scorePercentage / 100,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  void calculateResults() {
    scorePercentage = widget.totalQuestions > 0
        ? ((widget.correctAnswers / widget.totalQuestions) * 100).round()
        : 0;

    percentileRank = Random().nextInt(30) + 70; // Mock percentile

    if (scorePercentage >= 90) {
      performanceLevel = 'Excellent! 🌟';
      performanceColor = Colors.green;
      performanceEmoji = '🏆';
    } else if (scorePercentage >= 75) {
      performanceLevel = 'Great Job! 👍';
      performanceColor = Colors.blue;
      performanceEmoji = '😊';
    } else if (scorePercentage >= 60) {
      performanceLevel = 'Good Effort! 💪';
      performanceColor = Colors.orange;
      performanceEmoji = '🙂';
    } else if (scorePercentage >= 40) {
      performanceLevel = 'Keep Practicing! 📚';
      performanceColor = Colors.orange[700]!;
      performanceEmoji = '😐';
    } else {
      performanceLevel = 'Need Improvement! 💡';
      performanceColor = Colors.red;
      performanceEmoji = '😟';
    }
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Results'),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Score Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      performanceColor.withOpacity(0.8),
                      performanceColor.withOpacity(0.4),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      performanceEmoji,
                      style: const TextStyle(fontSize: 60),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      performanceLevel,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.testName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Score Circle
                    AnimatedBuilder(
                      animation: _scoreAnimation,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              height: 140,
                              child: CircularProgressIndicator(
                                value: _scoreAnimation.value,
                                strokeWidth: 12,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${(_scoreAnimation.value * 100).round()}%',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Score',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Stats Grid
              Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                  children: [
                    _buildStatCard(
                      context,
                      icon: '✅',
                      label: 'Correct',
                      value: '${widget.correctAnswers}',
                      color: Colors.green,
                      isDark: isDark,
                    ),
                    _buildStatCard(
                      context,
                      icon: '❌',
                      label: 'Wrong',
                      value: '${widget.wrongAnswers}',
                      color: Colors.red,
                      isDark: isDark,
                    ),
                    _buildStatCard(
                      context,
                      icon: '⏭️',
                      label: 'Skipped',
                      value: '${widget.skippedQuestions}',
                      color: Colors.orange,
                      isDark: isDark,
                    ),
                    _buildStatCard(
                      context,
                      icon: '⏱️',
                      label: 'Time Taken',
                      value: formatTime(widget.totalTimeSpent),
                      color: Colors.blue,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              // Performance Analysis
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📊 Performance Analysis',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Correct answers bar
                      _buildAnalysisBar(
                        context,
                        label: 'Correct',
                        value: widget.correctAnswers,
                        total: widget.totalQuestions,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 12),

                      // Wrong answers bar
                      _buildAnalysisBar(
                        context,
                        label: 'Wrong',
                        value: widget.wrongAnswers,
                        total: widget.totalQuestions,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 12),

                      // Skipped answers bar
                      _buildAnalysisBar(
                        context,
                        label: 'Skipped',
                        value: widget.skippedQuestions,
                        total: widget.totalQuestions,
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Percentile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF5B4EE8).withOpacity(0.15),
                        const Color(0xFF00D9FF).withOpacity(0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF5B4EE8).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text('🎯', style: TextStyle(fontSize: 40)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Percentile Rank',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Better than $percentileRank% of students',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '$percentileRank%',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5B4EE8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Quick Summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '📝 Quick Summary',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        context,
                        'Total Questions',
                        '${widget.totalQuestions}',
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        context,
                        'Score',
                        '${widget.correctAnswers}/${widget.totalQuestions}',
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        context,
                        'Percentage',
                        '$scorePercentage%',
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        context,
                        'Time Taken',
                        formatTime(widget.totalTimeSpent),
                      ),
                      const Divider(),
                      _buildSummaryRow(
                        context,
                        'Exam Type',
                        widget.examType,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Retake Test Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.replay),
                        label: const Text('Retake Test'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B4EE8),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Go Home Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Go Home'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: Color(0xFF5B4EE8),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisBar(
    BuildContext context, {
    required String label,
    required int value,
    required int total,
    required Color color,
  }) {
    final percentage = total > 0 ? value / total : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$value/$total (${(percentage * 100).round()}%)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
