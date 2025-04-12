import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sunofa_map/blocs/favoris/create/create_fav_cubit.dart';
import 'package:sunofa_map/blocs/favoris/create/create_fav_state.dart';
import 'package:sunofa_map/blocs/favoris/favories_cubit.dart';
import 'package:sunofa_map/blocs/favoris/favories_state.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/api/api.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/common/widgets/shimmers/adresse_shimmer.dart';
import 'package:sunofa_map/common/widgets/text/notfound_text.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/data/models/favories/favories.dto.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addMap/pages/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_state.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/delete/delete_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/delete/delete_adresse_state.dart';
import 'package:sunofa_map/presentation/views/addresses/widgets/show_delete.dart';
import 'package:sunofa_map/presentation/views/books/pages/books.dart';
import 'package:sunofa_map/presentation/views/editAdresse/bloc/edit_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/editAdresse/pages/edit_adresse.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import 'package:http/http.dart' as http;

class AddresseScreen extends StatefulWidget {
  const AddresseScreen({
    super.key,
    this.user,
    this.onTabSelected,
  });
  final void Function(int)? onTabSelected;
  final UserEntity? user;

  @override
  State<AddresseScreen> createState() => _AddresseScreenState();
}

class _AddresseScreenState extends State<AddresseScreen> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, uState) {
            return Scaffold(
              backgroundColor: mwhite,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppTheme.primaryColor,
                title: Text(
                  "address.appbar".tr(),
                  style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              // floatingActionButton: uState is UserSuccessState
              //     ? Padding(
              //       padding: const EdgeInsets.only(bottom: 80),
              //       child: FloatingActionButton(
              //           clipBehavior: Clip.hardEdge,
              //           backgroundColor: AppTheme.primaryColor,
              //           onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => AddMapFormScreen(
                          //       user: uState.user,
                          //       onTabSelected: widget.onTabSelected,
                          //     ),
                          //   ),
                          // );
              //           },
              //           child: const HeroIcon(
              //             HeroIcons.plus,
              //             color: mwhite,
              //             size: 30,
              //             style: HeroIconStyle.micro,
              //           ),
              //         ),
              //     )
              //     : const Center(),
              floatingActionButton: uState is UserSuccessState
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: FloatingActionButton(
                        clipBehavior: Clip.hardEdge,
                        backgroundColor: AppTheme.primaryColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      AddMapFormScreen(
                                user: uState.user,
                                onTabSelected: widget.onTabSelected,
                              ),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.add,
                          color: mwhite,
                          size: 30,
                        ),
                      ),
                    )
                  : const Center(),
              body: SizedBox(
                width: context.width,
                height: context.height,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          TabBarItem(
                            text: "address.all".tr(),
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
                            text: "address.favoris".tr(),
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
                            final filteredAdresses = currentIndex == 2
                                ? state.adresses
                                    .where((adresse) => adresse.favory)
                                    .toList()
                                : state.adresses;

                            if (filteredAdresses.isEmpty) {
                              return NotFoundText(
                                text: currentIndex == 2
                                    ? "address.no_favoris".tr()
                                    : "address.ad_empty".tr(),
                              );
                            }

                            // Trier les adresses par date de création
                            filteredAdresses.sort((a, b) {
                              return b.createdAt!.dateTimeObject
                                  .compareTo(a.createdAt!.dateTimeObject);
                            });

                            return RefreshIndicator(
                              color: AppTheme.primaryColor,
                              backgroundColor: mwhite,
                              onRefresh: () async {
                                context.read<AdresseCubit>().getAdresses();
                              },
                              child: ListView.builder(
                                padding: const EdgeInsets.only(
                                  right: 15,
                                  left: 15,
                                  bottom: 150,
                                ),
                                itemCount: filteredAdresses.length,
                                itemBuilder: (context, index) {
                                  final adresse = filteredAdresses[index];
                                  return BlocListener<DeleteAdresseCubit,
                                      DeleteAdresseState>(
                                    listener: (context, stat) {
                                      if (stat is DeleteAdresseFailedState) {
                                        Helpers().toast(message: stat.message);
                                      } else if (stat
                                          is DeleteAdresseSuccessState) {
                                        // state.adresses.removeAt(index);
                                        context
                                            .read<AdresseCubit>()
                                            .getAdresses();
                                      }
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "***************${adresse.media!.photo1}");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return GestionAdresseScreen(
                                                user: uState is UserSuccessState
                                                    ? uState.user
                                                    : null,
                                                adresse: adresse,
                                                onTabSelected: widget.onTabSelected,
                                              );
                                            },
                                          ),
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
                                          border: Border.all(
                                              color: AppTheme.primaryColor),
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  20),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: double.infinity,
                                                width: double.infinity,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                  child:
                                                      adresse.media!.photo1 ==
                                                              null
                                                          ? Image.network(
                                                              APIURL.network,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Image.network(
                                                              "${APIURL.fileUrl}/${adresse.media!.photo1!}",
                                                              fit: BoxFit.cover,
                                                            ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      adresse.adressName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTheme()
                                                          .stylish1(20, mblack),
                                                    ),
                                                    Text(
                                                      adresse.city,
                                                      style: AppTheme()
                                                          .stylish1(16, mgrey),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      Helpers().timeAgo(
                                                        DateTime.parse(
                                                          adresse.createdAt!
                                                              .datetime,
                                                        ),
                                                      ),
                                                      style:
                                                          AppTheme().stylish1(
                                                        13,
                                                        mgrey,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ShareDeleteEditCircle(
                                                          size: 30,
                                                          color: !adresse.favory
                                                              ? mwhite
                                                              : AppTheme
                                                                  .redHover,
                                                          iconColor:
                                                              !adresse.favory
                                                                  ? mblack
                                                                  : mred,
                                                          icon: HeroIcons.heart,
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    EditAdresseCubit>()
                                                                .editAdresse(
                                                                  AdresseDTO(
                                                                    id: adresse
                                                                        .id,
                                                                    pseudo: adresse
                                                                        .pseudo,
                                                                    adressName:
                                                                        adresse
                                                                            .adressName,
                                                                    city: adresse
                                                                        .city,
                                                                    info: adresse
                                                                        .info,
                                                                    user_id:
                                                                        adresse
                                                                            .user
                                                                            .id!,
                                                                    latitude:
                                                                        adresse
                                                                            .latitude,
                                                                    longitude:
                                                                        adresse
                                                                            .longitude,
                                                                    googleAddress:
                                                                        adresse
                                                                            .googleAddress,
                                                                    favory: adresse
                                                                            .favory
                                                                        ? false
                                                                        : true,
                                                                    media: adresse
                                                                        .media!,
                                                                  ),
                                                                )
                                                                .then((_) {
                                                              context
                                                                  .read<
                                                                      AdresseCubit>()
                                                                  .getAdresses();
                                                              Helpers().toast(
                                                                color: mblack,
                                                                message: !adresse
                                                                        .favory
                                                                    ? "Adresse ajoutée aux favoris"
                                                                    : "Adresse supprimée des favoris",
                                                              );
                                                            });
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        ShareDeleteEditCircle(
                                                          size: 30,
                                                          color: mwhite,
                                                          icon:
                                                              HeroIcons.pencil,
                                                          iconColor: mblack,
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (_) {
                                                                  return EditAdresseScreen(
                                                                    isAdresseHome: true,
                                                                    adresse:
                                                                        adresse,
                                                                    onTabSelected: widget.onTabSelected,
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        ShareDeleteEditCircle(
                                                          size: 30,
                                                          color: mwhite,
                                                          icon:
                                                              HeroIcons.mapPin,
                                                          iconColor: AppTheme
                                                              .primaryColor,
                                                          onTap: () {
                                                            // Navigator.push(
                                                            //   context,
                                                            //   MaterialPageRoute(
                                                            //     builder: (_) {
                                                            //       return ItineraireScreen(
                                                            //         adresse:
                                                            //             adresse,
                                                            //       );
                                                            //     },
                                                            //   ),
                                                            // );
                                                            Helpers()
                                                                .openGoogleMaps(
                                                              adresse: adresse,
                                                            );
                                                          },
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        ShareDeleteEditCircle(
                                                          size: 30,
                                                          color: mwhite,
                                                          iconColor: mblack,
                                                          icon: HeroIcons.trash,
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              context: context,
                                                              builder: (_) {
                                                                return DeleteAdresseWidget(
                                                                  delOrLogoutText:
                                                                      "address.delete"
                                                                          .tr(),
                                                                  text:
                                                                      "address.modal_text"
                                                                          .tr(),
                                                                  size: MediaQuery.of(
                                                                          context)
                                                                      .size,
                                                                  onDel:
                                                                      () async {
                                                                    Navigator.pop(
                                                                        context);
                                                                    // Afficher un indicateur de progression
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      builder:
                                                                          (context) =>
                                                                              const LoadingCircle(),
                                                                    );

                                                                    try {
                                                                      // Exécuter la suppression
                                                                      await context
                                                                          .read<
                                                                              DeleteAdresseCubit>()
                                                                          .deleteAdresse(
                                                                            IdParms(
                                                                              id: adresse.id!,
                                                                            ),
                                                                          );
                                                                    } finally {
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  onCancel: () {
                                                                    Navigator
                                                                        .pop(_);
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
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
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const AdresseShimmer();
                          }
                        },
                      ),
                    ),

                    // Expanded(
                    //   child: BlocBuilder<AdresseCubit, AdresseState>(
                    //     builder: (context, state) {
                    //       if (state is AdresseSuccessState) {
                    //         if (state.adresses.isEmpty) {
                    //           return NotFoundText(
                    //             text: "address.ad_empty".tr(),
                    //           );
                    //         }

                    //         // Trier les adresses par date de création
                    //         state.adresses.sort((a, b) {
                    //           return b.createdAt.dateTimeObject
                    //               .compareTo(a.createdAt.dateTimeObject);
                    //         });

                    //         return BlocBuilder<FavoriesCubit, FavoriesState>(
                    //           builder: (context, fstate) {
                    //             if (fstate is FavoriesSuccessState) {
                    //               // Filtrer les adresses si currentIndex == 2
                    //               final List<AdressesEntity>
                    //                   adressesToDisplay = currentIndex == 2
                    //                       ? state.adresses.where((adresse) {
                    //                           return fstate.favoris
                    //                               .any((favori) {
                    //                             favori.adresseId ==
                    //                                 adresse.id;
                    //                             favori.userId ==
                    //                                 adresse.user.id;
                    //                             return true;
                    //                           });
                    //                         }).toList()
                    //                       : state.adresses;

                    //               return RefreshIndicator(
                    //                 onRefresh: () async {
                    //                   context
                    //                       .read<AdresseCubit>()
                    //                       .getAdresses();
                    //                   context
                    //                       .read<FavoriesCubit>()
                    //                       .getFavories();
                    //                 },
                    //                 child: ListView.builder(
                    //                   padding: const EdgeInsets.only(
                    //                     right: 15,
                    //                     left: 15,
                    //                     bottom: 80,
                    //                   ),
                    //                   itemCount: adressesToDisplay.length,
                    //                   itemBuilder: (context, index) {
                    //                     final adresse =
                    //                         adressesToDisplay[index];
                    //                     return BlocListener<
                    //                         DeleteAdresseCubit,
                    //                         DeleteAdresseState>(
                    //                       listener: (context, stat) {
                    //                         if (stat
                    //                             is DeleteAdresseFailedState) {
                    //                           Helpers().toast(
                    //                               message: stat.message);
                    //                         } else if (stat
                    //                             is DeleteAdresseSuccessState) {
                    //                           context
                    //                               .read<AdresseCubit>()
                    //                               .getAdresses();
                    //                         }
                    //                       },
                    //                       child: GestureDetector(
                    //                         onTap: () {
                    //                           print(
                    //                               "***************${adresse.media!.photo1}");
                    //                           Navigator.push(
                    //                             context,
                    //                             MaterialPageRoute(
                    //                               builder: (_) {
                    //                                 return GestionAdresseScreen(
                    //                                   user: uState
                    //                                           is UserSuccessState
                    //                                       ? uState.user
                    //                                       : null,
                    //                                   adresse: adresse,
                    //                                 );
                    //                               },
                    //                             ),
                    //                           );
                    //                         },
                    //                         child: Container(
                    //                           height: context.width / 3,
                    //                           margin: EdgeInsets.only(
                    //                             bottom: 20,
                    //                             top: index == 0 ? 20 : 0,
                    //                           ),
                    //                           decoration: BoxDecoration(
                    //                             color: mgrey[100],
                    //                             border: Border.all(
                    //                                 color: AppTheme
                    //                                     .primaryColor),
                    //                             borderRadius:
                    //                                 BorderRadiusDirectional
                    //                                     .circular(20),
                    //                           ),
                    //                           child: Row(
                    //                             children: [
                    //                               Expanded(
                    //                                 flex: 1,
                    //                                 child: SizedBox(
                    //                                   height: double.infinity,
                    //                                   width: double.infinity,
                    //                                   child: ClipRRect(
                    //                                     borderRadius:
                    //                                         BorderRadius
                    //                                             .circular(20),
                    //                                     child: adresse.media!
                    //                                                 .photo1 ==
                    //                                             null
                    //                                         ? Image.network(
                    //                                             APIURL
                    //                                                 .network,
                    //                                             fit: BoxFit
                    //                                                 .cover,
                    //                                           )
                    //                                         : Image.network(
                    //                                             "${APIURL.fileUrl}/${adresse.media!.photo1!}",
                    //                                             fit: BoxFit
                    //                                                 .cover,
                    //                                           ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                               Expanded(
                    //                                 flex: 2,
                    //                                 child: Padding(
                    //                                   padding:
                    //                                       const EdgeInsets
                    //                                           .symmetric(
                    //                                           horizontal: 5),
                    //                                   child: Column(
                    //                                     mainAxisAlignment:
                    //                                         MainAxisAlignment
                    //                                             .spaceEvenly,
                    //                                     crossAxisAlignment:
                    //                                         CrossAxisAlignment
                    //                                             .start,
                    //                                     children: [
                    //                                       Text(
                    //                                         adresse
                    //                                             .adressName,
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                         style: AppTheme()
                    //                                             .stylish1(20,
                    //                                                 mblack),
                    //                                       ),
                    //                                       Text(
                    //                                         adresse.city,
                    //                                         style: AppTheme()
                    //                                             .stylish1(16,
                    //                                                 mgrey),
                    //                                         overflow:
                    //                                             TextOverflow
                    //                                                 .ellipsis,
                    //                                       ),
                    //                                       Text(
                    //                                         Helpers().timeAgo(
                    //                                             DateTime.parse(adresse
                    //                                                 .createdAt
                    //                                                 .datetime)),
                    //                                         style: AppTheme()
                    //                                             .stylish1(13,
                    //                                                 mgrey),
                    //                                       ),
                    //                                       Row(
                    //                                         mainAxisAlignment:
                    //                                             MainAxisAlignment
                    //                                                 .start,
                    //                                         children: [
                    //                                           ShareDeleteEditCircle(
                    //                                             size: 30,
                    //                                             color: mwhite,
                    //                                             iconColor: !adresse
                    //                                                     .favory
                    //                                                 ? AppTheme
                    //                                                     .complementaryColor
                    //                                                 : mblack,
                    //                                             icon: HeroIcons
                    //                                                 .heart,
                    //                                             onTap: () {
                    //                                               context
                    //                                                   .read<
                    //                                                       EditAdresseCubit>()
                    //                                                   .editAdresse(
                    //                                                     AdresseDTO(
                    //                                                       id: adresse.id,
                    //                                                       pseudo: adresse.pseudo,
                    //                                                       adressName:
                    //                                                           adresse.adressName,
                    //                                                       city:
                    //                                                           adresse.city,
                    //                                                       info:
                    //                                                           adresse.info,
                    //                                                       user_id:
                    //                                                           adresse.user.id!,
                    //                                                       latitude:
                    //                                                           adresse.latitude,
                    //                                                       longitude:
                    //                                                           adresse.longitude,
                    //                                                       codePin: adresse.codePin,
                    //                                                       googleAddress: adresse.googleAddress,
                    //                                                       favory: true,
                    //                                                       media: adresse.media!,
                    //                                                     ),
                    //                                                   );
                    //                                             },
                    //                                           ),
                    //                                           const SizedBox(
                    //                                               width: 10),
                    //                                           ShareDeleteEditCircle(
                    //                                             size: 30,
                    //                                             color: mwhite,
                    //                                             icon: HeroIcons
                    //                                                 .pencil,
                    //                                             iconColor:
                    //                                                 mblack,
                    //                                             onTap: () {
                    //                                               Navigator
                    //                                                   .push(
                    //                                                 context,
                    //                                                 MaterialPageRoute(
                    //                                                   builder:
                    //                                                       (_) {
                    //                                                     return EditAdresseScreen(
                    //                                                       adresse:
                    //                                                           adresse,
                    //                                                     );
                    //                                                   },
                    //                                                 ),
                    //                                               );
                    //                                             },
                    //                                           ),
                    //                                           const SizedBox(
                    //                                               width: 10),
                    //                                           ShareDeleteEditCircle(
                    //                                             size: 30,
                    //                                             color: mwhite,
                    //                                             icon: HeroIcons
                    //                                                 .mapPin,
                    //                                             iconColor:
                    //                                                 AppTheme
                    //                                                     .primaryColor,
                    //                                             onTap: () {
                    //                                               Helpers().openGoogleMaps(
                    //                                                   adresse:
                    //                                                       adresse);
                    //                                             },
                    //                                           ),
                    //                                           const SizedBox(
                    //                                               width: 10),
                    //                                           ShareDeleteEditCircle(
                    //                                             size: 30,
                    //                                             color: mwhite,
                    //                                             iconColor:
                    //                                                 mblack,
                    //                                             icon: HeroIcons
                    //                                                 .trash,
                    //                                             onTap: () {
                    //                                               showModalBottomSheet(
                    //                                                 backgroundColor:
                    //                                                     Colors
                    //                                                         .transparent,
                    //                                                 context:
                    //                                                     context,
                    //                                                 builder:
                    //                                                     (_) {
                    //                                                   return DeleteAdresseWidget(
                    //                                                     delOrLogoutText:
                    //                                                         "address.delete".tr(),
                    //                                                     text:
                    //                                                         "address.modal_text".tr(),
                    //                                                     size:
                    //                                                         MediaQuery.of(context).size,
                    //                                                     onDel:
                    //                                                         () async {
                    //                                                       Navigator.pop(context);
                    //                                                       showDialog(
                    //                                                         context: context,
                    //                                                         barrierDismissible: false,
                    //                                                         builder: (context) => const LoadingCircle(),
                    //                                                       );
                    //                                                       try {
                    //                                                         await context.read<DeleteAdresseCubit>().deleteAdresse(
                    //                                                               IdParms(id: adresse.id!),
                    //                                                             );
                    //                                                       } finally {
                    //                                                         Navigator.pop(context);
                    //                                                       }
                    //                                                     },
                    //                                                     onCancel:
                    //                                                         () {
                    //                                                       Navigator.pop(_);
                    //                                                     },
                    //                                                   );
                    //                                                 },
                    //                                               );
                    //                                             },
                    //                                           ),
                    //                                         ],
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ],
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     );
                    //                   },
                    //                 ),
                    //               );
                    //             }
                    //             return const SizedBox();
                    //           },
                    //         );
                    //       } else {
                    //         return const AdresseShimmer();
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String> _fetchImageUrl() async {
    try {
      final token = await PreferenceServices().getToken();
      final response = await http.get(
        Uri.parse(APIURL.fileUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print("${response.body}");
        // Si la réponse est correcte, retourne l'URL de l'image
        return APIURL.fileUrl;
      } else if (response.statusCode == 404) {
        // Si l'image n'est pas trouvée
        // print("${response.body}");
        throw Exception("Image non trouvée (404)");
      } else if (response.statusCode == 403) {
        // Si l'accès est interdit
        throw Exception("Accès interdit (403)");
      } else {
        // Autres erreurs
        throw Exception("Erreur ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      // En cas d'erreur
      throw Exception(
          "Une erreur s'est produite lors de la récupération de l'image: $e");
    }
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
        color: mwhite,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
