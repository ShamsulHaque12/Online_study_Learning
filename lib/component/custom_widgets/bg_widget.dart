import 'package:flutter/material.dart';

class BgWidget extends StatelessWidget {
  final Widget child;

  const BgWidget({
    super.key,
    required this.child,
  });

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
                  ? "assets/images/splashdark.png"
                  : "assets/images/splashlight.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
