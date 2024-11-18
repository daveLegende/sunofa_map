import 'package:flutter/material.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class EditAdresseScreen extends StatefulWidget {
  const EditAdresseScreen({super.key});

  @override
  State<EditAdresseScreen> createState() => _EditAdresseScreenState();
}

class _EditAdresseScreenState extends State<EditAdresseScreen> {
  final pseudo = TextEditingController(text: "Sadath01");
  final adresse = TextEditingController(text: "Maison IDAH");
  final ville = TextEditingController(text: "Togo, Lomé, E,treprise de l'union");
  final email = TextEditingController(text: "monmailgmail.com");
  final telephone = TextEditingController(text: "+228 98623547");
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
          "Modifier adresse",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: Container(
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
                ListTileCustom(
                  title: "Pseudo/Identifiant",
                  subtitle: "Sadath01",
                  controller: pseudo,
                ),
                const SizedBox(height: 20),
                ListTileCustom(
                  title: "Nom de l'adresse",
                  subtitle: "Maison IDAH",
                  controller: adresse,
                ),
                const SizedBox(height: 20),
                ListTileCustom(
                  title: "Pays, ville, quartier ou rue",
                  subtitle: "Togo, Lomé, E,treprise de l'union",
                  controller: ville,
                ),
                const SizedBox(height: 20),
                ListTileCustom(
                  title: "E-mail",
                  subtitle: "monmail@gmail.com",
                  controller: email,
                ),
                const SizedBox(height: 20),
                ListTileCustom(
                  title: "Téléphone",
                  subtitle: "+228 98623547",
                  controller: telephone,
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Info adresse",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: AppTheme.primaryColor.withOpacity(.1),
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
                  text: "Soumettre",
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

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({
    super.key,
    required this.title,
    required this.subtitle,
    required this.controller,
  });
  final TextEditingController controller;
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
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            style: AppTheme().stylish1(15, mgrey),
            keyboardType: TextInputType.number,
            cursorColor: AppTheme.primaryColor,
            decoration: InputDecoration(
              hintText: subtitle,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
