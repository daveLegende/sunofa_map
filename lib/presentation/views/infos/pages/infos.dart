import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class InfoAdresseScreen extends StatelessWidget {
  const InfoAdresseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mgrey[100],
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Info adresse",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
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
              children: [
                SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: const Image(
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/villa4.jpg"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Maison IDAH",
                            style: AppTheme().stylish1(
                              18,
                              mblack,
                              isBold: true,
                            ),
                          ),
                          Text(
                            "Togo, Lomé, Casanblaca ca",
                            style: AppTheme().stylish1(12, mgrey),
                          ),
                          Text(
                            "Contact: +228 93026589",
                            style: AppTheme().stylish1(12, mgrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Images d'adresse",
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
                      "Vocaux de référence",
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
                      "Vidéos de référence",
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
                  text: "Itinéraire",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.itineraireScreen,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
