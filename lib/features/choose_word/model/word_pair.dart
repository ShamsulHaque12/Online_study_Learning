// ==================== MODEL ====================
// lib/models/word_pair.dart

class WordPair {
  final String english;
  final String filipino;

  WordPair({required this.english, required this.filipino});
}

class MatchingQuestion {
  final List<WordPair> correctPairs;
  final Map<String, String?> userAnswers;

  MatchingQuestion({
    required this.correctPairs,
    Map<String, String?>? userAnswers,
  }) : userAnswers = userAnswers ?? {};

  bool isCorrect(String english, String filipino) {
    return correctPairs.any(
      (pair) => pair.english == english && pair.filipino == filipino,
    );
  }

  bool hasAnswer(String english) {
    return userAnswers.containsKey(english) && userAnswers[english] != null;
  }

  String? getAnswer(String english) {
    return userAnswers[english];
  }
}