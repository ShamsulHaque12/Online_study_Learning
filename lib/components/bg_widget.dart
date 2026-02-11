import 'package:flutter/material.dart';
import 'package:online_study/constraints/app_images.dart';

class BgWidget extends StatelessWidget {
  final Widget child;

  const BgWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? AppImages.splashDark
                  : AppImages.splashLight,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
