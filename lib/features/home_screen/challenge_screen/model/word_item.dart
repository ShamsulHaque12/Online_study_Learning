import 'dart:ui';

class WordItem {
  String text;
  bool isLocked;
  Color? bgColor;

  WordItem({
    required this.text,
    this.isLocked = false,
    this.bgColor,
  });
}
