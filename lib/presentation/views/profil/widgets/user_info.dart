import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';

import '../pages/profil.dart';

class UserInfos extends StatelessWidget {
  const UserInfos({
    super.key, required this.user,
  });
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informations",
          style: TextStyle(
            color: mgrey,
            fontSize: 14,
          ),
        ),
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
              SettingListTileItem(
                title: user.name,
                leading: HeroIcons.user,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              SettingListTileItem(
                title: user.email,
                leading: HeroIcons.envelope,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              SettingListTileItem(
                title: user.phoneNumber,
                leading: HeroIcons.phone,
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: const Center(
                  child: CustomDivider(),
                ),
              ),
              const SettingListTileItem(
                title: "Code PIN...",
                leading: HeroIcons.codeBracket,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
