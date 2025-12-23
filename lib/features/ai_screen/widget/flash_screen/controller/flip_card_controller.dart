import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../model/quiz_card_model.dart';

class FlipCardController extends GetxController {
  // Observables
  var currentIndex = 0.obs;
  var isFlipped = false.obs;
  var isListening = false.obs;
  var spokenText = "".obs;
  var bookmarkedIndexes = <int>[].obs;

  // TTS & STT
  final FlutterTts tts = FlutterTts();
  late stt.SpeechToText speech;

  // Quiz data
  final quizCards = <QuizCardModel>[
    QuizCardModel(
      question: "How do you say this in tagalog",
      word: "Kamusta",
      pronunciation: "Koo-mus-ta",
      meaning: "How are you",
    ),
    QuizCardModel(
      question: "How do you say this in tagalog",
      word: "Salamat",
      pronunciation: "Sa-la-mat",
      meaning: "Thank you",
    ),
    QuizCardModel(
      question: "How do you say this in tagalog",
      word: "Magandang umaga",
      pronunciation: "Ma-gan-dang u-ma-ga",
      meaning: "Good morning",
    ),
    QuizCardModel(
      question: "How do you say this in tagalog",
      word: "Paalam",
      pronunciation: "Pa-a-lam",
      meaning: "Goodbye",
    ),
    QuizCardModel(
      question: "How do you say this in tagalog",
      word: "Oo",
      pronunciation: "O-o",
      meaning: "Yes",
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
    _initializeTTS();
  }

  // Initialize TTS settings
  Future<void> _initializeTTS() async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.9);
  }

  // Getters
  QuizCardModel get currentCard => quizCards[currentIndex.value];

  double get progress => quizCards.isEmpty
      ? 0
      : (currentIndex.value + 1) / quizCards.length;

  // Flip card
  void toggleFlip() {
    isFlipped.value = !isFlipped.value;
  }

  // Navigation
  void nextCard() {
    if (currentIndex.value < quizCards.length - 1) {
      if (isFlipped.value) {
        isFlipped.value = false;
      }
      currentIndex.value++;
      spokenText.value = ""; // Clear spoken text
    }
  }

  void previousCard() {
    if (currentIndex.value > 0) {
      if (isFlipped.value) {
        isFlipped.value = false;
      }
      currentIndex.value--;
      spokenText.value = ""; // Clear spoken text
    }
  }

  // Bookmark
  void toggleBookmark() {
    if (bookmarkedIndexes.contains(currentIndex.value)) {
      bookmarkedIndexes.remove(currentIndex.value);
    } else {
      bookmarkedIndexes.add(currentIndex.value);
    }
  }

  bool isBookmarked() {
    return bookmarkedIndexes.contains(currentIndex.value);
  }

  // Text-to-Speech
  Future<void> speakText() async {
    await tts.speak(currentCard.meaning);
  }

  // Speech-to-Text
  Future<void> startListening() async {
    bool available = await speech.initialize();

    if (available) {
      isListening.value = true;
      spokenText.value = "";

      speech.listen(
        onResult: (result) {
          spokenText.value = result.recognizedWords;

          if (result.finalResult) {
            stopListening();
            checkAnswer();
          }
        },
        listenFor: Duration(seconds: 10),
        pauseFor: Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        'Error',
        'Speech recognition not available',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void stopListening() {
    speech.stop();
    isListening.value = false;
  }

  // Check answer
  void checkAnswer() {
    if (isAnswerCorrect()) {
      Get.snackbar(
        '✅ Correct!',
        'Great job!',
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        colorText: Get.theme.colorScheme.onPrimaryContainer,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }

  bool isAnswerCorrect() {
    if (spokenText.value.isEmpty) return false;
    final correctAnswer = currentCard.meaning.toLowerCase().trim();
    final userAnswer = spokenText.value.toLowerCase().trim();
    return correctAnswer == userAnswer;
  }

  @override
  void onClose() {
    tts.stop();
    speech.stop();
    super.onClose();
  }
}