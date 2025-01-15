import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class EditAdresseScreen extends StatefulWidget {
  const EditAdresseScreen({
    super.key,
    this.adresse,
  });
  final AdressesEntity? adresse;

  @override
  State<EditAdresseScreen> createState() => _EditAdresseScreenState();
}

class _EditAdresseScreenState extends State<EditAdresseScreen> {
  late TextEditingController pseudo;
  late TextEditingController adressName;
  late TextEditingController ville;
  late TextEditingController email;
  late TextEditingController telephone;
  late TextEditingController info;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données existantes
    pseudo = TextEditingController(text: widget.adresse!.pseudo);
    adressName = TextEditingController(text: widget.adresse!.adressName);
    ville = TextEditingController(text: widget.adresse!.city);
    email = TextEditingController(text: widget.adresse!.user.email);
    telephone = TextEditingController(text: widget.adresse!.user.phoneNumber);
    info = TextEditingController(text: widget.adresse!.info);
  }

  @override
  void dispose() {
    // Nettoyer les contrôleurs pour éviter les fuites de mémoire
    pseudo.dispose();
    adressName.dispose();
    ville.dispose();
    email.dispose();
    telephone.dispose();
    info.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adresse = widget.adresse!;
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
            child: BlocListener<EditAdresseCubit, EditAdresseState>(
              listener: (context, state) {
                if (state is EditAdresseSuccessState) {
                  Helpers().mySnackbar(
                    context: context,
                    message: state.message,
                  );
                  context.read<AdresseCubit>().getAdresses();
                } else if (state is EditAdresseFailedState) {
                  Helpers().mySnackbar(
                    context: context,
                    color: mred,
                    message: state.message,
                  );
                }
              },
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
                    controller: adressName,
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
                        padding: const EdgeInsets.all(2),
                        color: AppTheme.primaryColor.withOpacity(.1),
                        child: TextField(
                          controller: info,
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          style: AppTheme().stylish1(
                            13,
                            mgrey[400]!,
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
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
                  isLoading
                      ? const LoadingCircle()
                      : SubmitButton(
                          text: "Enregistrer",
                          onTap: () {
                            print(
                                "---------------------------${adressName.text}");
                            print(
                                "---------------------------${adresse.user.id}");
                            setState(() {
                              isLoading = true;
                            });
                            context
                                .read<EditAdresseCubit>()
                                .editAdresse(
                                  AdresseDTO(
                                    id: adresse.id,
                                    pseudo: "pseudo",
                                    adressName: "MAISON IDAH",
                                    city: ville.text.trim(),
                                    info: info.text.trim(),
                                    user_id: adresse.user.id!,
                                  ),
                                )
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
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
