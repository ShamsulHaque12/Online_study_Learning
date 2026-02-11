
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_study/constraints/app_colors.dart';
import 'package:online_study/constraints/app_icons.dart';
import 'package:online_study/features/language/controller/language_controller.dart';
import 'package:online_study/features/peer_screens/controller/find_friend_controller.dart';
import 'package:online_study/route/app_routes.dart';
import 'package:online_study/theme/theme_change_controller.dart';
import 'package:share_plus/share_plus.dart';

class FindFriends extends StatelessWidget {
  FindFriends({super.key});

  final FindFriendController controller = Get.put(FindFriendController());
  final langController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark.value;

      return Scaffold(
        backgroundColor: isDark
            ? AppDarkColors.backgroundColor
            : AppLightColors.backgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Invite Link
                GestureDetector(
                  onTap: () {
                    Share.share(
                      "Download my app: https://play.google.com/store/apps/details?id=your.app",
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.link, height: 16.h),
                      SizedBox(width: 8.w),
                      Text(
                        "Copy invite link",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppLightColors.tealColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),

                /// Title
                Text(
                  langController.selectedLanguage["Invite Friends"] ??
                      "Invite Friends",
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                ),

                SizedBox(height: 12.h),

                /// 🔍 Search Box
                TextFormField(
                  controller: controller.searchController,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: isDark
                        ? AppDarkColors.primaryTextColor
                        : AppLightColors.primaryTextColor,
                  ),
                  onChanged: (value) {
                    controller.searchText.value = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Search friends",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: isDark
                          ? AppDarkColors.primaryColor
                          : AppLightColors.primaryColor,
                    ),

                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                /// Result
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: SpinKitCircle(color: Colors.orange, size: 40.h),
                    );
                  }

                  if (controller.friends.isEmpty &&
                      controller.searchText.value.isNotEmpty) {
                    return Center(
                      child: Text(
                        "No friends found",
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: isDark
                              ? AppDarkColors.primaryTextColor
                              : AppLightColors.primaryTextColor,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.friends.length,
                    itemBuilder: (context, index) {
                      final friend = controller.friends[index];

                      final String id = friend["id"]?.toString() ?? "";
                      final String name =
                          friend["fullName"]?.toString() ?? "Unknown";
                      final String? image = friend["image"];

                      return GestureDetector(
                        onTap: () {
                          if (id.isNotEmpty) {
                            // ✅ LOG
                            debugPrint("➡️ Passed Friend ID: $id");

                            Get.toNamed(
                              AppRoutes.searchFriendView,
                              arguments: id,
                            );
                          } else {
                            debugPrint("❌ Friend ID is empty");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            children: [
                              /// 👤 Profile Image
                              CircleAvatar(
                                radius: 22.r,
                                backgroundImage: NetworkImage(
                                  image ??
                                      "https://ui-avatars.com/api/?name=$name&background=0D8ABC&color=fff",
                                ),
                              ),

                              SizedBox(width: 12.w),

                              /// 👤 Name
                              Text(
                                name,
                                style: GoogleFonts.inter(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppDarkColors.primaryTextColor
                                      : AppLightColors.primaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      );
    });
  }
}
