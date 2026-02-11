import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:online_study/theme/theme_change_controller.dart';

class Tier2DetailsScreen extends StatelessWidget {
  final String tittle;
  const Tier2DetailsScreen({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final isDark = themeController.isDark.value;
    return Scaffold(appBar: AppBar(title: Text('Tier 2 Details')));
  }
}
