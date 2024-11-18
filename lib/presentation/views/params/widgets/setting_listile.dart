
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SettingListTileItem extends StatelessWidget {
  const SettingListTileItem({
    super.key,
    required this.title,
    required this.trailing,
    required this.leading,
    this.titleColor = mblack,
    this.trailingColor = mgrey,
    this.leadingColor = mblack,
    this.isBold = false,
  });
  final String title, trailing;
  final HeroIcons leading;
  final Color? titleColor, trailingColor, leadingColor;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(20),
              ),
              child: HeroIcon(
                leading,
                color: leadingColor,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: AppTheme().stylish1(
                14,
                titleColor!,
                isBold: isBold!,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              trailing,
              style: AppTheme().stylish1(12, mgrey),
            ),
            const SizedBox(width: 5),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: trailingColor!,
            ),
          ],
        ),
      ],
    );
  }
}
