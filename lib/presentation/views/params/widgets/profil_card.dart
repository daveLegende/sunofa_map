import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SettingProfilCard extends StatelessWidget {
  const SettingProfilCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mon Profil",
          style: TextStyle(
            fontSize: 14,
            color: mgrey,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: mwhite,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 25,
                  child: HeroIcon(HeroIcons.user),
                ),
                title: Text(
                  "first name of user",
                  style: AppTheme().stylish1(14, mgrey),
                ),
                subtitle: Text(
                  "monmailgmail.com",
                  style: AppTheme().stylish1(12, mgrey),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const CustomDivider(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profilScreen);
                },
                child: Container(
                  width: context.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      "Voir mon profil",
                      style: AppTheme().stylish1(
                        15,
                        AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
