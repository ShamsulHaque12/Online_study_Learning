import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:online_study/features/listen_write/model/listen_model.dart';

class ListenWriteController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  
  // Observable variables
  final currentQuestionIndex = 0.obs;
  final selectedAnswer = Rxn<int>();
  final selectedWords = <String>[].obs;
  final showFeedback = false.obs;
  final score = 0.obs;
  final quizCompleted = false.obs;

  // Quiz data - 4 Multiple Choice + 8 Word Bank = 12 total screens
  final List<ListenModel> quizData = [
    // ========== 4 MULTIPLE CHOICE SCREENS ==========
    
    // Screen 1 - Multiple Choice
    ListenModel(
      id: 1,
      audioText: "Gusto siya ni Mark",
      displayText: "Gusto siya ni Mark",
      questionType: QuestionType.multipleChoice,
      options: [
        AnswerOption(text: "Mark ❤️ Girl", isCorrect: true),
        AnswerOption(text: "Girl ❤️ Carlo", isCorrect: false),
        AnswerOption(text: "Me ❤️ You", isCorrect: false),
        AnswerOption(text: "Me ❤️ Ana", isCorrect: false),
      ],
    ),

    // Screen 2 - Multiple Choice
    ListenModel(
      id: 2,
      audioText: "Kumain ako ng saging",
      displayText: "Kumain ako ng saging",
      questionType: QuestionType.multipleChoice,
      options: [
        AnswerOption(text: "I sleep now", isCorrect: false),
        AnswerOption(text: "I ate banana", isCorrect: true),
        AnswerOption(text: "I ate apple", isCorrect: false),
        AnswerOption(text: "I drink water", isCorrect: false),
      ],
    ),

    // Screen 3 - Multiple Choice
    ListenModel(
      id: 3,
      audioText: "Mainit ang panahon ngayon",
      displayText: "Mainit ang panahon ngayon",
      questionType: QuestionType.multipleChoice,
      options: [
        AnswerOption(text: "Weather is cold today", isCorrect: false),
        AnswerOption(text: "It is raining", isCorrect: false),
        AnswerOption(text: "It is snowing", isCorrect: false),
        AnswerOption(text: "Weather is hot today", isCorrect: true),
      ],
    ),

    // Screen 4 - Multiple Choice
    ListenModel(
      id: 4,
      audioText: "Masarap ang pagkain",
      displayText: "Masarap ang pagkain",
      questionType: QuestionType.multipleChoice,
      options: [
        AnswerOption(text: "Food is expensive", isCorrect: false),
        AnswerOption(text: "Food is cold", isCorrect: false),
        AnswerOption(text: "Food is delicious", isCorrect: true),
        AnswerOption(text: "Food is ready", isCorrect: false),
      ],
    ),

    // ========== 8 WORD BANK SCREENS ==========

    // Screen 5 - Word Bank
    ListenModel(
      id: 5,
      audioText: "I go to school every day",
      displayText: "I go to school every day",
      questionType: QuestionType.wordBank,
      correctAnswer: "Ako Pumapasok Sa Paaralan Araw-araw",
      wordBank: [
        WordOption(word: "Ako"),
        WordOption(word: "Bukas"),
        WordOption(word: "Sa"),
        WordOption(word: "Araw-araw"),
        WordOption(word: "Hindi"),
        WordOption(word: "Paaralan"),
        WordOption(word: "Pumapasok"),
        WordOption(word: "Ngayon"),
      ],
    ),

    // Screen 6 - Word Bank
    ListenModel(
      id: 6,
      audioText: "She likes reading books",
      displayText: "She likes reading books",
      questionType: QuestionType.wordBank,
      correctAnswer: "Gusto Niya Magbasa Ng Libro",
      wordBank: [
        WordOption(word: "Magbasa"),
        WordOption(word: "Tulog"),
        WordOption(word: "Niya"),
        WordOption(word: "Libro"),
        WordOption(word: "Ng"),
        WordOption(word: "Maglaro"),
        WordOption(word: "Kain"),
        WordOption(word: "Gusto"),
      ],
    ),

    // Screen 7 - Word Bank
    ListenModel(
      id: 7,
      audioText: "The cat is sleeping",
      displayText: "The cat is sleeping",
      questionType: QuestionType.wordBank,
      correctAnswer: "Ang Pusa Ay Natutulog",
      wordBank: [
        WordOption(word: "Ang"),
        WordOption(word: "Aso"),
        WordOption(word: "Umiiyak"),
        WordOption(word: "Natutulog"),
        WordOption(word: "Kumakain"),
        WordOption(word: "Ay"),
        WordOption(word: "Tumatakbo"),
        WordOption(word: "Pusa"),
      ],
    ),

    // Screen 8 - Word Bank
    ListenModel(
      id: 8,
      audioText: "My mother cooks every morning",
      displayText: "My mother cooks every morning",
      questionType: QuestionType.wordBank,
      correctAnswer: "Ang Aking Nanay Ay Nagluluto Tuwing Umaga",
      wordBank: [
        WordOption(word: "Tatay"),
        WordOption(word: "Ang"),
        WordOption(word: "Nagluluto"),
        WordOption(word: "Gabi"),
        WordOption(word: "Nanay"),
        WordOption(word: "Aking"),
        WordOption(word: "Tuwing"),
        WordOption(word: "Umaga"),
        WordOption(word: "Ay"),
      ],
    ),

    // Screen 9 - Word Bank
    ListenModel(
      id: 9,
      audioText: "We play basketball on weekends",
      displayText: "We play basketball on weekends",
      questionType: QuestionType.wordBank,
      correctAnswer: "Kami Ay Naglalaro Ng Basketball Tuwing Weekend",
      wordBank: [
        WordOption(word: "Kami"),
        WordOption(word: "Araw"),
        WordOption(word: "Naglalaro"),
       WordOption(word: "Weekend"),
        WordOption(word: "Basketball"),
        WordOption(word: "Tuwing"),
        WordOption(word: "Football"),
         WordOption(word: "Ng"),
      ],
    ),

    // Screen 10 - Word Bank
    ListenModel(
      id: 10,
      audioText: "The dog is running fast",
      displayText: "The dog is running fast",
      questionType: QuestionType.wordBank,
      correctAnswer: "Ang Aso Ay Tumatakbo Ng Mabilis",
      wordBank: [
        WordOption(word: "Naglalakad"),
        WordOption(word: "Ang"),
        WordOption(word: "Dahan"),
        WordOption(word: "Tumatakbo"),
        WordOption(word: "Ng"),
        WordOption(word: "Mabilis"),
        WordOption(word: "Pusa"),
        WordOption(word: "Aso"),
        
      ],
    ),

    // Screen 11 - Word Bank
    ListenModel(
      id: 11,
      audioText: "I want to drink water",
      displayText: "I want to drink water",
      questionType: QuestionType.wordBank,
      correctAnswer: "Gusto Kong Uminom Ng Tubig",
      wordBank: [
        WordOption(word: "Ng"),
        WordOption(word: "Gatas"),
        WordOption(word: "Uminom"),
        WordOption(word: "Tubig"),
        WordOption(word: "Kumain"),
        WordOption(word: "Gusto"),
        WordOption(word: "Kape"),
        WordOption(word: "Kong"),
      ],
    ),

    // Screen 12 - Word Bank
    ListenModel(
      id: 12,
      audioText: "They are studying in the library",
      displayText: "They are studying in the library",
      questionType: QuestionType.wordBank,
      correctAnswer: "Sila Ay Nag-aaral Sa Aklatan",
      wordBank: [
        WordOption(word: "Sila"),
        WordOption(word: "Bahay"),
        WordOption(word: "Naglalaro"),
        WordOption(word: "Sa"),
        WordOption(word: "Aklatan"),
         WordOption(word: "Ay"),
        WordOption(word: "Silid"),
        WordOption(word: "Nag-aaral"),
        
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  ListenModel get currentQuiz => quizData[currentQuestionIndex.value];

  double get progress => (currentQuestionIndex.value + 1) / quizData.length;

  void playAudio() async {
    await flutterTts.speak(currentQuiz.audioText);
  }

  // For Multiple Choice questions
  void selectAnswer(int index) {
    if (showFeedback.value) return;
    selectedAnswer.value = index;
  }

  // For Word Bank questions
  void toggleWord(String word) {
    if (showFeedback.value) return;
    
    if (selectedWords.contains(word)) {
      selectedWords.remove(word);
    } else {
      selectedWords.add(word);
    }
  }

  bool isCorrectAnswer() {
    if (currentQuiz.questionType == QuestionType.multipleChoice) {
      return selectedAnswer.value != null &&
          currentQuiz.options![selectedAnswer.value!].isCorrect;
    } else {
      // Word Bank - check if selected words match correct answer
      String userAnswer = selectedWords.join(" ");
      return userAnswer.trim().toLowerCase() ==
          currentQuiz.correctAnswer.trim().toLowerCase();
    }
  }

  void handleContinue() {
    // Check if user has made a selection
    if (currentQuiz.questionType == QuestionType.multipleChoice) {
      if (selectedAnswer.value == null) return;
    } else {
      if (selectedWords.isEmpty) return;
    }

    final isCorrect = isCorrectAnswer();

    if (!showFeedback.value) {
      // First click - show feedback
      showFeedback.value = true;
      if (isCorrect) {
        score.value++;
      }
    } else {
      // Second click - go to next (only if correct)
      if (isCorrect) {
        goToNextQuestion();
      }
    }
  }

  // NEW: Skip function for wrong answers
  void skipQuestion() {
    goToNextQuestion();
  }

  // NEW: Helper function to go to next question
  void goToNextQuestion() {
    if (currentQuestionIndex.value < quizData.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = null;
      selectedWords.clear();
      showFeedback.value = false;
    } else {
      quizCompleted.value = true;
    }
  }

  void restartQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswer.value = null;
    selectedWords.clear();
    showFeedback.value = false;
    score.value = 0;
    quizCompleted.value = false;
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
}