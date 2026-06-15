import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'providers/exam_constants.dart';
import 'screens/question_screen.dart';
import 'screens/test_series_screen.dart';
import 'screens/results_screen.dart';
import 'screens/premium_lock_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/refer_and_earn_screen.dart';
import 'screens/payment_subscription_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: const MentrixApp(),
    ),
  );
}

class MentrixApp extends StatelessWidget {
  const MentrixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Mentrix',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final exams = [
      {'name': 'WBCHSE', 'icon': '📋', 'color': Colors.blue},
      {'name': 'NEET', 'icon': '🏥', 'color': Colors.green},
      {'name': 'JEE Mains', 'icon': '🔬', 'color': Colors.orange},
      {'name': 'WBJEE', 'icon': '🎯', 'color': Colors.purple},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentrix'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfileScreen(
                    userName: 'Subham',
                    userEmail: 'subham@mentrix.com',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [AppTheme.surfaceDark, AppTheme.backgroundDark]
                      : [AppTheme.primaryLight.withOpacity(0.1), AppTheme.secondaryLight.withOpacity(0.1)],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Master Your Exams',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Practice MCQs, Take Tests & Track Progress',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isDark ? AppTheme.textDarkSecondary : AppTheme.textLightSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppTheme.primaryGradient,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Select an exam below to get started!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Exam Selection
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Your Exam',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return ExamCard(
                        name: exam['name'] as String,
                        icon: exam['icon'] as String,
                        color: exam['color'] as Color,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectListPage(
                                examType: exam['name'] as String,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // Action Buttons Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green.withOpacity(0.2),
                          Colors.green.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.green),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'New: Answer Keys for WBCHSE are LIVE!',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Leaderboard Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeaderboardScreen(
                              examType: 'WBCHSE',
                              subjectName: 'All Subjects',
                            ),
                          ),
                        );
                      },
                      icon: const Text('🏆', style: TextStyle(fontSize: 18)),
                      label: const Text('View Leaderboard'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Refer & Earn Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReferAndEarnScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.card_giftcard),
                      label: const Text('Refer & Earn 🎁'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Go Premium Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentSubscriptionScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.card_giftcard),
                      label: const Text('Go Premium 👑'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
    );
  }
}

// Exam Card with Glassmorphism
class ExamCard extends StatelessWidget {
  final String name;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const ExamCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// SUBJECT LIST PAGE
class SubjectListPage extends StatelessWidget {
  final String examType;

  const SubjectListPage({super.key, required this.examType});

  List<Map<String, String>> getSubjectsForExam(String examType) {
    switch (examType) {
      case 'WBCHSE':
        return [
          {'name': 'Physics', 'icon': '⚡'},
          {'name': 'Chemistry', 'icon': '⚗️'},
          {'name': 'Biology', 'icon': '🌿'},
          {'name': 'Mathematics', 'icon': '🔢'},
          {'name': 'History', 'icon': '📜'},
          {'name': 'Geography', 'icon': '🌍'},
          {'name': 'Bengali', 'icon': '📖'},
          {'name': 'English', 'icon': '🔤'},
        ];
      case 'NEET':
        return [
          {'name': 'Physics', 'icon': '⚡'},
          {'name': 'Chemistry', 'icon': '⚗️'},
          {'name': 'Biology', 'icon': '🌿'},
        ];
      case 'JEE Mains':
        return [
          {'name': 'Physics', 'icon': '⚡'},
          {'name': 'Chemistry', 'icon': '⚗️'},
          {'name': 'Mathematics', 'icon': '🔢'},
        ];
      case 'WBJEE':
        return [
          {'name': 'Physics', 'icon': '⚡'},
          {'name': 'Chemistry', 'icon': '⚗️'},
          {'name': 'Mathematics', 'icon': '🔢'},
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(examType),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: const TabBar(
                tabs: [
                  Tab(text: 'Practice'),
                  Tab(text: 'Test Series'),
                ],
                indicatorColor: Colors.white,
                indicatorWeight: 3,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PracticeTab(
              examType: examType,
              subjects: getSubjectsForExam(examType),
            ),
            TestSeriesScreen(
              examType: examType,
              subjectName: examType,
            ),
          ],
        ),
      ),
    );
  }
}

