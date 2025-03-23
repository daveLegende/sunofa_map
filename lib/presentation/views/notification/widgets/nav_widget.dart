import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({
    super.key,
    required this.color,
    required this.text,
    required this.tcolor,
  });

  final Color color, tcolor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTheme().stylish1(
            15,
            tcolor,
            isBold: true,
          ),
        ),
      ),
    );
  }
}
