import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/app_colours.dart';
import '../controller/follower_controller.dart';

class FollowerScreen extends StatelessWidget {
  final FollowerController controller = Get.put(FollowerController());
  FollowerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.followers.isEmpty) {
          return const Center(child: Text("No followers found"));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: controller.followers.length,
            itemBuilder: (context, index) {
              final follower = controller.followers[index];
              return Card(
                color: isDark ? AppColors.bgDark : AppColors.bgLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                    color: isDark ? Colors.white : Colors.grey,
                    width: 1,
                  )
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(follower.image),
                  ),
                  title: Text(
                    follower.tittle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    follower.subtile,
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        follower.flag,
                        width: 25,
                        height: 20,
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset(
                        follower.icone,
                        width: 20,
                        height: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                  onTap: () {
                    // Optional: click event
                    print("${follower.tittle} tapped");
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
