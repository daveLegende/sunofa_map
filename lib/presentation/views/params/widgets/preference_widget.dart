import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';

import 'setting_listile.dart';

class SettingPreference extends StatelessWidget {
  const SettingPreference({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Préférences",
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
                title: "Langues",
                trailing: "Français",
                leading: HeroIcons.language,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Notifications",
                trailing: "Active",
                leading: HeroIcons.bell,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Thèmes",
                trailing: "Clair",
                leading: HeroIcons.paintBrush,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
