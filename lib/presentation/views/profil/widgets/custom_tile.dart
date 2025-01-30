import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';

class ProfileCustomListTile extends StatelessWidget {
  const ProfileCustomListTile({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor = mblack,
    this.labelColor = mblack,
    this.onTap,
  });
  final HeroIcons icon;
  final String label;
  final Color? iconColor, labelColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                HeroIcon(
                  icon,
                  color: iconColor,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(fontSize: 16, color: labelColor),
                ),
              ],
            ),
          ),
        ),
        const CustomDivider(),
      ],
    );
  }
}
