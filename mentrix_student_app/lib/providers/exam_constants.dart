class ExamConstants {
  // JEE Mains - 25 questions per subject
  static const Map<String, int> jeeMainsQuestions = {
    'Physics': 25,
    'Chemistry': 25,
    'Mathematics': 25,
  };

  static const int jeeMainsTestSeries = 75; // Total for full test

  // NEET - Subject wise questions
  static const Map<String, int> neetQuestions = {
    'Physics': 45,
    'Chemistry': 45,
    'Biology': 90,
  };

  static const int neetTestSeries = 180; // Total for full test

  // WBJEE - Subject wise questions
  static const Map<String, int> wbjeeQuestions = {
    'Physics': 40,
    'Chemistry': 40,
    'Mathematics': 75,
  };

  static const int wbjeeTestSeries = 155; // Total for full test

  // WBCHSE - Subject wise questions
  static const Map<String, int> wbchseQuestions = {
    'Physics': 35,
    'Chemistry': 35,
    'Biology': 35,
    'History': 35,
    'Geography': 35,
    'Bengali': 40,
    'English': 40,
    'Mathematics': 40,
  };

  // Test Series Duration (in minutes)
  static const Map<String, int> examDuration = {
    'WBCHSE': 75,
    'NEET': 180,
    'JEE Mains': 180,
    'WBJEE': 120,
  };

  // Get questions for exam subject
  static int getQuestionCount(String examType, String subject) {
    switch (examType) {
      case 'JEE Mains':
        return jeeMainsQuestions[subject] ?? 25;
      case 'NEET':
        return neetQuestions[subject] ?? 45;
      case 'WBJEE':
        return wbjeeQuestions[subject] ?? 40;
      case 'WBCHSE':
        return wbchseQuestions[subject] ?? 35;
      default:
        return 35;
    }
  }

    // Get exam duration
  static int getExamDuration(String examType) {
    return examDuration[examType] ?? 60;
  }
}
