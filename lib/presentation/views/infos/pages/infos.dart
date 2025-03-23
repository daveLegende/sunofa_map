import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/presentation/views/itineraire/pages/itineraire.dart';
import 'package:sunofa_map/themes/app_themes.dart';

// class InfoAdresseScreen extends StatelessWidget {
//   const InfoAdresseScreen({
//     super.key,
//     this.adresse,
//   });
//   final AdressesEntity? adresse;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: mgrey[100],
//       appBar: AppBar(
//         backgroundColor: mwhite,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//         leading: const BackArrow(
//           routeNamed: Routes.home2,
//         ),
//         title: Text(
//           "Info adresse",
//           style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
//         ),
//       ),
//       body: Container(
//         // height: context.height,
//         // width: context.width,
//         color: AppTheme.lightGray,
//         padding: const EdgeInsets.symmetric(
//           vertical: 20,
//           horizontal: 20,
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             vertical: 20,
//             horizontal: 10,
//           ),
//           decoration: BoxDecoration(
//             color: mwhite,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 80,
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(15),
//                         child: AdresseImage(
//                             image: adresse!.media!.photo1!,
//                           ),
//                       ),
//                       const SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             adresse!.adressName,
//                             style: AppTheme().stylish1(
//                               18,
//                               mblack,
//                               isBold: true,
//                             ),
//                           ),
//                           Text(
//                             adresse!.city,
//                             style: AppTheme().stylish1(12, mgrey),
//                           ),
//                           Text(
//                             "Contact: ${adresse!.user.phoneNumber}",
//                             style: AppTheme().stylish1(12, mgrey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   color: mgrey[100],
//                   child: Text(
//                     lorem,
//                     maxLines: 4,
//                     textAlign: TextAlign.justify,
//                     style: AppTheme().stylish1(
//                       13,
//                       mgrey[400]!,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Images d'adresse",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: AdresseImage(
//                             image: adresse!.media!.photo1!,
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: AdresseImage(
//                             image: adresse!.media!.photo2!,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Vocaux de référence",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: VocalAdresse(),
//                         ),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: VocalAdresse(),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 adresse!.media!.video1 == null && adresse!.media!.video2 == null ? const SizedBox() : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Vidéos de référence",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: AdresseVideo(
//                             video: adresse!.media!.video1 ?? "",
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: AdresseVideo(
//                             video: adresse!.media!.video2 ?? "",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 40),
//                 SubmitButton(
//                   text: "Itinéraire",
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return ItineraireScreen(
//                             adresse: adresse,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class InfoAdresseScreen extends StatelessWidget {
  const InfoAdresseScreen({
    super.key,
    this.adresse,
  });
  final AdressesEntity? adresse;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                style: AppTheme()
                    .stylish1(20, AppTheme.primaryColor, isBold: true),
              ),
            ),
            body: Container(
              color: AppTheme.lightGray,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: mwhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: adresse?.media?.photo1 != null
                                  ? AdresseImage(
                                      image: adresse!.media!.photo1!,
                                      size: size,
                                      isEdit: false,
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  adresse?.adressName ?? "Nom inconnu",
                                  style: AppTheme()
                                      .stylish1(18, mblack, isBold: true),
                                ),
                                Text(
                                  adresse?.city ?? "Ville inconnue",
                                  style: AppTheme().stylish1(12, mgrey),
                                ),
                                Text(
                                  "${"gestion_ad.phone".tr()}: ${adresse?.user.phoneNumber ?? "N/A"}",
                                  style: AppTheme().stylish1(12, mgrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "Pseudo/Identifiant",
                        subtitle: adresse!.pseudo,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "edit_ad.name_label".tr(),
                        subtitle: adresse!.adressName,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "edit_ad.city_label".tr(),
                        subtitle: adresse!.city,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "gestion_ad.email".tr(),
                        subtitle: adresse!.user.email,
                      ),
                      const SizedBox(height: 20),
                      ListTileCustom(
                        title: "gestion_ad.phone".tr(),
                        subtitle: adresse!.user.phoneNumber,
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "edit_ad.info_label".tr(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: mgrey[100],
                            child: Text(
                              adresse!.info,
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: mgrey[100],
                        child: Text(
                          adresse!.info,
                          maxLines: 4,
                          textAlign: TextAlign.justify,
                          style: AppTheme().stylish1(
                            13,
                            mgrey[400]!,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if ((adresse?.media?.photo1 != null ||
                          adresse?.media?.photo2 != null))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "edit_ad.images".tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                if (adresse?.media?.photo1 != null)
                                  Expanded(
                                    child: AdresseImage(
                                      image: adresse!.media!.photo1!,
                                      size: size,
                                      isEdit: false,
                                    ),
                                  ),
                                if (adresse?.media?.photo2 != null)
                                  const SizedBox(width: 10),
                                if (adresse?.media?.photo2 != null)
                                  Expanded(
                                    child: AdresseImage(
                                      image: adresse!.media!.photo2!,
                                      size: size,
                                      isEdit: false,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (adresse?.media?.audio1 != null ||
                          adresse?.media?.audio2 != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "edit_ad.audios".tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                if (adresse?.media?.audio1 != null)
                                  const Expanded(child: VocalAdresse()),
                                if (adresse?.media?.audio2 != null)
                                  const SizedBox(width: 10),
                                if (adresse?.media?.audio2 != null)
                                  const Expanded(child: VocalAdresse()),
                              ],
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      if (adresse?.media?.video1 != null ||
                          adresse?.media?.video2 != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "edit_ad.videos".tr(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              children: [
                                if (adresse?.media?.video1 != null)
                                  Expanded(
                                    child: AdresseVideo(
                                      video: adresse!.media!.video1!,
                                      size: size,
                                      isEdit: false,
                                    ),
                                  ),
                                if (adresse?.media?.video2 != null)
                                  const SizedBox(width: 10),
                                if (adresse?.media?.video2 != null)
                                  Expanded(
                                    child: AdresseVideo(
                                      video: adresse!.media!.video2!,
                                      size: size,
                                      isEdit: false,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      const SizedBox(height: 40),
                      SubmitButton(
                        text: "gestion_ad.map".tr(),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ItineraireScreen(adresse: adresse),
                          //   ),
                          // );
                          Helpers().openGoogleMaps(adresse: adresse!);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
