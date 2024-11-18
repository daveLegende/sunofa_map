import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
// import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/gestion_pin_adresse.dart';
import '../widgets/logout_button.dart';
import '../widgets/user_info.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
            // routeNamed: Routes.home2,
            ),
        title: Text(
          "Profil",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppTheme.complementaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.complementaryColor,
                  width: 1,
                ),
              ),
              child: const HeroIcon(
                HeroIcons.power,
                color: mwhite,
                size: 20,
              ),
            ),
          ),
          SizedBox(
            width: context.widthPercent(2),
          ),
        ],
      ),
      body: Container(
        height: context.height,
        color: AppTheme.lightGray,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          child: Image.asset(
                            "assets/logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: AppTheme.primaryColor,
                            child: HeroIcon(
                              HeroIcons.camera,
                              color: mwhite,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const UserInfos(),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gestions",
                      style: TextStyle(
                        color: mgrey,
                        fontSize: 14,
                      ),
                    ),
                    Column(
                      children: [
                        GestionPinAdresse(
                          leading: HeroIcons.mapPin,
                          title: "Gestion de code PIN",
                          onTap: () {
                            Navigator.pushNamed(context, Routes.pinScreen);
                          },
                        ),
                        const SizedBox(height: 20),
                        GestionPinAdresse(
                          leading: HeroIcons.bookmark,
                          title: "Gestion d'adresse",
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.gestionAdresseScreen);
                          },
                        ),
                        const SizedBox(height: 20),
                        GestionPinAdresse(
                          leading: HeroIcons.document,
                          title: "Mes Notes",
                          onTap: () {
                            Navigator.pushNamed(context, Routes.notesScreen);
                          },
                        ),
                        const SizedBox(height: 30),
                        LogoutButton(
                          onTap: () {},
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingListTileItem extends StatelessWidget {
  const SettingListTileItem({
    super.key,
    required this.title,
    required this.leading,
    this.titleColor = mblack,
    this.leadingColor = mblack,
    this.isBold = false,
  });
  final String title;
  final HeroIcons leading;
  final Color? titleColor, leadingColor;
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
      ],
    );
  }
}
