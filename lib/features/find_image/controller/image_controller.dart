
import 'package:get/get.dart';
import 'package:online_study/features/find_image/model/image_options.dart';
import 'package:online_study/features/find_image/widgets/result_popup_screen.dart';

class ImageController extends GetxController {
  /// quiz state
  final RxInt currentQuestion = 0.obs;
  final RxInt selectedOption = (-1).obs;
  final RxBool isAnswered = false.obs;
  final RxInt score = 0.obs;

  /// QUESTIONS DATA
  /// =========================

  final List<ImageQuestion> multipleChoiceQuestions = [
    ImageQuestion(
      id: 1,
      question: "Nakakahiya",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593800/t2m8_3y6s_220831_k7qu3b.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Embarrassing", isCorrect: true),
        ImageOptions(id: 2, text: "Funny", isCorrect: false),
        ImageOptions(id: 3, text: "Sad", isCorrect: false),
        ImageOptions(id: 4, text: "Happy", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 2,
      question: "Masaya",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767595038/Screenshot_2026-01-05_123628_xnbyce.png",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Sad", isCorrect: false),
        ImageOptions(id: 2, text: "Happy", isCorrect: true),
        ImageOptions(id: 3, text: "Angry", isCorrect: false),
        ImageOptions(id: 4, text: "Tired", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 3,
      question: "Galit",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593782/0e723986-e9f3-446b-bc07-c4d128d4a8ca_ep06nv.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Happy", isCorrect: false),
        ImageOptions(id: 2, text: "Angry", isCorrect: true),
        ImageOptions(id: 3, text: "Sleepy", isCorrect: false),
        ImageOptions(id: 4, text: "Excited", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 4,
      question: "Malungkot",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593777/e960c7cf-9546-4a27-937a-31603dbc430c_tabccw.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Sad", isCorrect: true),
        ImageOptions(id: 2, text: "Happy", isCorrect: false),
        ImageOptions(id: 3, text: "Excited", isCorrect: false),
        ImageOptions(id: 4, text: "Calm", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 5,
      question: "Pagod",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593795/6ryl_a6ug_210816_arjslx.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Energetic", isCorrect: false),
        ImageOptions(id: 2, text: "Tired", isCorrect: true),
        ImageOptions(id: 3, text: "Happy", isCorrect: false),
        ImageOptions(id: 4, text: "Worried", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 6,
      question: "Takot",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593789/3k21_mu02_230512_djdpyu.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Brave", isCorrect: false),
        ImageOptions(id: 2, text: "Scared", isCorrect: true),
        ImageOptions(id: 3, text: "Calm", isCorrect: false),
        ImageOptions(id: 4, text: "Excited", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 7,
      question: "Sabik",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767420535/iz8d_qaz1_220621_h7ikbs.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Bored", isCorrect: false),
        ImageOptions(id: 2, text: "Eager", isCorrect: true),
        ImageOptions(id: 3, text: "Sleepy", isCorrect: false),
        ImageOptions(id: 4, text: "Angry", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 8,
      question: "Inaantok",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767419612/9082406_ucdw9m.jpg",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Sleepy", isCorrect: true),
        ImageOptions(id: 2, text: "Energetic", isCorrect: false),
        ImageOptions(id: 3, text: "Happy", isCorrect: false),
        ImageOptions(id: 4, text: "Angry", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 9,
      question: "Nalilito",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767343346/5_i5zjmc.png",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Clear", isCorrect: false),
        ImageOptions(id: 2, text: "Confused", isCorrect: true),
        ImageOptions(id: 3, text: "Happy", isCorrect: false),
        ImageOptions(id: 4, text: "Confident", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 10,
      question: "Nag-aalala",
      description: "Collect the answer",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767414211/cusin_cph8qh.png",
      type: QuestionType.multipleChoice,
      options: [
        ImageOptions(id: 1, text: "Relaxed", isCorrect: false),
        ImageOptions(id: 2, text: "Worried", isCorrect: true),
        ImageOptions(id: 3, text: "Excited", isCorrect: false),
        ImageOptions(id: 4, text: "Sleepy", isCorrect: false),
      ],
    ),
  ];

  final List<ImageQuestion> trueFalseQuestions = [
    ImageQuestion(
      id: 11,
      question: "'Nakakahiya' is used to describe a past action you did",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
      type: QuestionType.trueFalse,
      options: [
        ImageOptions(id: 1, text: "False", isCorrect: true),
        ImageOptions(id: 2, text: "True", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 12,
      question: "'Masaya' means someone is feeling happy",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
      type: QuestionType.trueFalse,
      options: [
        ImageOptions(id: 1, text: "False", isCorrect: false),
        ImageOptions(id: 2, text: "True", isCorrect: true),
      ],
    ),
    ImageQuestion(
      id: 13,
      question: "'Galit' describes a calm and peaceful emotion",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
      type: QuestionType.trueFalse,
      options: [
        ImageOptions(id: 1, text: "False", isCorrect: true),
        ImageOptions(id: 2, text: "True", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 14,
      question: "'Pagod' means feeling energetic and active",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
      type: QuestionType.trueFalse,
      options: [
        ImageOptions(id: 1, text: "False", isCorrect: true),
        ImageOptions(id: 2, text: "True", isCorrect: false),
      ],
    ),
    ImageQuestion(
      id: 15,
      question: "'Takot' is the feeling when you are afraid of something",
      imageUrl: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
      type: QuestionType.trueFalse,
      options: [
        ImageOptions(id: 1, text: "False", isCorrect: false),
        ImageOptions(id: 2, text: "True", isCorrect: true),
      ],
    ),
  ];

  /// Combined quiz list
  late final List<ImageQuestion> quizData = [
    ...multipleChoiceQuestions,
    ...trueFalseQuestions,
  ];

  ImageQuestion get currentQuestionModel => quizData[currentQuestion.value];


  /// LOGIC
  /// =========================

  ImageQuestion get current =>
      quizData[currentQuestion.value];

  bool get isMultipleChoice =>
      current.type == QuestionType.multipleChoice;

  bool get isTrueFalse =>
      current.type == QuestionType.trueFalse;

  void handleOptionClick(ImageOptions option) {
    if (isAnswered.value) return;

    selectedOption.value = option.id;
    isAnswered.value = true;

    if (option.isCorrect) {
      score.value++;
    }
  }

  void handleContinue() {
    if (currentQuestion.value < quizData.length - 1) {
      currentQuestion.value++;
      selectedOption.value = -1;
      isAnswered.value = false;
    } else {
      _showResultPopup();
    }
  }

  void _showResultPopup() {
    Get.dialog(
      ResultPopup(
        score: score.value,
        total: quizData.length,
        onTryAgain: resetQuiz,
      ),
      barrierDismissible: false,
    );
  }

  void resetQuiz() {
    currentQuestion.value = 0;
    selectedOption.value = -1;
    isAnswered.value = false;
    score.value = 0;
    Get.back();
  }
}
