
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'setting_listile.dart';

class SettingOthers extends StatelessWidget {
  const SettingOthers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Autres",
          style: TextStyle(
            fontSize: 14,
            color: mgrey,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: mwhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const SettingListTileItem(
                title: "Condition d'utilisation",
                trailing: "",
                leading: HeroIcons.documentText,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Politique de confidentialité",
                trailing: "",
                leading: HeroIcons.shieldCheck,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Directives de la communauté",
                trailing: "",
                leading: HeroIcons.userGroup,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Support",
                trailing: "",
                leading: HeroIcons.lifebuoy,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Se deconnecter",
                trailing: "",
                leading: HeroIcons.power,
                titleColor: AppTheme.complementaryColor,
                trailingColor: AppTheme.complementaryColor,
                leadingColor: AppTheme.complementaryColor,
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
