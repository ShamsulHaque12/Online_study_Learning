
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/features/find_image/widgets/result_popup_screen.dart';
import 'package:online_study/features/write_word/model/sentence_question.dart';

class SentenceController extends GetxController {
  final RxInt currentQuestion = 0.obs;
  final RxList<String> arrangedWords = <String>[].obs;
  final RxList<String> availableWords = <String>[].obs;
  final RxInt score = 0.obs;

  final List<SentenceQuestion> questions = [
    // English to Filipino (First 5)
    SentenceQuestion(
      id: 1,
      displaySentence: "I am nervous about the exam",
      shuffledWords: ["Kinakabahan", "sa", "ako", "pagsusulit"],
      correctAnswer: ["Kinakabahan", "ako", "sa", "pagsusulit"],
      isEnglishToFilipino: true,
    ),
    SentenceQuestion(
      id: 2,
      displaySentence: "She is happy",
      shuffledWords: ["masaya", "Siya", "ay"],
      correctAnswer: ["Siya", "ay", "masaya"],
      isEnglishToFilipino: true,
    ),
    SentenceQuestion(
      id: 3,
      displaySentence: "We are eating",
      shuffledWords: ["kumakain", "Kami", "ay"],
      correctAnswer: ["Kami", "ay", "kumakain"],
      isEnglishToFilipino: true,
    ),
    SentenceQuestion(
      id: 4,
      displaySentence: "The book is good",
      shuffledWords: ["maganda", "libro", "ang", "Ay"],
      correctAnswer: ["Ay", "maganda", "ang", "libro"],
      isEnglishToFilipino: true,
    ),
    SentenceQuestion(
      id: 5,
      displaySentence: "I love you",
      shuffledWords: ["kita", "Mahal"],
      correctAnswer: ["Mahal", "kita"],
      isEnglishToFilipino: true,
    ),
    // Filipino to English (Next 5)
    SentenceQuestion(
      id: 6,
      displaySentence: "Maganda ang araw",
      shuffledWords: ["beautiful", "is", "The", "day"],
      correctAnswer: ["The", "day", "is", "beautiful"],
      isEnglishToFilipino: false,
    ),
    SentenceQuestion(
      id: 7,
      displaySentence: "Nahihiya ako sa kanya",
      shuffledWords: ["him/her", "am", "I", "shy", "with"],
      correctAnswer: ["I", "am", "shy", "with", "him/her"],
      isEnglishToFilipino: false,
    ),
    SentenceQuestion(
      id: 8,
      displaySentence: "Pupunta kami sa palengke",
      shuffledWords: ["to", "the", "market", "go", "We", "will"],
      correctAnswer: ["We", "will", "go", "to", "the", "market"],
      isEnglishToFilipino: false,
    ),
    SentenceQuestion(
      id: 9,
      displaySentence: "Natutulog ang bata",
      shuffledWords: ["is", "sleeping", "child", "The"],
      correctAnswer: ["The", "child", "is", "sleeping"],
      isEnglishToFilipino: false,
    ),
    SentenceQuestion(
      id: 10,
      displaySentence: "Masarap ang pagkain",
      shuffledWords: ["delicious", "is", "food", "The"],
      correctAnswer: ["The", "food", "is", "delicious"],
      isEnglishToFilipino: false,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeQuestion();
  }

  void _initializeQuestion() {
    final question = questions[currentQuestion.value];
    availableWords.value = List.from(question.shuffledWords)..shuffle();
    arrangedWords.clear();
  }

  void addWordToArranged(String word) {
    arrangedWords.add(word);
    availableWords.remove(word);
  }

  void removeWordFromArranged(String word) {
    availableWords.add(word);
    arrangedWords.remove(word);
  }

  void checkAnswer() {
    final question = questions[currentQuestion.value];
    
    if (_isAnswerCorrect(arrangedWords, question.correctAnswer)) {
      score.value++;
      
      if (currentQuestion.value < questions.length - 1) {
        // Move to next question
        Get.snackbar(
          'Correct!',
          'Well done!',
          backgroundColor: Get.theme.primaryColor.withOpacity(0.1),
          duration: const Duration(seconds: 1),
        );
        
        Future.delayed(const Duration(milliseconds: 1000), () {
          currentQuestion.value++;
          _initializeQuestion();
        });
      } else {
        // Show result popup
        _showResultPopup();
      }
    } else {
      // Wrong answer
      Get.snackbar(
        'Incorrect',
        'Try again!',
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.1),
        duration: const Duration(seconds: 1),
      );
    }
  }

  bool _isAnswerCorrect(List<String> arranged, List<String> correct) {
    if (arranged.length != correct.length) return false;
    for (int i = 0; i < arranged.length; i++) {
      if (arranged[i] != correct[i]) return false;
    }
    return true;
  }

  void _showResultPopup() {
    Get.dialog(
      ResultPopup(
        score: score.value,
        total: questions.length,
        onTryAgain: resetQuiz,
      ),
      barrierDismissible: false,
    );
  }

  void resetQuiz() {
    currentQuestion.value = 0;
    score.value = 0;
    _initializeQuestion();
    Get.back();
  }

  SentenceQuestion getCurrentQuestion() {
    return questions[currentQuestion.value];
  }
}
