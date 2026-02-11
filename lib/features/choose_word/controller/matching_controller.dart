import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_study/features/choose_word/model/word_pair.dart';

class MatchingController extends GetxController {
  final List<MatchingQuestion> _questions;

  MatchingController(this._questions);

  final _currentIndex = 0.obs;
  final _selectedEnglish = Rxn<String>();

  final _englishWords = <String>[].obs;
  final _filipinoWords = <String>[].obs;

  final _result = <String, bool>{}.obs; // english -> correct/wrong
  final _usedFilipino = <String>{}.obs;

  // =====================
  // GETTERS
  // =====================
  int get currentIndex => _currentIndex.value;
  int get totalScreens => _questions.length;
  bool get isLast => currentIndex == totalScreens - 1;

  double get progress => (currentIndex + 1) / totalScreens;

  MatchingQuestion get question => _questions[currentIndex];

  List<String> get englishWords => _englishWords;
  List<String> get filipinoWords => _filipinoWords;

  bool get canContinue => _result.length == 6;

  // =====================
  // INIT
  // =====================
  @override
  void onInit() {
    super.onInit();
    _loadScreen();
  }

  void _loadScreen() {
    _englishWords.value =
        question.correctPairs.map((e) => e.english).toList()..shuffle();

    _filipinoWords.value =
        question.correctPairs.map((e) => e.filipino).toList()..shuffle();

    _selectedEnglish.value = null;
    _result.clear();
    _usedFilipino.clear();
    question.userAnswers.clear();
  }

  // =====================
  // ACTIONS
  // =====================
  void selectEnglish(String word) {
    if (_result.containsKey(word)) return;
    _selectedEnglish.value = word;
    update();
  }

  void selectFilipino(String word) {
    if (_selectedEnglish.value == null) return;
    if (_usedFilipino.contains(word)) return;

    final english = _selectedEnglish.value!;
    final correct = question.isCorrect(english, word);

    _result[english] = correct;
    _usedFilipino.add(word);
    question.userAnswers[english] = word;

    _selectedEnglish.value = null;
    update();
  }

  // =====================
  // COLORS
  // =====================
  Color englishColor(String word) {
    if (_selectedEnglish.value == word) {
      return Colors.green.shade100;
    }

    if (_result.containsKey(word)) {
      return _result[word]!
          ? Colors.green.shade100
          : Colors.red.shade100;
    }
    return Colors.white;
  }

  Color filipinoColor(String word) {
    final entry = question.userAnswers.entries
        .where((e) => e.value == word);

    if (entry.isNotEmpty) {
      return _result[entry.first.key]!
          ? Colors.green.shade100
          : Colors.red.shade100;
    }
    return Colors.white;
  }

  // =====================
  // NAVIGATION
  // =====================
  void next() {
    if (!canContinue) return;
    if (!isLast) {
      _currentIndex.value++;
      _loadScreen();
      update();
    }
  }

  void reset() {
    _currentIndex.value = 0;
    for (final q in _questions) {
      q.userAnswers.clear();
    }
    _loadScreen();
    update();
  }
}
