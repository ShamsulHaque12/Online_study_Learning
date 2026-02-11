import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:online_study/features/listen_choose/model/quiz_model.dart';

class ListenQuizController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();
  
  // Observable variables
  final currentQuestionIndex = 0.obs;
  final selectedAnswer = Rxn<int>();
  final showFeedback = false.obs;
  final score = 0.obs;
  final quizCompleted = false.obs;

  // Quiz data
  final List<QuizModel> quizData = [
    QuizModel(
      id: 1,
      audioText: "Kinakabahan ako sa exam",
      options: [
        AnswerOption(text: "Kinakabahan ako sa exam", isCorrect: true),
        AnswerOption(text: "Nakakatakot ang bagyo kagabi", isCorrect: false),
      ],
    ),
    QuizModel(
      id: 2,
      audioText: "Naiinip ako sa pila",
      options: [
        AnswerOption(text: "Umiinom ako ng tubig", isCorrect: false),
        AnswerOption(text: "Naiinip ako sa pila", isCorrect: true),
      ],
    ),
    QuizModel(
      id: 3,
      audioText: "Maganda ang panahon ngayon",
      options: [
        AnswerOption(text: "Maganda ang panahon ngayon", isCorrect: true),
        AnswerOption(text: "Maulan ang panahon ngayon", isCorrect: false),
      ],
    ),
    QuizModel(
      id: 4,
      audioText: "Naiinis ako sa ingay",
      options: [
        AnswerOption(text: "Bumili ako ng sapatos", isCorrect: false),
        AnswerOption(text: "Naiinis ako sa ingay", isCorrect: true),
      ],
    ),
    QuizModel(
      id: 5,
      audioText: "Naglalaro ang mga bata",
      options: [
        AnswerOption(text: "Naglalaro ang mga bata", isCorrect: true),
        AnswerOption(text: "Natutulog ang mga bata", isCorrect: false),
      ],
    ),
    QuizModel(
      id: 6,
      audioText: "Naiiyak ako sa palabas",
      options: [
        AnswerOption(text: "Malungkot ang piyesta kahapon", isCorrect: false),
        AnswerOption(text: "Naiiyak ako sa palabas", isCorrect: true),
      ],
    ),
    QuizModel(
      id: 7,
      audioText: "Pumunta kami sa palengke",
      options: [
        AnswerOption(text: "Pumunta kami sa palengke", isCorrect: true),
        AnswerOption(text: "Pumunta kami sa simbahan", isCorrect: false),
      ],
    ),
    QuizModel(
      id: 8,
      audioText: "Mainit ang kape ko",
      options: [
        AnswerOption(text: "Malamig ang kape ko", isCorrect: false),
        AnswerOption(text: "Mainit ang kape ko", isCorrect: true),
      ],
    ),
    QuizModel(
      id: 9,
      audioText: "Nalulungkot ako kapag mag-isa",
      options: [
        AnswerOption(text: "Nalulungkot ako kapag mag-isa", isCorrect: true),
        AnswerOption(text: "Kumakanta sila sa entablado", isCorrect: false),
      ],
    ),
    QuizModel(
      id: 10,
      audioText: "Mabait ang guro namin",
      options: [
        AnswerOption(text: "Masungit ang guro namin", isCorrect: false),
        AnswerOption(text: "Mabait ang guro namin", isCorrect: true),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("fil-PH");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
  }

  QuizModel get currentQuiz => quizData[currentQuestionIndex.value];

  double get progress => (currentQuestionIndex.value + 1) / quizData.length;

  void playAudio() async {
    await flutterTts.speak(currentQuiz.audioText);
  }

  void selectAnswer(int index) {
    if (showFeedback.value) return;
    selectedAnswer.value = index;
  }

  void handleContinue() {
    if (selectedAnswer.value == null) return;

    final isCorrect = currentQuiz.options[selectedAnswer.value!].isCorrect;

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
      showFeedback.value = false;
    } else {
      quizCompleted.value = true;
    }
  }

  void restartQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswer.value = null;
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