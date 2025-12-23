import 'package:get/get.dart';

import '../../../core/app_colours.dart';

class HomeScreenController extends GetxController {
  var selectedTab = 0.obs;
  var isSubscriber = false.obs;

  var chapters = [
    {
      'title': 'Chapter 1 (Beginner A1)',
      'subtitle': 'Introduction of  Tagalog',
      'progress': 0,
      'color': AppColors.btnBG,
      'items': [
        {
          'title': 'Essential Greetings',
          'isLocked': false,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Self Introductions',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Belongings',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Family & Relationships',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Basic Likes and Dislike',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Expressing Gratitude and Apologies',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Challenge',
          'isLocked': false,
          'isChallenge': true,
          'completed': false,
        },
      ],
    },
    {
      'title': 'Chapter 2 (A1 → A2)',
      'subtitle': 'Action, Time and Place',
      'progress': 0,
      'color': AppColors.ch2,
      'items': [
        {
          'title': 'Places and Locations',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Basic Feelings',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Expressing Affection (Advanced Edition)',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Expressing Surprises and Reactions',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Time and Telling Time',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Months of the Year',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Days of the Week',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Challenge',
          'isLocked': false,
          'isChallenge': true,
          'completed': false,
        },
      ],
    },
    {
      'title': 'Chapter 3 (A2 → B1)',
      'subtitle': 'Family and Relationships',
      'progress': 0,
      'color': AppColors.ch3,
      'items': [
        {
          'title': 'Identify family members',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Use possessive pronouns correctly',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Introduce other people',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Challenge',
          'isLocked': false,
          'isChallenge': true,
          'completed': false,
        },
      ],
    },
    {
      'title': 'Chapter 4 (B1 → B2)',
      'subtitle': 'Expressing Gratitude and Apologies',
      'progress': 0,
      'color': AppColors.ch4,
      'items': [
        {
          'title': 'Express gratitude appropriately.',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Apologize formally or casually',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Understand cultural values',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Challenge',
          'isLocked': false,
          'isChallenge': true,
          'completed': false,
        },
      ],
    },
    // {
    //   'title': 'Chapter 5 (B1 → B2)',
    //   'subtitle': 'Expressing Gratitude and Apologies',
    //   'progress': 0,
    //   'color': AppColors.ch4,
    //   'items': [
    //     {
    //       'title': 'Time and Telling Time',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Apologize formally or casually',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Understand cultural values',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Challenge',
    //       'isLocked': false,
    //       'isChallenge': true,
    //       'completed': false,
    //     },
    //   ],
    // },
    // {
    //   'title': 'Chapter 6 (B1 → B2)',
    //   'subtitle': 'Expressing Gratitude and Apologies',
    //   'progress': 0,
    //   'color': AppColors.ch4,
    //   'items': [
    //     {
    //       'title': 'Months of the Year',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Apologize formally or casually',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Understand cultural values',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Challenge',
    //       'isLocked': false,
    //       'isChallenge': true,
    //       'completed': false,
    //     },
    //   ],
    // },
    // {
    //   'title': 'Chapter 7 (B1 → B2)',
    //   'subtitle': 'Expressing Gratitude and Apologies',
    //   'progress': 0,
    //   'color': AppColors.ch4,
    //   'items': [
    //     {
    //       'title': 'Days of the Week',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Apologize formally or casually',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Understand cultural values',
    //       'isLocked': true,
    //       'isChallenge': false,
    //       'completed': false,
    //     },
    //     {
    //       'title': 'Challenge',
    //       'isLocked': false,
    //       'isChallenge': true,
    //       'completed': false,
    //     },
    //   ],
    // },

    {
      'title': 'Grammar',
      'subtitle': 'Introduction of English',
      'progress': 0,
      'color': AppColors.grammer,
      'items': [
        {
          'title': 'Verb.',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Adjective',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Parts of Speech',
          'isLocked': true,
          'isChallenge': false,
          'completed': false,
        },
        {
          'title': 'Challenge',
          'isLocked': false,
          'isChallenge': true,
          'completed': false,
        },
      ],
    },
  ].obs;

  /// Complete a lesson
  void completeLesson(int chapterIndex, int lessonIndex) {
    var chapter = chapters[chapterIndex];
    var item =
        (chapter['items'] as List<Object>)[lessonIndex] as Map<String, Object>;
    if (item['isLocked'] as bool && !isSubscriber.value) return;

    item['completed'] = true;

    // Unlock next item only if subscriber
    if (isSubscriber.value) {
      var items = chapter['items'] as List;
      if (lessonIndex + 1 < items.length) {
        var nextItem = items[lessonIndex + 1] as Map;
        if (!nextItem['isChallenge']) {
          nextItem['isLocked'] = false;
        }
      }
    }

    // Update chapter progress
    _updateChapterProgress(chapterIndex);

    chapters.refresh();
  }

  void _updateChapterProgress(int chapterIndex) {
    var chapter = chapters[chapterIndex];
    var items = chapter['items'] as List;
    int completedCount = items.where((i) => i['completed'] == true).length;
    chapter['progress'] = ((completedCount / items.length) * 100).toInt();
  }
}
