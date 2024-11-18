import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mwhite,
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Notifications",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: ListView.builder(
        itemCount: 2,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, i) {
          return Container(
            height: context.width * .6,
            margin: EdgeInsets.only(
              top: i == 0 ? 20 : 0,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "0/07/2024",
                  style: AppTheme().stylish1(14, mblack),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: mgrey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Vous avez ajouté l'adresse ",
                                style: TextStyle(fontSize: 16, color: mblack),
                              ),
                              TextSpan(
                                text: "MAISON IDAH",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: mblack,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text:
                                    " avec succès ! Envoyez le code ci-dessous à votre correspondant afin qu'il puisse vous joindre à votre adresse",
                                style: TextStyle(fontSize: 16, color: mblack),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              const ClipboardData(
                                text: "0456664572",
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppTheme.primaryColor,
                                content: Text(
                                  "Code PIN copié dans le presse-papiers",
                                  style: AppTheme().stylish1(14, mwhite),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: context.width / 2,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: mwhite.withOpacity(.6),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "0456664572",
                                  style: AppTheme().stylish1(
                                    20,
                                    mblack,
                                    isBold: true,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color:
                                        AppTheme.primaryColor.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: HeroIcon(
                                      HeroIcons.share,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Text(
                          "Vous pouvez utiliser votre code PIN (si ajouté) pour plus de sécurité",
                          style: TextStyle(fontSize: 16, color: mblack),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
