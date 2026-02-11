
import 'package:online_study/features/choose_word/model/word_pair.dart';

class QuestionsData {
  static List<MatchingQuestion> getAllQuestions() {
    return [
      // Screen 1 - Greetings
      MatchingQuestion(
        correctPairs: [
          WordPair(english: "Good Morning", filipino: "Magandang umaga"),
          WordPair(english: "Good Afternoon", filipino: "Magandang hapon"),
          WordPair(english: "Good Evening", filipino: "Magandang gabi"),
          WordPair(english: "Good Bye", filipino: "Paalam"),
          WordPair(english: "I'm fine", filipino: "Mabuti naman"),
          WordPair(english: "Thank you", filipino: "Salamat"),
        ],
      ),
      // Screen 2 - Family
      MatchingQuestion(
        correctPairs: [
          WordPair(english: "Father", filipino: "Ama"),
          WordPair(english: "Mother", filipino: "Ina"),
          WordPair(english: "Brother", filipino: "Kapatid na lalaki"),
          WordPair(english: "Sister", filipino: "Kapatid na babae"),
          WordPair(english: "Grandfather", filipino: "Lolo"),
          WordPair(english: "Grandmother", filipino: "Lola"),
        ],
      ),
      // Screen 3 - Numbers
      MatchingQuestion(
        correctPairs: [
          WordPair(english: "One", filipino: "Isa"),
          WordPair(english: "Two", filipino: "Dalawa"),
          WordPair(english: "Three", filipino: "Tatlo"),
          WordPair(english: "Four", filipino: "Apat"),
          WordPair(english: "Five", filipino: "Lima"),
          WordPair(english: "Six", filipino: "Anim"),
        ],
      ),
      // Screen 4 - Colors
      MatchingQuestion(
        correctPairs: [
          WordPair(english: "Red", filipino: "Pula"),
          WordPair(english: "Blue", filipino: "Asul"),
          WordPair(english: "Green", filipino: "Berde"),
          WordPair(english: "Yellow", filipino: "Dilaw"),
          WordPair(english: "White", filipino: "Puti"),
          WordPair(english: "Black", filipino: "Itim"),
        ],
      ),
      // Screen 5 - Food
      MatchingQuestion(
        correctPairs: [
          WordPair(english: "Rice", filipino: "Kanin"),
          WordPair(english: "Water", filipino: "Tubig"),
          WordPair(english: "Bread", filipino: "Tinapay"),
          WordPair(english: "Egg", filipino: "Itlog"),
          WordPair(english: "Fish", filipino: "Isda"),
          WordPair(english: "Chicken", filipino: "Manok"),
        ],
      ),
    ];
  }
}