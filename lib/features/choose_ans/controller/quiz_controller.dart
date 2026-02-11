import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:online_study/features/choose_ans/model/quiz_option.dart';

class QuizController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();

  final RxInt currentQuestion = 0.obs;
  final RxInt selectedOption = (-1).obs;
  final RxBool isAnswered = false.obs;
  final RxInt score = 0.obs;
  final RxBool showResult = false.obs;

  final List<QuizQuestion> quizData = [
    QuizQuestion(
      id: 1,
      question: "Family",
      audioText: "Family",
      options: [
        QuizOption(
          id: 1,
          text: "Mag-anak",
          emoji:
              "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744734/family_ymvhi5.png",
          isCorrect: true,
        ),
        QuizOption(
          id: 2,
          text: "Nanay",
          emoji:
              "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744734/family_ymvhi5.png",
          isCorrect: false,
        ),
        QuizOption(
          id: 3,
          text: "Tatay",
          emoji:
              "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744734/family_ymvhi5.png",
          isCorrect: false,
        ),
        QuizOption(
          id: 4,
          text: "Anak Na Babae",
          emoji:
              "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744734/family_ymvhi5.png",
          isCorrect: false,
        ),
      ],
    ),
    QuizQuestion(
      id: 2,
      question: "Mother",
      audioText: "Mother",
      options: [
        QuizOption(id: 1, text: "Tatay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/mother_wysowe.png", isCorrect: false),
        QuizOption(id: 2, text: "Nanay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/mother_wysowe.png", isCorrect: true),
        QuizOption(id: 3, text: "Anak", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/mother_wysowe.png", isCorrect: false),
        QuizOption(id: 4, text: "Lolo", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/mother_wysowe.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 3,
      question: "Father",
      audioText: "Father",
      options: [
        QuizOption(id: 1, text: "Nanay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/father_vlaiu2.png", isCorrect: false),
        QuizOption(id: 2, text: "Tatay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/father_vlaiu2.png", isCorrect: true),
        QuizOption(id: 3, text: "Kapatid", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/father_vlaiu2.png", isCorrect: false),
        QuizOption(id: 4, text: "Lola", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/father_vlaiu2.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 4,
      question: "Brother",
      audioText: "Brother",
      options: [
        QuizOption(id: 1, text: "Ate", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/son_ogi5ug.png", isCorrect: false),
        QuizOption(id: 2, text: "Kuya", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/son_ogi5ug.png", isCorrect: true),
        QuizOption(id: 3, text: "Bunso", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/son_ogi5ug.png", isCorrect: false),
        QuizOption(id: 4, text: "Pinsan", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/son_ogi5ug.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 5,
      question: "Sister",
      audioText: "Sister",
      options: [
        QuizOption(id: 1, text: "Kuya", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/daughter_vqn9ht.png", isCorrect: false),
        QuizOption(id: 2, text: "Tatay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/daughter_vqn9ht.png", isCorrect: false),
        QuizOption(id: 3, text: "Ate", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/daughter_vqn9ht.png", isCorrect: true),
        QuizOption(id: 4, text: "Tito", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1766744733/daughter_vqn9ht.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 6,
      question: "Grandmother",
      audioText: "Grandmother",
      options: [
        QuizOption(id: 1, text: "Lola", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329777/gradm_gihkog.png", isCorrect: true),
        QuizOption(id: 2, text: "Lolo", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329777/gradm_gihkog.png", isCorrect: false),
        QuizOption(id: 3, text: "Tita", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329777/gradm_gihkog.png", isCorrect: false),
        QuizOption(id: 4, text: "Nanay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329777/gradm_gihkog.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 7,
      question: "Grandfather",
      audioText: "Grandfather",
      options: [
        QuizOption(id: 1, text: "Tito", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329776/grand_xabez2.png", isCorrect: false),
        QuizOption(id: 2, text: "Lolo", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329776/grand_xabez2.png", isCorrect: true),
        QuizOption(id: 3, text: "Tatay", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329776/grand_xabez2.png", isCorrect: false),
        QuizOption(id: 4, text: "Lola", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767329776/grand_xabez2.png", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 8,
      question: "Son",
      audioText: "Son",
      options: [
        QuizOption(id: 1, text: "Anak na Lalaki", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767419612/9082406_ucdw9m.jpg", isCorrect: true),
        QuizOption(id: 2, text: "Anak na Babae", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767419612/9082406_ucdw9m.jpg", isCorrect: false),
        QuizOption(id: 3, text: "Pamangkin", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767419612/9082406_ucdw9m.jpg", isCorrect: false),
        QuizOption(id: 4, text: "Kapatid", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767419612/9082406_ucdw9m.jpg", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 9,
      question: "Daughter",
      audioText: "Daughter",
      options: [
        QuizOption(
          id: 1,
          text: "Anak na Lalaki",
          emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593800/t2m8_3y6s_220831_k7qu3b.jpg",
          isCorrect: false,
        ),
        QuizOption(id: 2, text: "Anak na Babae", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593800/t2m8_3y6s_220831_k7qu3b.jpg", isCorrect: true),
        QuizOption(id: 3, text: "Ate", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593800/t2m8_3y6s_220831_k7qu3b.jpg", isCorrect: false),
        QuizOption(id: 4, text: "Pinsan", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767593800/t2m8_3y6s_220831_k7qu3b.jpg", isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: 10,
      question: "Children",
      audioText: "Children",
      options: [
        QuizOption(id: 1, text: "Mga Bata", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png", isCorrect: true),
        QuizOption(
          id: 2,
          text: "Magulang",
          emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
          isCorrect: false,
        ),
        QuizOption(
          id: 3,
          text: "Pamilya",
          emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png",
          isCorrect: false,
        ),
        QuizOption(id: 4, text: "Kapatid", emoji: "https://res.cloudinary.com/dqqcg0kbd/image/upload/v1767415518/Screenshot_2026-01-03_104446_kpejjo.png", isCorrect: false),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    flutterTts.setLanguage("en-US");
  }

  void handleOptionClick(QuizOption option) {
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
      showResult.value = true;
    }
  }

  Future<void> playAudio(String text) async {
    await flutterTts.speak(text);
  }

  void resetQuiz() {
    currentQuestion.value = 0;
    selectedOption.value = -1;
    isAnswered.value = false;
    score.value = 0;
    showResult.value = false;
  }

  QuizQuestion getCurrentQuestion() {
    return quizData[currentQuestion.value];
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
}
