import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TotalPointCard extends StatelessWidget {
  final String title;
  final String pointText;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;

  const TotalPointCard({
    super.key,
    required this.title,
    required this.pointText,
    required this.iconPath,
    required this.backgroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final cardWidth = size.width * 0.27;
    final cardHeight = size.height * 0.11;
    final innerHeight = cardHeight * 0.5;

    return Container(
      height: cardHeight,
      width: cardWidth,
      padding: EdgeInsets.all(cardWidth * 0.08),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cardWidth * 0.18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: cardWidth * 0.14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),

          Container(
            height: innerHeight,
            width: cardWidth * 0.8,
            padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(cardWidth * 0.12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath, height: innerHeight * 0.45),
                SizedBox(width: cardWidth * 0.04),
                Text(
                  pointText,
                  style: TextStyle(
                    fontSize: cardWidth * 0.13,
                    fontWeight: FontWeight.bold,
                    color: backgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
