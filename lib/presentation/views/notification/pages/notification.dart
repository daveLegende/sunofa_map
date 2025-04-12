import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sunofa_map/blocs/notifications/sendPin/send_pin_cubit.dart';
import 'package:sunofa_map/blocs/notifications/sendPin/send_pin_state.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/arrow_back.dart';
import 'package:sunofa_map/common/widgets/buttons/submit_button.dart';
import 'package:sunofa_map/common/widgets/loading_circle.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/id.dto.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/notifications/notification.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/routes/app_routes.dart';
import 'package:sunofa_map/presentation/views/gestionAdresse/pages/gestion_adresse.dart';
import 'package:sunofa_map/presentation/views/infos/pages/infos.dart';
import 'package:sunofa_map/presentation/views/notification/widgets/confirm_modal_sheet.dart';
import 'package:sunofa_map/presentation/views/notification/widgets/nav_widget.dart';
import 'package:sunofa_map/services/preferences.dart';
import 'package:sunofa_map/themes/app_themes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = ScrollController();
  bool isSend = false;
  List<bool> isExpandedList = [];
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => isLoading = true);
    try {
      final loadedNotifications =
          await PreferenceServices().getSavedNotifications();
      setState(() {
        notifications = loadedNotifications;
        // Initialiser la liste avec des false (tous les items repliés au départ)
        isExpandedList = List.filled(notifications.length, false);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      Helpers().toast(message: "Erreur de chargement");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<Map<String, dynamic>>> groupeNotifs =
        Helpers().groupNotificationByDate(notifications);
    return Scaffold(
      backgroundColor: mwhite,
      appBar: AppBar(
        backgroundColor: mwhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackArrow(
          routeNamed: Routes.home2,
        ),
        title: Text(
          "Notifications",
          style: AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
        ),
      ),
      body: BlocListener<SendPinCubit, SendPinState>(
        listener: (context, state) {
          if (state is SendPinSuccessState) {
            Navigator.pop(context);
            Helpers().toast(message: "Code Pin envoyé avec succès");
            _loadNotifications();
          } else if (state is SendPinFailedState) {
            Helpers().toast(message: "Erreur d'envoie de code Pin");
          }
        },
        child: Container(
          width: context.width,
          height: context.height,
          padding: const EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppTheme.lightPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSend = false;
                              });
                            },
                            child: NavWidget(
                              color: isSend
                                  ? Colors.transparent
                                  : AppTheme.primaryColor,
                              tcolor: isSend ? AppTheme.primaryColor : mwhite,
                              text: "Retrieved",
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSend = true;
                              });
                            },
                            child: NavWidget(
                              color: isSend
                                  ? AppTheme.primaryColor
                                  : Colors.transparent,
                              tcolor: isSend ? mwhite : AppTheme.primaryColor,
                              text: "Send",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                groupeNotifs.isEmpty
                    ? SizedBox(
                        height: context.height * .6,
                        child: Center(
                          child: Text(
                            "Aucune notification disponible",
                            style: AppTheme().stylish1(15, mblack),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          _loadNotifications();
                        },
                        child: ListView.builder(
                            controller: controller,
                            // itemCount: 2,
                            itemCount: groupeNotifs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              List<Map<String, dynamic>> notifForDates =
                                  groupeNotifs[index];
                              return SizedBox(
                                height: context.width * 1.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 40,
                                      color: AppTheme.background,
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          Helpers().dateEcole(
                                            DateTime.parse(
                                              notifForDates.first["date"],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 0,
                                        ),
                                        shrinkWrap: true,
                                        controller: controller,
                                        itemCount: notifications.length,
                                        itemBuilder: (context, i) {
                                          final isExpanded = isExpandedList[i];
                                          final notification = notifications[i];
                                          final requestedBy = notification[
                                                      'requested_by']
                                                  as Map<String, dynamic>? ??
                                              {};
                                          final address = notification[
                                                      'address']
                                                  as Map<String, dynamic>? ??
                                              {};

                                          if (isSend) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              margin: const EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                color: mgrey[300],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    notification['title'] ??
                                                        'Sans titre',
                                                    style: AppTheme().stylish1(
                                                      16,
                                                      mblack,
                                                      isBold: true,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    notification['body'] ??
                                                        'Sans titre',
                                                    style: AppTheme().stylish1(
                                                      15,
                                                      mblack,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                        ClipboardData(
                                                          text: Helpers()
                                                              .extractPinCode(
                                                            notification[
                                                                'body'],
                                                          ),
                                                        ),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              AppTheme
                                                                  .primaryColor,
                                                          content: Text(
                                                            "Code PIN copié dans le presse-papiers",
                                                            style: AppTheme()
                                                                .stylish1(
                                                                    14, mwhite),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width:
                                                          context.width * .35,
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: mwhite
                                                            .withOpacity(.6),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            Helpers()
                                                                .extractPinCode(
                                                                    notification[
                                                                        'body']),
                                                            style: AppTheme()
                                                                .stylish1(
                                                              16,
                                                              mblack,
                                                              isBold: true,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Container(
                                                            width: 40,
                                                            height: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppTheme
                                                                  .primaryColor
                                                                  .withOpacity(
                                                                      .1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: const Center(
                                                              child: Icon(
                                                                Icons.copy,
                                                                color: AppTheme
                                                                    .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {}
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isExpandedList[i] = !isExpanded;
                                              });
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              height: isExpanded
                                                  ? context.width * .8
                                                  : context.width * 0.4,
                                              margin: EdgeInsets.only(
                                                top: i == 0 ? 20 : 0,
                                                bottom: 20,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: mgrey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Titre et corps (toujours visibles)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          notification[
                                                                  'title'] ??
                                                              'Sans titre',
                                                          style: AppTheme()
                                                              .stylish1(
                                                            16,
                                                            mblack,
                                                            isBold: true,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isExpandedList[
                                                                      i] =
                                                                  !isExpanded;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: mwhite,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Center(
                                                              child: Icon(
                                                                isExpanded
                                                                    ? Icons
                                                                        .keyboard_arrow_down
                                                                    : Icons
                                                                        .keyboard_arrow_up,
                                                                color:
                                                                    mgrey[500],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      notification['body'] ??
                                                          'Aucun contenu',
                                                      style:
                                                          AppTheme().stylish1(
                                                        16,
                                                        mblack,
                                                      ),
                                                    ),

                                                    // Contenu supplémentaire (apparaît lors de l'expansion)
                                                    AnimatedCrossFade(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      crossFadeState: isExpanded
                                                          ? CrossFadeState
                                                              .showSecond
                                                          : CrossFadeState
                                                              .showFirst,
                                                      firstChild: Container(),
                                                      secondChild: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // const SizedBox(height: 25),
                                                          Text(
                                                            "Demander par :",
                                                            style: AppTheme()
                                                                .stylish1(
                                                              16,
                                                              mblack,
                                                              isBold: true,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              if (requestedBy
                                                                  .isNotEmpty) ...[
                                                                const CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor:
                                                                      AppTheme
                                                                          .background,
                                                                  child: HeroIcon(
                                                                      HeroIcons
                                                                          .user),
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      requestedBy[
                                                                              'name'] ??
                                                                          'Inconnu',
                                                                    ),
                                                                    Text(
                                                                      requestedBy[
                                                                              'email'] ??
                                                                          'Non fourni',
                                                                    ),
                                                                    Text(
                                                                      requestedBy[
                                                                              'phone_number'] ??
                                                                          'Non fourni',
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    SubmitButton(
                                                                  color: AppTheme
                                                                      .complementaryColor,
                                                                  onTap: () {
                                                                    // Navigator.pop(context);
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                InfoAdresseScreen(
                                                                          adresse:
                                                                              AdressesEntity.fromJson(address),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  text:
                                                                      "Refuser",
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 20),
                                                              Expanded(
                                                                child:
                                                                    SubmitButton(
                                                                  onTap: () {
                                                                    showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      backgroundColor:
                                                                          mtransparent,
                                                                      builder:
                                                                          (context) {
                                                                        return ConfirmModalSheet(
                                                                          address:
                                                                              address,
                                                                          requestedBy:
                                                                              requestedBy,
                                                                          id: notification['unique_id']
                                                                              as String,
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  text:
                                                                      "Accepter",
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // GestureDetector(
                                                          //   onTap: () {
                                                          //     Clipboard.setData(
                                                          //       ClipboardData(
                                                          //         text: "0456664572",
                                                          //       ),
                                                          //     );
                                                          //     ScaffoldMessenger.of(context)
                                                          //         .showSnackBar(
                                                          //       SnackBar(
                                                          //         backgroundColor:
                                                          //             AppTheme.primaryColor,
                                                          //         content: Text(
                                                          //           "Code PIN copié dans le presse-papiers",
                                                          //           style: AppTheme()
                                                          //               .stylish1(14, mwhite),
                                                          //         ),
                                                          //       ),
                                                          //     );
                                                          //   },
                                                          //   child: Container(
                                                          //     width: context.width / 2,
                                                          //     padding: const EdgeInsets.all(10),
                                                          //     decoration: BoxDecoration(
                                                          //       color: mwhite.withOpacity(.6),
                                                          //       borderRadius:
                                                          //           BorderRadius.circular(5),
                                                          //     ),
                                                          //     child: Row(
                                                          //       children: [
                                                          //         Text(
                                                          //           "0456664572",
                                                          //           style: AppTheme().stylish1(
                                                          //               20, mblack,
                                                          //               isBold: true),
                                                          //         ),
                                                          //         const SizedBox(width: 10),
                                                          //         Container(
                                                          //           width: 40,
                                                          //           height: 30,
                                                          //           decoration: BoxDecoration(
                                                          //             color: AppTheme
                                                          //                 .primaryColor
                                                          //                 .withOpacity(.1),
                                                          //             borderRadius:
                                                          //                 BorderRadius.circular(
                                                          //                     5),
                                                          //           ),
                                                          //           child: const Center(
                                                          //             child: HeroIcon(
                                                          //               HeroIcons.share,
                                                          //               color: AppTheme
                                                          //                   .primaryColor,
                                                          //             ),
                                                          //           ),
                                                          //         ),
                                                          //       ],
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
