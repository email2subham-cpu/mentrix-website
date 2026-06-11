import 'package:flutter/material.dart';
import 'results_screen.dart';

class QuestionScreen extends StatefulWidget {
  final String examType; // WBCHSE, NEET, JEE, WBJEE
  final bool isTestSeries;
  
  const QuestionScreen({
    Key? key,
    required this.examType,
    required this.isTestSeries,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // Mock questions data
  late List<Map<String, dynamic>> questions;
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool isAnswered = false;
  String? resultMessage;
  bool isCorrect = false;
  DateTime? answerStartTime;
  int? answerTime; // in seconds
  double? averageAnswerTime; // mock average time
  String emoji = '';
  
  // Test series timer
  late Stopwatch testTimer;
  late int totalTestTime; // in seconds
  bool isTestRunning = false;

  @override
  void initState() {
    super.initState();
    loadMockQuestions();
    answerStartTime = DateTime.now();
    
    if (widget.isTestSeries) {
      totalTestTime = getTestDuration();
      testTimer = Stopwatch()..start();
      isTestRunning = true;
    }
  }

  void loadMockQuestions() {
    questions = [
      {
        'id': 1,
        'questionBn': 'পানির অণুতে কতটি হাইড্রোজেন পরমাণু থাকে?',
        'questionEn': 'How many hydrogen atoms are in a water molecule?',
        'options': ['১টি', '२টি', '३টি', '४টি'],
        'optionsEn': ['1', '2', '3', '4'],
        'correctAnswer': 1,
        'explanation': 'পানির রাসায়নিক সূত্র H₂O। এতে ২টি হাইড্রোজেন পরমাণু এবং ১টি অক্সিজেন পরমাণু রয়েছে।',
        'explanationEn': 'The chemical formula of water is H₂O. It contains 2 hydrogen atoms and 1 oxygen atom.',
        'averageTime': 8, // seconds
      },
      {
        'id': 2,
        'questionBn': 'বাংলাদেশের রাজধানী কোনটি?',
        'questionEn': 'What is the capital of Bangladesh?',
        'options': ['চট্টগ্রাম', 'ঢাকা', 'খুলনা', 'রাজশাহী'],
        'optionsEn': ['Chattogram', 'Dhaka', 'Khulna', 'Rajshahi'],
        'correctAnswer': 1,
        'explanation': 'ঢাকা বাংলাদেশের রাজধানী এবং বৃহত্তম শহর। এটি দেশের মধ্যাংশে অবস্থিত।',
        'explanationEn': 'Dhaka is the capital and largest city of Bangladesh. It is located in the central part of the country.',
        'averageTime': 5,
      },
      {
        'id': 3,
        'questionBn': 'সূর্যের চারপাশে পৃথিবীর কক্ষপথ কত সময়ে সম্পন্ন হয়?',
        'questionEn': 'How long does it take for Earth to orbit the Sun?',
        'options': ['১ মাস', '৬ মাস', '১ বছর', '২ বছর'],
        'optionsEn': ['1 month', '6 months', '1 year', '2 years'],
        'correctAnswer': 2,
        'explanation': 'পৃথিবী সূর্যের চারপাশে ৩৬৫ দিন (১ বছর) সময়ে একটি সম্পূর্ণ কক্ষপথ অতিক্রম করে।',
        'explanationEn': 'Earth takes 365 days (1 year) to complete one full orbit around the Sun.',
        'averageTime': 10,
      },
    ];
  }

  int getTestDuration() {
    switch (widget.examType.toUpperCase()) {
      case 'WBCHSE':
        return 75 * 60; // 75 minutes
      case 'NEET':
        return 180 * 60; // 180 minutes
      case 'JEE':
        return 180 * 60; // 180 minutes
      case 'WBJEE':
        return 120 * 60; // 120 minutes (WBJEE is 2 hours)
      default:
        return 60 * 60; // 1 hour default
    }
  }

  void selectOption(int index) {
    if (!isAnswered) {
      setState(() {
        selectedOptionIndex = index;
      });
    }
  }

  void submitAnswer() {
    if (selectedOptionIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an option')),
      );
      return;
    }

    // Calculate answer time
    answerTime = DateTime.now().difference(answerStartTime!).inSeconds;
    averageAnswerTime = questions[currentQuestionIndex]['averageTime'].toDouble();

    // Determine if correct
    isCorrect = selectedOptionIndex == questions[currentQuestionIndex]['correctAnswer'];

    // Set result message and emoji
    if (isCorrect) {
      resultMessage = 'Congratulations!';
      if (answerTime! < averageAnswerTime!) {
        emoji = '😊'; // Fast and correct
      } else {
        emoji = '🙂'; // Correct but slow
      }
    } else {
      resultMessage = 'Wrong!';
      emoji = '😟'; // Wrong answer
    }

    setState(() {
      isAnswered = true;
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswered = false;
        resultMessage = null;
        emoji = '';
        answerStartTime = DateTime.now();
      });
    } else {
      // Test completed
      showTestCompletionDialog();
    }
  }

