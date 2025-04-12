import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:heroicons/heroicons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/sources/notifications/notification.dart';
import 'package:sunofa_map/domain/entities/adresses/adresse.entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addMap/pages/add_map_form_screen.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/dashboard/bloc/all_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/dashboard/bloc/all_adresse_state.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_cubit.dart';
import 'package:sunofa_map/presentation/views/home/bloc/user/user_state.dart';
import 'package:sunofa_map/presentation/views/notification/pages/notification.dart';
import 'package:sunofa_map/presentation/views/params/pages/params.dart';
import 'package:sunofa_map/services/notification_services.dart';
import 'package:sunofa_map/themes/app_themes.dart';

import '../widgets/addresse_find.dart';
import '../widgets/search_field.dart';

// ignore: must_be_immutable
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    this.user,
    this.onTabSelected,
  });
  final void Function(int)? onTabSelected;
  final UserEntity? user;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final controller = TextEditingController(text: "Maison IDAH");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  bool isSearch = false;
  List<AdressesEntity> filteredAdresses = [];
  final FocusNode _focusNode = FocusNode();

  String selectedLanguage = 'French';
  void _onLanguageChanged(String newLanguage) {
    setState(() {
      selectedLanguage = newLanguage;
    });
  }

  @override
  void initState() {
    super.initState();
    // getPermissions();
    // getPositionActuel();
    // _requestPermissions();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // void _clearSearch() {
  //   searchController.clear();
  //   _focusNode.unfocus();
  // }

  void searchAddress(List<AdressesEntity> adresses, String query) {
    setState(
      () {
        if (query.isEmpty) {
          isSearch = false;
          filteredAdresses = [];
        } else {
          isSearch = true;
          filteredAdresses = adresses
              .where(
                (add) =>
                    add.adressName.toLowerCase().contains(
                          query.toLowerCase(),
                        ) ||
                    add.pseudo.toLowerCase().contains(query.toLowerCase()) ||
                    add.city.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return BlocConsumer<LangueChooseBloc, LangueChooseState>(
          listener: (context, state) {
            // Actions supplémentaires, si nécessaire
          },
          builder: (context, lstate) {
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(
                  'Sunofa Map',
                  style: AppTheme().stylish1(20, AppTheme.white, isBold: true),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: AppTheme.white),
                  onPressed: () {
                    // _scaffoldKey.currentState?.openDrawer();
                    context.read<AdresseCubit>().getAdresses();
                  },
                ),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      if (state is UserSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) {
                              return const NotificationScreen();
                            },
                          ),
                        );
                      } else {
                        // Helpers().toast(
                        //   color: mblack,
                        //   message: "dashboard.network_error".tr(),
                        // );
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.white,
                          width: 1,
                        ),
                      ),
                      child: const HeroIcon(
                        HeroIcons.bellAlert,
                        color: AppTheme.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.widthPercent(2),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (state is UserSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ParamScreen(user: state.user),
                          ),
                        );
                      } else {
                        // Helpers().toast(
                        //   color: mblack,
                        //   message: "dashboard.network_error".tr(),
                        // );
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.white,
                        ),
                      ),
                      child: const HeroIcon(
                        HeroIcons.cog,
                        color: AppTheme.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.widthPercent(3),
                  ),
                ],
                backgroundColor: AppTheme.primaryColor,
              ),
              // drawer: NavigationDrawer(
              //   selectedLanguage: selectedLanguage,
              //   onLanguageChanged: _onLanguageChanged,
              // ),
              body: BlocBuilder<AllAdresseCubit, AllAdresseState>(
                  builder: (context, adState) {
                return Stack(
                  children: [
                    SizedBox(
                      width: context.width,
                      height: context.height,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          'assets/maps.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                width: context.widthPercent(30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppTheme.primaryColor,
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    if (state is UserSuccessState) {
                                      // Naviguer vers une autre page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddMapFormScreen(
                                            user: state.user,
                                            onTabSelected: widget.onTabSelected,
                                          ),
                                        ),
                                      );
                                    } else {
                                      // Helpers().toast(
                                      //   color: mblack,
                                      //   message: "dashboard.network_error".tr(),
                                      // );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: AppTheme.white,
                                        ),
                                        Text(
                                          "dashboard.address".tr(),
                                          style: AppTheme().stylish1(
                                            15,
                                            AppTheme.white,
                                            isBold: true,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: context.widthPercent(2)),
                              Expanded(
                                child: SearchField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    if (adState is AllAdresseSuccessState) {
                                      searchAddress(adState.adresses, value);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                    adState is AllAdresseSuccessState
                        ? Positioned(
                            left: 20,
                            right: 20,
                            top: context.height * .1,
                            child: (searchController.text.isNotEmpty &&
                                        filteredAdresses.isEmpty) ||
                                    adState.adresses.isEmpty
                                ? Container(
                                    color: mtransparent,
                                    height: context.height * .7,
                                    child: Center(
                                      child: Text(
                                        "dashboard.ad_empty".tr(),
                                        style: AppTheme().stylish1(15, mblack),
                                      ),
                                    ),
                                  )
                                : filteredAdresses.isEmpty
                                    ? Container(
                                        color: mtransparent,
                                        height: context.height * .7,
                                        child: Center(
                                          child: Text(
                                            "dashboard.initial_text".tr(),
                                            style:
                                                AppTheme().stylish1(15, mblack),
                                          ),
                                        ),
                                      )
                                    : AddresseSearch(
                                        user: state is UserSuccessState
                                            ? state.user
                                            : null,
                                        adresses: filteredAdresses,
                                      ),
                          )
                        : Positioned(
                            left: 20,
                            right: 20,
                            top: context.height * .1,
                            child: Container(
                              color: mtransparent,
                              height: context.height * .7,
                              child: Center(
                                child: Text(
                                  "dashboard.chargement".tr(),
                                  style: AppTheme().stylish1(15, mblack),
                                ),
                              ),
                            ),
                          ),
                  ],
                );
              }),
            );
          },
        );
      },
    );
  }

  Future<Position> getPositionActuel() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Les services de localisation sont désactivés.');
    }

    // Vérifier les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Les permissions de localisation ont été refusées");
        throw Exception('Les permissions de localisation ont été refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Les permissions de localisation sont définitivement refusées.");
      throw Exception(
        'Les permissions de localisation sont définitivement refusées.',
      );
    }

    // Obtenir la position actuelle
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      // Vérifier et demander la permission de la caméra
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      // Vérifier et demander la permission des photos
      var photosStatus = await Permission.photos.status;
      if (!photosStatus.isGranted) {
        await Permission.photos.request();
      }

      // Vérifier et demander la permission des vidéos
      var videosStatus = await Permission.videos.status;
      if (!videosStatus.isGranted) {
        await Permission.videos.request();
      }

      // Vérifier et demander la permission du stockage
      var storageStatus = await Permission.storage.status;
      if (!storageStatus.isGranted) {
        await Permission.storage.request();
      }
      if (cameraStatus.isPermanentlyDenied) {
        await openAppSettings(); // Ouvrir les paramètres de l'application
      }
    }
  }
}