

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class GestionPinAdresse extends StatelessWidget {
  const GestionPinAdresse({
    super.key,
    required this.leading,
    required this.title,
    this.titleColor = mgrey,
    this.leadingColor = AppTheme.lightGray,
    this.iconColor = mblack,
    this.onTap,
  });
  final HeroIcons leading;
  final String title;
  final Color? titleColor, leadingColor, iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: leadingColor!,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: HeroIcon(
                      leading,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: AppTheme().stylish1(15, mgrey),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: mgrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}