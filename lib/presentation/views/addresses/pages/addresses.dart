import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/common/widgets/text/notfound_text.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_state.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AddresseScreen extends StatefulWidget {
  const AddresseScreen({super.key});

  @override
  State<AddresseScreen> createState() => _AddresseScreenState();
}

class _AddresseScreenState extends State<AddresseScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.primaryColor,
        title: Text(
          "Mes Adresses",
          style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
        ),
      ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  TabBarItem(
                    text: "Toutes",
                    index: 1,
                    currentIndex: currentIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  TabBarItem(
                    text: "Favoris",
                    index: 2,
                    currentIndex: currentIndex,
                    onTap: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AdresseCubit, AdresseState>(
                builder: (context, state) {
                  if (state is AdresseSuccessState) {
                    if (state.adresses.isEmpty) {
                      return const NotFoundText(
                        text: "Aucune adresse disponible",
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 0,
                      ),
                      itemCount: state.adresses.length,
                      itemBuilder: (context, index) {
                        final adresse = state.adresses[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.gestionAdresseScreen,
                              arguments: adresse,
                            );
                          },
                          child: Container(
                            height: context.width / 3,
                            margin: EdgeInsets.only(
                              bottom: 20,
                              top: index == 0 ? 20 : 0,
                            ),
                            decoration: BoxDecoration(
                              color: mgrey[100],
                              border: Border.all(color: AppTheme.primaryColor),
                              borderRadius:
                                  BorderRadiusDirectional.circular(20),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        index == 0
                                            ? "assets/villa.jpg"
                                            : index == 1
                                                ? "assets/villa4.jpg"
                                                : "assets/villa5.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          adresse.adressName,
                                          style:
                                              AppTheme().stylish1(20, mblack),
                                        ),
                                        Text(
                                          adresse.city,
                                          style: AppTheme().stylish1(16, mgrey),
                                        ),
                                        Text(
                                          index == 2
                                              ? "Ajouté depuis 02/07/2024"
                                              : "Ajouté à l'instant",
                                          style: AppTheme().stylish1(16, mgrey),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ShareDeleteEditCircle(
                                              size: 30,
                                              color: mwhite,
                                              iconColor: !adresse.isFavorited
                                                  ? AppTheme.complementaryColor
                                                  : mblack,
                                              icon: HeroIcons.heart,
                                              onTap: () {},
                                            ),
                                            const SizedBox(width: 10),
                                            // ShareDeleteEditCircle(
                                            //   size: 30,
                                            //   color: mwhite,
                                            //   icon: HeroIcons.share,
                                            //   iconColor: mblack,
                                            //   onTap: () {},
                                            // ),
                                            // const SizedBox(width: 10),
                                            ShareDeleteEditCircle(
                                              size: 30,
                                              color: mwhite,
                                              iconColor: mblack,
                                              icon: HeroIcons.trash,
                                              onTap: () {},
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const LoadingCircle();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    super.key,
    required this.text,
    this.onTap,
    required this.index,
    required this.currentIndex,
  });
  final int index, currentIndex;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: index == currentIndex
              ? AppTheme.primaryColor
              : AppTheme.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTheme().stylish1(
              index == currentIndex ? 15 : 14,
              index == currentIndex ? mwhite : mgrey,
              isBold: index == currentIndex ? true : false,
            ),
          ),
        ),
      ),
    );
  }
}

class ShareDeleteEditCircle extends StatelessWidget {
  const ShareDeleteEditCircle({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
    this.onTap,
    required this.iconColor,
  });
  final HeroIcons icon;
  final Color color, iconColor;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: HeroIcon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