  void showTestCompletionDialog() {
  // Calculate correct, wrong, skipped answers
  int correctAnswers = 0;
  int wrongAnswers = 0;
  int skippedAnswers = 0;
  
  // This is a mock calculation - you'll calculate from actual answers
  correctAnswers = 42;
  wrongAnswers = 5;
  skippedAnswers = 3;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultsScreen(
        examType: widget.examType,
        totalQuestions: questions.length,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        skippedQuestions: skippedAnswers,
        totalTimeSpent: DateTime.now().difference(answerStartTime!).inSeconds,
        isTestSeries: widget.isTestSeries,
        testName: 'Mock Test 1',
      ),
    ),
  );
}

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final timeRemaining = totalTestTime - testTimer.elapsed.inSeconds;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isTestSeries ? '${widget.examType} Test' : 'Question Practice'),
        backgroundColor: const Color(0xFF5B4EE8),
        elevation: 0,
        actions: widget.isTestSeries
            ? [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      formatTime(timeRemaining),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B4EE8),
                    ),
                  ),
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5B4EE8)),
                    minHeight: 8,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Question text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentQuestion['questionBn'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentQuestion['questionEn'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Answer options
              ...List.generate(
                currentQuestion['options'].length,
                (index) => GestureDetector(
                  onTap: () => selectOption(index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedOptionIndex == index
                            ? Colors.green
                            : Colors.grey[300]!,
                        width: selectedOptionIndex == index ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: selectedOptionIndex == index
                          ? Colors.green.withOpacity(0.1)
                          : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedOptionIndex == index
                                  ? Colors.green
                                  : Colors.grey[400]!,
                            ),
                            color: selectedOptionIndex == index
                                ? Colors.green
                                : Colors.transparent,
                          ),
                          child: selectedOptionIndex == index
                              ? const Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentQuestion['options'][index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                currentQuestion['optionsEn'][index],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Submit button (only if not answered)
              if (!isAnswered)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: submitAnswer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4EE8),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit Answer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              // Result popup (if answered)
              if (isAnswered)
                Column(
                  children: [
                    // Result popup
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            emoji,
                            style: const TextStyle(fontSize: 48),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            resultMessage!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (!isCorrect)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Correct Answer: ${currentQuestion['options'][currentQuestion['correctAnswer']]}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            'Time: ${answerTime}s (Avg: ${averageAnswerTime?.toStringAsFixed(0)}s)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Explanation
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explanation:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion['explanation'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion['explanationEn'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Next button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5B4EE8),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          currentQuestionIndex < questions.length - 1
                              ? 'Next Question'
                              : 'Complete Test',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.isTestSeries) {
      testTimer.stop();
    }
    super.dispose();
  }
}
