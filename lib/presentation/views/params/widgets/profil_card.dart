import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/divider.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/profil/pages/profil.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class SettingProfilCard extends StatelessWidget {
  const SettingProfilCard({
    super.key,
    this.user,
  });
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final user = this.user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "param.profil_label".tr(),
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
                leading: CircleAvatar(
                  backgroundColor: AppTheme.lightPrimary,
                  radius: 25,
                  child: const HeroIcon(
                    HeroIcons.user,
                    color: mblack,
                  ),
                ),
                title: Text(
                  user.name,
                  style: AppTheme().stylish1(14, mgrey),
                ),
                subtitle: Text(
                  user.email,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return ProfilScreen(user: user);
                      },
                    ),
                  );
                },
                child: Container(
                  width: context.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      "param.see_profil".tr(),
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
