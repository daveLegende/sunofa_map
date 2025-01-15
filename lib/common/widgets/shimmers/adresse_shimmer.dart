import 'package:flutter/material.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class AdresseShimmer extends StatelessWidget {
  const AdresseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 0,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: context.width / 3,
            margin: EdgeInsets.only(
              bottom: 20,
              top: index == 0 ? 20 : 0,
            ),
            decoration: BoxDecoration(
              color: mgrey[100],
              // border: Border.all(color: AppTheme.primaryColor),
              borderRadius: BorderRadiusDirectional.circular(20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "adresse.adressName",
                          style: AppTheme().stylish1(20, mblack),
                        ),
                        Text(
                          "adresse.city dfjdf",
                          style: AppTheme().stylish1(16, mgrey),
                        ),
                        Text(
                          index == 2
                              ? "Ajouté depuis 02/07/2024"
                              : "Ajouté à l'instant",
                          // style: AppTheme().stylish1(16, mgrey),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
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
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
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
