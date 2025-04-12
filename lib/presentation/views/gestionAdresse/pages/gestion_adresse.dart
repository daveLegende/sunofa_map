import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/adresse/vocal_adresse.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/editAdresse/pages/edit_adresse.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/presentation/views/viewImage/view_image.dart';
import 'package:sunofa_map/presentation/views/viewImage/view_video.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class GestionAdresseScreen extends StatefulWidget {
  const GestionAdresseScreen({
    super.key,
    this.adresse,
    this.user,
    this.onTabSelected,
  });
  final UserEntity? user;
  final AdressesEntity? adresse;
  final void Function(int)? onTabSelected;

  @override
  State<GestionAdresseScreen> createState() => _GestionAdresseScreenState();
}

class _GestionAdresseScreenState extends State<GestionAdresseScreen> {
  @override
  Widget build(BuildContext context) {
    // Récupération des arguments
    // final arguments = ModalRoute.of(context)?.settings.arguments;
    // debugPrint('Arguments reçus : $arguments');

    AdressesEntity address = widget.adresse!;
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
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
              "gestion_ad.appbar".tr(),
              style:
                  AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
            ),
          ),
          bottomSheet: GestionAdresseSheet(
            user: widget.user!,
            adresse: widget.adresse!,
            onTabSelected: widget.onTabSelected,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Container(
                  // height: context.height * .7,
                  width: context.width,
                  color: AppTheme.lightGray,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: mwhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTileCustom(
                          title: "Pseudo/Identifiant",
                          subtitle: address.pseudo,
                        ),
                        const SizedBox(height: 20),
                        ListTileCustom(
                          title: "edit_ad.name_label".tr(),
                          subtitle: address.adressName,
                        ),
                        const SizedBox(height: 20),
                        ListTileCustom(
                          title: "edit_ad.city_label".tr(),
                          subtitle: address.city,
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
                                address.info,
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
                        widget.adresse!.googleAddress == null ||
                                widget.adresse!.googleAddress!.isEmpty
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(height: 20),
                                  ListTileCustom(
                                    title: "edit_ad.ga".tr(),
                                    subtitle: widget.adresse!.googleAddress!,
                                  ),
                                ],
                              ),
                        widget.adresse!.codePin == null ||
                                widget.adresse!.codePin!.bitLength < 4
                            ? const SizedBox()
                            : Column(
                                children: [
                                  const SizedBox(height: 20),
                                  ListTileCustom(
                                    title: "edit_ad.pin_label".tr(),
                                    subtitle:
                                        widget.adresse!.codePin!.toString(),
                                  ),
                                ],
                              ),
                        // const SizedBox(height: 20),
                        // ListTileCustom(
                        //   title: "gestion_ad.phone".tr(),
                        //   subtitle: widget.adresse!.user.phoneNumber,
                        // ),
                        const SizedBox(height: 20),
                        widget.adresse!.media!.photo1 == null ||
                                widget.adresse!.media!.photo2 == null
                            ? const SizedBox()
                            : Column(
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
                                      Expanded(
                                        child: AdresseImage(
                                          image:
                                              "${APIURL.fileUrl}/${address.media!.photo1!}",
                                          size: size,
                                          isEdit: false,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: AdresseImage(
                                          image:
                                              "${APIURL.fileUrl}/${address.media!.photo2!}",
                                          size: size,
                                          isEdit: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: widget.adresse!.media!.photo1 == null ||
                                  widget.adresse!.media!.photo2 == null
                              ? 0
                              : 20,
                        ),
                        widget.adresse!.media!.audio1 == null &&
                                widget.adresse!.media!.audio2 == null
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "edit_ad.audios".tr(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  AdresseAudio(
                                    audio:
                                        "${APIURL.fileUrl}/${widget.adresse!.media!.audio1!}",
                                  )
                                ],
                              ),
                        SizedBox(
                            height: widget.adresse!.media!.photo1 == null ||
                                    widget.adresse!.media!.photo2 == null
                                ? 0
                                : 20),
                        widget.adresse!.media!.video1 == null ||
                                widget.adresse!.media!.video2 == null
                            ? const SizedBox()
                            : Column(
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
                                      Expanded(
                                        child: AdresseVideo(
                                          video: address.media!.video1!,
                                          size: size,
                                          isEdit: false,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: AdresseVideo(
                                          video: address.media!.video2!,
                                          size: size,
                                          isEdit: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GestionAdresseSheet extends StatelessWidget {
  const GestionAdresseSheet({
    super.key,
    required this.adresse,
    required this.user,
    this.onTabSelected,
  });
  final UserEntity user;
  final AdressesEntity adresse;
  final void Function(int)? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      color: mwhite,
      child: SizedBox(
        height: 60,
        child: adresse.user.id == user.id
            ? Row(
                children: [
                  Expanded(
                    child: SubmitButton(
                      text: "gestion_ad.update".tr(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return EditAdresseScreen(
                                adresse: adresse,
                                isAdresseHome: false,
                                onTabSelected: onTabSelected,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SubmitButton(
                      text: "gestion_ad.map".tr(),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) {
                        //       return ItineraireScreen(
                        //         adresse: adresse,
                        //       );
                        //     },
                        //   ),
                        // );
                        Helpers().openGoogleMaps(adresse: adresse);
                      },
                    ),
                  ),
                ],
              )
            : SubmitButton(
                text: "gestion_ad.map".tr(),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) {
                  //       return ItineraireScreen(
                  //         adresse: adresse,
                  //       );
                  //     },
                  //   ),
                  // );
                  Helpers().openGoogleMaps(adresse: adresse);
                },
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