class PracticeTab extends StatelessWidget {
  final String examType;
  final List<Map<String, String>> subjects;

  const PracticeTab({
    super.key,
    required this.examType,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.1,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return SubjectCard(
            name: subject['name'] as String,
            icon: subject['icon'] as String,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterListPage(
                    examType: examType,
                    subjectName: subject['name'] as String,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String name;
  final String icon;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// CHAPTER LIST PAGE
class ChapterListPage extends StatelessWidget {
  final String examType;
  final String subjectName;

  const ChapterListPage({
    super.key,
    required this.examType,
    required this.subjectName,
  });

  @override
  Widget build(BuildContext context) {
    final chapters = [
      {'id': 1, 'name': 'Chapter 1: Introduction'},
      {'id': 2, 'name': 'Chapter 2: Basics'},
      {'id': 3, 'name': 'Chapter 3: Advanced Concepts'},
      {'id': 4, 'name': 'Chapter 4: Applications'},
      {'id': 5, 'name': 'Chapter 5: Practice Problems'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ChapterCard(
                name: chapter['name'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicListPage(
                        examType: examType,
                        subjectName: subjectName,
                        chapterName: chapter['name'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const ChapterCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.orange.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.orange.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}

// TOPIC LIST PAGE
class TopicListPage extends StatelessWidget {
  final String examType;
  final String subjectName;
  final String chapterName;

  const TopicListPage({
    super.key,
    required this.examType,
    required this.subjectName,
    required this.chapterName,
  });

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'id': 1, 'name': 'Topic 1.1: Basic Concepts'},
      {'id': 2, 'name': 'Topic 1.2: Key Definitions'},
      {'id': 3, 'name': 'Topic 1.3: Formulas & Theorems'},
      {'id': 4, 'name': 'Topic 1.4: Problem Solving'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(chapterName),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TopicCard(
                name: topic['name'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubtopicListPage(
                        examType: examType,
                        subjectName: subjectName,
                        chapterName: chapterName,
                        topicName: topic['name'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const TopicCard({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.green.withOpacity(0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.green.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}

// SUBTOPIC LIST PAGE
class SubtopicListPage extends StatelessWidget {
  final String examType;
  final String subjectName;
  final String chapterName;
  final String topicName;

  const SubtopicListPage({
    super.key,
    required this.examType,
    required this.subjectName,
    required this.chapterName,
    required this.topicName,
  });

  @override
  Widget build(BuildContext context) {
    final subtopics = [
      {'id': 1, 'name': 'Subtopic 1.1.1', 'isPremium': false},
      {'id': 2, 'name': 'Subtopic 1.1.2', 'isPremium': false},
      {'id': 3, 'name': 'Subtopic 1.1.3', 'isPremium': true},
      {'id': 4, 'name': 'Subtopic 1.1.4', 'isPremium': true},
    ];

    bool userIsPremium = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(topicName),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: subtopics.length,
          itemBuilder: (context, index) {
            final subtopic = subtopics[index];
            final isPremium = subtopic['isPremium'] as bool;
            final isLocked = isPremium && !userIsPremium;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SubtopicCard(
                name: subtopic['name'] as String,
                questionCount: ExamConstants.getQuestionCount(examType, subjectName),
                isLocked: isLocked,
                onTap: () {
                  if (isLocked) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PremiumLockScreen(
                          lockReason: 'subtopic_limit',
                          examType: examType,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionScreen(
                          examType: examType,
                          isTestSeries: false,
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubtopicCard extends StatelessWidget {
  final String name;
  final int questionCount;
  final bool isLocked;
  final VoidCallback onTap;

  const SubtopicCard({
    super.key,
    required this.name,
    required this.questionCount,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isLocked
                  ? Colors.grey.withOpacity(0.1)
                  : Colors.purple.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isLocked
                    ? Colors.grey.withOpacity(0.4)
                    : Colors.purple.withOpacity(0.4),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isLocked ? Colors.grey : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$questionCount Questions',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isLocked ? Colors.grey : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isLocked ? Icons.lock : Icons.arrow_forward,
                  color: isLocked ? Colors.grey : Colors.purple.withOpacity(0.7),
                ),
              ],
            ),
          ),
          if (isLocked)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
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
            ),
        ],
      ),
    );
  }
}
