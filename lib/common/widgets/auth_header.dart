import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme().stylish1(
              25,
              AppTheme.primaryColor,
              isBold: true,
            ),
          ),
          Text(
            desc,
            style: AppTheme().stylish1(16, mgrey),
          ),
        ],
      ),
    );
  }
}
