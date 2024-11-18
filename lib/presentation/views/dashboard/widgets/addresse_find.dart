import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/buttons/button_border_container.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddresseSearch extends StatelessWidget {
  const AddresseSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    int content = 1;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return Center(
              child: StatefulBuilder(builder: (context, setState) {
                return Container(
                  width: context.width * .7,
                  height: context.width * .5,
                  padding: const EdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    color: mwhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: content == 1
                      ? FirstDialogContent(
                          onPin: () {
                            setState(() {
                              content = 2;
                            });
                          },
                          onTell: () {
                            setState(() {
                              content = 3;
                            });
                          },
                        )
                      : content == 2
                          ? SecondDialogContent(
                              controller: pinController,
                              onTap: () {
                                setState(() {
                                  content = 1;
                                });
                                Navigator.popAndPushNamed(
                                  context,
                                  Routes.infoAdresseScreen,
                                );
                              },
                            )
                          : ThirdDialogContent(
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  content = 1;
                                });
                              },
                            ),
                );
              }),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const ClipOval(
                  child: Image(
                    width: 60,
                    height: 60,
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
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(
                    "Afficher",
                    style: AppTheme().stylish1(
                      13,
                      mwhite,
                      isBold: true,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const HeroIcon(
                    HeroIcons.map,
                    color: mwhite,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstDialogContent extends StatelessWidget {
  const FirstDialogContent({
    super.key,
    this.onPin,
    this.onTell,
  });
  final VoidCallback? onPin, onTell;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Cette adresse est privée, saisissez le code PIN ou envoyez une demande d'accès",
          textAlign: TextAlign.center,
          style: AppTheme().stylish1(15, mblack),
        ),
        ButtonBorderContainer(
          width: context.width / 2,
          color: AppTheme.primaryColor,
          text: "Saisir le code PIN",
          onTap: onPin,
        ),
        ButtonBorderContainer(
          width: context.width / 2,
          color: AppTheme.complementaryColor,
          text: "Demander code PIN",
          onTap: onTell,
        ),
      ],
    );
  }
}

class SecondDialogContent extends StatelessWidget {
  const SecondDialogContent({
    super.key,
    this.onTap,
    required this.controller,
  });
  final TextEditingController controller;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Saisissez le code PIN de votre correspondant",
            textAlign: TextAlign.center,
            style: AppTheme().stylish1(15, mblack),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              cursorColor: AppTheme.primaryColor,
              decoration: const InputDecoration(
                hintText: "Code PIN",
                prefixIcon: Icon(Icons.pin),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
              ),
            ),
          ),
          ButtonBorderContainer(
            width: context.width / 3,
            color: AppTheme.primaryColor,
            text: "Valider",
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class ThirdDialogContent extends StatelessWidget {
  const ThirdDialogContent({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          "Demande de code PIN envoyée",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.check_circle_outline,
          size: 40,
          color: mColor8,
        ),
        Text(
          "Vous aurez le code PIN dans vos notifications lorsque votre correspondant aura approuvé votre demande",
          textAlign: TextAlign.center,
          style: AppTheme().stylish1(13, mgrey),
        ),
        ButtonBorderContainer(
          width: context.width / 3.5,
          color: AppTheme.primaryColor,
          text: "OK",
          onTap: onTap,
        ),
      ],
    );
  }
}
