import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class ButtonBorderContainer extends StatelessWidget {
  const ButtonBorderContainer({
    super.key,
    required this.text,
    required this.color,
    required this.width,
    this.onTap,
  });
  final String text;
  final Color color;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTheme().stylish1(
              14,
              mwhite,
            ),
          ),
        ),
      ),
    );
  }
}
