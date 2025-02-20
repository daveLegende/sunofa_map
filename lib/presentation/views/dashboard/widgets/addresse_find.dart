import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/buttons/button_border_container.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddresseSearch extends StatelessWidget {
  const AddresseSearch({
    super.key,
    required this.adresses,
    this.user,
  });

  final UserEntity? user;

  final List<AdressesEntity> adresses;

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    int content = 1;
    return Container(
      color: mtransparent,
      height: context.height * .8,
      child: ListView.builder(
        itemCount: adresses.length,
        itemBuilder: (context, index) {
          final ad = adresses[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: GestureDetector(
              onTap: (ad.codePin == null || ad.codePin.toString().length < 4) ||
                      user!.id == ad.user.id
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return GestionAdresseScreen(
                              user: user,
                              adresse: ad,
                            );
                          },
                        ),
                      );
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return Center(
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return Container(
                                width: context.width * .8,
                                height: context.width * .6,
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
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                ad.adressName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme().stylish1(
                                  18,
                                  mblack,
                                  isBold: true,
                                ),
                              ),
                              Text(
                                ad.city,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme().stylish1(12, mgrey),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 10,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: mwhite,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
