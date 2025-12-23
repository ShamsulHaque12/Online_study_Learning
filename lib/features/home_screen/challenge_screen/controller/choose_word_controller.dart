import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colours.dart';
import '../model/choose_word.dart';

class ChooseWordController extends GetxController {
  final int totalScreens = 3;

  RxInt currentScreen = 0.obs;
  RxInt selectedIndex = (-1).obs;
  RxBool isChecked = false.obs;
  RxString buttonText = "Check".obs;
  RxString displayText = "Select".obs;

  // QUIZ DATA LIST
  List<QuizModel> quizList = [
    QuizModel(
      correctIndex: 0,
      options: [
        OptionModel(title: "Mag-anak", image: "assets/images/family.png"),
        OptionModel(title: "Nanay", image: "assets/images/family.png"),
        OptionModel(title: "Tatay", image: "assets/images/family.png"),
        OptionModel(title: "Anak na Babae", image: "assets/images/family.png"),
      ],
    ),
    QuizModel(
      correctIndex: 2,
      options: [
        OptionModel(title: "Boy", image: "assets/images/family.png"),
        OptionModel(title: "Girl", image: "assets/images/family.png"),
        OptionModel(title: "Father", image: "assets/images/family.png"),
        OptionModel(title: "Mother", image: "assets/images/family.png"),
      ],
    ),
    QuizModel(
      correctIndex: 1,
      options: [
        OptionModel(title: "Car", image: "assets/images/family.png"),
        OptionModel(title: "Bike", image: "assets/images/family.png"),
        OptionModel(title: "Bus", image: "assets/images/family.png"),
        OptionModel(title: "Train", image: "assets/images/family.png"),
      ],
    ),
  ];

  QuizModel get currentQuiz => quizList[currentScreen.value];

  // Select Option
  void selectOption(int index) {
    if (!isChecked.value) {
      selectedIndex.value = index;
      displayText.value = currentQuiz.options[index].title;
    }
  }

  // Check Answer
  void checkAnswer() {
    if (selectedIndex.value == -1) return;

    isChecked.value = true;
    buttonText.value = "Continue";
  }

  // Continue Next Screen
  void nextScreen() {
    if (currentScreen.value < totalScreens - 1) {
      selectedIndex.value = -1;
      isChecked.value = false;
      buttonText.value = "Check";
      displayText.value = "Select";
      currentScreen.value++;
    } else {
      buttonText.value = "Finish";
    }
  }
}

// OPTION COLOR LOGIC
Color getOptionColor(int index, ChooseWordController c) {
  int correctIndex = c.currentQuiz.correctIndex;

  if (!c.isChecked.value) {
    return c.selectedIndex.value == index
        ? AppColors.checkColor
        : Colors.white;
  }

  if (index == correctIndex) return AppColors.correctColor;

  if (c.selectedIndex.value == index && index != correctIndex) {
    return AppColors.wrongColor;
  }

  return Colors.white;
}
