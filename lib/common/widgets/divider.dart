import 'package:flutter/material.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppTheme.lightGray,
    );
  }
}