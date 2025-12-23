import 'package:flutter/material.dart';

import '../../../core/app_colours.dart';

class GroupChat extends StatelessWidget {
  const GroupChat({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Group Chat")
          ],
        ),
      ),
    );
  }
}
