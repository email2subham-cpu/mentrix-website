import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/exam_constants.dart';
import 'results_screen.dart';

class QuestionScreen extends StatefulWidget {
  final String examType;
  final bool isTestSeries;

  const QuestionScreen({
    super.key,
    required this.examType,
    required this.isTestSeries,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late List<Map<String, dynamic>> questions;
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool showResult = false;
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int skippedAnswers = 0;
  late Stopwatch stopwatch;
  late Duration timePerQuestion;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch()..start();
    timePerQuestion = const Duration(minutes: 1);
    loadQuestions();
  }

  void loadQuestions() {
    // Mock questions with Bengali translations
    questions = [
      {
        'english': 'What is the capital of France?',
        'bengali': 'ফ্রান্সর রাজধানী কী?',
        'options': [
          {'english': 'London', 'bengali': 'লন্ডন'},
          {'english': 'Paris', 'bengali': 'প্যারিস'},
          {'english': 'Berlin', 'bengali': 'বার্লিন'},
          {'english': 'Madrid', 'bengali': 'মাদ্রিদ'},
        ],
        'correctIndex': 1,
        'explanation': {
          'english': 'Paris is the capital and largest city of France.',
          'bengali': 'প্যরিস ফ্রান্সের রাজধানী এবং বৃহত্তম শহর।'
        },
      },
      {
        'english': 'What is 2 + 2?',
        'bengali': '2 + 2 = কত?',
        'options': [
          {'english': '3', 'bengali': '3'},
          {'english': '4', 'bengali': '4'},
          {'english': '5', 'bengali': '5'},
          {'english': '6', 'bengali': '6'},
        ],
        'correctIndex': 1,
        'explanation': {
          'english': '2 + 2 equals 4.',
          'bengali': '2 + 2 = 4'
        },
      },
      {
        'english': 'Which planet is known as the Red Planet?',
        'bengali': 'কোন গ্রহক লাল গ্রহ বলা হয়?',
        'options': [
          {'english': 'Venus', 'bengali': 'শক্র'},
          {'english': 'Mars', 'bengali': 'মঙ্গল'},
          {'english': 'Jupiter', 'bengali': 'বৃহস্পত'},
          {'english': 'Saturn', 'bengali': 'শনি'},
        ],
        'correctIndex': 1,
        'explanation': {
          'english': 'Mars is known as the Red Planet due to iron oxide on its surface.',
          'bengali': 'মঙ্গল গ্রহকে তার পৃষ্ঠে লোহার অক্সইডের কারণে লাল গ্রহ বলা হয়।'
        },
      },
    ];
  }

  void submitAnswer() {
    if (selectedOptionIndex == null) {
      skippedAnswers++;
    } else if (selectedOptionIndex == questions[currentQuestionIndex]['correctIndex']) {
      correctAnswers++;
      showAnswerFeedback(true);
    } else {
      wrongAnswers++;
      showAnswerFeedback(false);
    }

    showResult = true;
    setState(() {});
  }

  void showAnswerFeedback(bool isCorrect) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isCorrect ? '✅ Correct!' : '❌ Wrong Answer'),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      selectedOptionIndex = null;
      showResult = false;
      currentQuestionIndex++;
      setState(() {});
    } else {
      // Test completed
      Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => ResultsScreen(
      examType: widget.examType,
      correctAnswers: correctAnswers,
      wrongAnswers: wrongAnswers,
      skippedQuestions: skippedAnswers,
      totalQuestions: questions.length,
      totalTimeSpent: stopwatch.elapsed.inSeconds,
      isTestSeries: widget.isTestSeries,
      testName: '${widget.examType} Practice',
    ),
  ),
);
   }
  }
  
  @override
  void dispose() {
    stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final question = questions[currentQuestionIndex];

    String questionText = languageProvider.getQuestionText(
      question['english'],
      question['bengali'],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Question'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Consumer<LanguageProvider>(
                builder: (context, langProvider, _) {
                  return GestureDetector(
                    onTap: () {
                      langProvider.toggleLanguage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        langProvider.currentLanguage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${((currentQuestionIndex + 1) / questions.length * 100).toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  minHeight: 8,
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF5B4EE8),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Question Text with Glassmorphism
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  questionText,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Options
              ...List.generate(
                question['options'].length,
                (index) {
                  String optionText = languageProvider.getOptionText(
                    question['options'][index]['english'],
                    question['options'][index]['bengali'],
                  );

                  bool isSelected = selectedOptionIndex == index;
                  bool isCorrect = index == question['correctIndex'];

                  Color optionColor = Colors.transparent;
                  if (showResult) {
                    if (isCorrect) {
                      optionColor = Colors.green.withOpacity(0.15);
                    } else if (isSelected && !isCorrect) {
                      optionColor = Colors.red.withOpacity(0.15);
                    }
                  } else if (isSelected) {
                    optionColor = Colors.purple.withOpacity(0.15);
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: showResult ? null : () {
                        setState(() {
                          selectedOptionIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: optionColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF5B4EE8)
                                : Colors.grey.withOpacity(0.3),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF5B4EE8)
                                      : Colors.grey,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? const Color(0xFF5B4EE8)
                                    : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                optionText,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (showResult && isCorrect)
                              const Icon(Icons.check_circle, color: Colors.green)
                            else if (showResult && isSelected && !isCorrect)
                              const Icon(Icons.cancel, color: Colors.red),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Explanation (show after answer)
              if (showResult) ...[
  Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Colors.amber.withOpacity(0.3),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explanation',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          languageProvider.getQuestionText(
            question['explanation']['english'],
            question['explanation']['bengali'],
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  ),
  const SizedBox(height: 12),

  // REPORT BUTTON - ADD THIS
  SizedBox(
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: () => showReportDialog(context),
      icon: const Icon(
        Icons.flag_outlined,
        color: Colors.red,
        size: 16,
      ),
      label: const Text(
        'Report Question',
        style: TextStyle(
          color: Colors.red,
          fontSize: 13,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        side: const BorderSide(color: Colors.red, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),
  const SizedBox(height: 32),
],

              // Buttons
              if (!showResult)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4EE8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Submit Answer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4EE8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      currentQuestionIndex == questions.length - 1
                          ? 'Finish Test'
                          : 'Next Question',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
