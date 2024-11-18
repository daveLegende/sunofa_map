import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.text,
    this.onTap,
  });
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppTheme.primaryColor,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 15,
          ),
          child: Center(
            child: Text(
              text,
              style: AppTheme().stylish1(
                16,
                AppTheme.white,
                isBold: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
