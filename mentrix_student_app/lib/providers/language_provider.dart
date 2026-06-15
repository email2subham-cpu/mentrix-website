import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'English'; // English or Bengali

  String get currentLanguage => _currentLanguage;

  bool get isBengali => _currentLanguage == 'Bengali';
  bool get isEnglish => _currentLanguage == 'English';

  void setLanguage(String language) {
    if (language == 'English' || language == 'Bengali') {
      _currentLanguage = language;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    _currentLanguage = _currentLanguage == 'English' ? 'Bengali' : 'English';
    notifyListeners();
  }

  // Get translated question text
  String getQuestionText(
    String englishText,
    String bengaliText,
  ) {
    return _currentLanguage == 'English' ? englishText : bengaliText;
  }

  // Get translated option text
  String getOptionText(
    String englishText,
    String bengaliText,
  ) {
    return _currentLanguage == 'English' ? englishText : bengaliText;
  }
}
