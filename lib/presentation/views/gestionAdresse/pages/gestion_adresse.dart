import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class GestionAdresseScreen extends StatelessWidget {
  const GestionAdresseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgrey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mwhite,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Gestion adresse",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Material(
        color: mwhite,
        child: Container(
          // height: context.height,
          // width: context.width,
          color: AppTheme.lightGray,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: mwhite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ListTileCustom(
                    title: "Pseudo/Identifiant",
                    subtitle: "Sadath01",
                  ),
                  const SizedBox(height: 20),
                  const ListTileCustom(
                    title: "Nom de l'adresse",
                    subtitle: "Maison IDAH",
                  ),
                  const SizedBox(height: 20),
                  const ListTileCustom(
                    title: "Pays, ville, quartier ou rue",
                    subtitle: "Togo, Lomé, E,treprise de l'union",
                  ),
                  const SizedBox(height: 20),
                  const ListTileCustom(
                    title: "E-mail",
                    subtitle: "monmail@gmail.com",
                  ),
                  const SizedBox(height: 20),
                  const ListTileCustom(
                    title: "Téléphone",
                    subtitle: "+228 98623547",
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const Text(
                        "Info adresse",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: mgrey[100],
                        child: Text(
                          lorem,
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          style: AppTheme().stylish1(
                            13,
                            mgrey[400]!,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Images",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AdresseImage(
                              image: "assets/villa.jpg",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: AdresseImage(
                              image: "assets/villa5.jpg",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Audios",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VocalAdresse(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: VocalAdresse(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Vidéos",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AdresseImage(
                              image: "assets/villa.jpg",
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: AdresseImage(
                              image: "assets/villa5.jpg",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  SubmitButton(
                    text: "Faire une modification",
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.editAdresseScreen,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subtitle,
          style: AppTheme().stylish1(15, mgrey),
        ),
      ],
    );
  }
}
