import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppTheme.complementaryColor,
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
                    color: mwhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const HeroIcon(
                    HeroIcons.power,
                    color: AppTheme.complementaryColor,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  "Se Déconnecter",
                  style: AppTheme().stylish1(15, mwhite),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: mwhite,
            ),
          ],
        ),
      ),
    );
  }
}