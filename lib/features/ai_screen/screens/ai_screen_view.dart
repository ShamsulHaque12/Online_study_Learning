import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../component/custom_widgets/featured_card.dart';
import '../../../core/app_colours.dart';
import '../../../core/app_icons.dart';
import '../../../core/app_images.dart';
import '../controller/ai_screen_controller.dart';
import '../widget/ai_dictionary/screens/ai_dictionary_screen.dart';
import '../widget/ai_role/screens/ai_role_play_screen.dart';
import '../widget/camera_screen/screens/camera_screen.dart';
import '../widget/dialogue_screen/screens/dialogue_builder_screen.dart';
import '../widget/flash_screen/screen/flashcard_screen.dart';
import '../widget/lisiting_drill/screen/listening_drill_screen.dart';
import '../widget/role_play_simulation/screens/roleplay_simulation_screen.dart';
import '../widget/short_stories/screens/short_stories_screen.dart';
import '../widget/writing_practice/screens/writing_practice_screen.dart';

class AiScreenView extends StatelessWidget {
  final AiScreenController controller = Get.put(AiScreenController());

  AiScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,

      appBar: AppBar(
        backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Image.network('https://flagcdn.com/w80/gb.png'),
        ),
        actions: [
          SvgPicture.asset(AppIcons.agun, height: 22.h),
          SizedBox(width: 5.w),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(AppIcons.egg, height: 22.h),
          SizedBox(width: 5.w),
          Text(
            "2",
            style: TextStyle(
              fontSize: 16.sp,
              color: isDark ? Colors.white : AppColors.lightText,
            ),
          ),
          SizedBox(width: 20.w),
          SvgPicture.asset(
            AppIcons.notification,
            height: 20.h,
            color: isDark ? Colors.white : AppColors.lightText,
          ),
          SizedBox(width: 10.w),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: AssetImage(AppImages.putul),
          ),
          SizedBox(width: 10.w),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double spacing = 10.w;
                double cardWidth = (constraints.maxWidth - spacing) / 2;

                List<FeatureCard> cards = [
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.flash,
                    title: "Flashcards",
                    subtitle: "Review vocabulary with smart AI-powered flashcards",
                    level: "Beginner",
                    duration: "10 min",
                    xp: "+15 XP",
                    navigateTo: FlashcardScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.role,
                    title: "AI Role-Play",
                    subtitle: "Practice conversations with AI in real scenarios",
                    level: "Intermediate",
                    duration: "15 min",
                    xp: "+20 XP",
                    navigateTo: AiRolePlayScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.lisin,
                    title: "Listening Drill",
                    subtitle: "Improve comprehension with native audio",
                    level: "Beginner",
                    duration: "10 min",
                    xp: "+15 XP",
                    navigateTo: ListeningDrillScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.edit,
                    title: "Writing Practice",
                    subtitle: "Write sentences and get AI feedback",
                    level: "Intermediate",
                    duration: "15 min",
                    xp: "+20 XP",
                    navigateTo: WritingPracticeScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.cemara,
                    title: "Camera",
                    subtitle: "Point learn object",
                    level: "Beginner",
                    duration: "10 min",
                    xp: "+15 XP",
                    navigateTo: CameraScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.dictionary,
                    title: "AI Dictionary",
                    subtitle: "Translate & learn with examples",
                    level: "Intermediate",
                    duration: "15 min",
                    xp: "+20 XP",
                    navigateTo: AiDictionaryScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.cemara,
                    title: "Short Stories",
                    subtitle: "Read & practice with mini narratives",
                    level: "Beginner",
                    duration: "10 min",
                    xp: "+15 XP",
                    navigateTo: ShortStoriesScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.role,
                    title: "Dialogue Builder",
                    subtitle: "Arrange conversation bubbles in correct order",
                    level: "Intermediate",
                    duration: "15 min",
                    xp: "+20 XP",
                    navigateTo: DialogueBuilderScreen(),
                  ),
                  FeatureCard(
                    isDark: isDark,
                    icon: AppIcons.simul,
                    title: "Roleplay Simulation",
                    subtitle: "Arrange conversation bubbles in correct order",
                    level: "Advanced",
                    duration: "10 min",
                    xp: "+15 XP",
                    navigateTo: RoleplaySimulationScreen(),
                  ),
                ];

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: cards.map((card) {
                    return SizedBox(
                      width: cardWidth,
                      child: card,
                    );
                  }).toList(),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
