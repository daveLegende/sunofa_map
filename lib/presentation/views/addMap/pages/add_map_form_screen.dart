// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sunofa_map/blocs/langues/langue_choose_bloc.dart';
import 'package:sunofa_map/common/helpers/helper.dart';
import 'package:sunofa_map/common/widgets/index.dart';
import 'package:sunofa_map/core/utils/index.dart';
import 'package:sunofa_map/data/models/adresses/adresse.dto.dart';
import 'package:sunofa_map/domain/entities/medias/media_entity.dart';
import 'package:sunofa_map/domain/entities/user/user_entity.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_cubit.dart';
import 'package:sunofa_map/presentation/views/addMap/bloc/create_adresse_state.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/Image_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/first_form.dart';
import 'package:sunofa_map/presentation/views/addMap/widgets/third_form.dart';
import 'package:sunofa_map/presentation/views/addresses/bloc/adresse_cubit.dart';
import 'package:sunofa_map/themes/app_themes.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/level_register.dart';

class AddMapFormScreen extends StatefulWidget {
  const AddMapFormScreen({
    super.key,
    this.user,
    this.onTabSelected,
  });
  final void Function(int)? onTabSelected;
  final UserEntity? user;

  @override
  State<AddMapFormScreen> createState() => _AddMapFormScreenState();
}

class _AddMapFormScreenState extends State<AddMapFormScreen> {
  final pseudo = TextEditingController();
  final adressName = TextEditingController();
  final city = TextEditingController();
  final info = TextEditingController();
  final pin = TextEditingController();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController gaController = TextEditingController();
  int? selectedLocationOption;
  bool isLoading = false;
  bool isGoogleAddressSelected = false;
  bool isCurrentLocationSelected = false;
  int? protegerPin = 2;
  int current = 1;
  double? latitude, longitude;
  //
  StepByStep currentStep = StepByStep.STEP_1;
  OpenSection openSection = OpenSection.OPEN_0;
  //

  List<File> selectedImages = [];
  List<File> selectedVideos = [];
  List<File> selectedAudios = [];

  @override
  void initState() {
    super.initState();
    // getPositionActuel();
    // _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LangueChooseBloc, LangueChooseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: mwhite,
          appBar: AppBar(
            backgroundColor: mwhite,
            elevation: 0,
            scrolledUnderElevation: 0,
            leading: const BackArrow(),
            title: Text(
              "add_address.appbar".tr(),
              style:
                  AppTheme().stylish1(20, AppTheme.primaryColor, isBold: true),
            ),
          ),
          body: SizedBox(
            width: context.width,
            height: context.height,
            child: BlocListener<CreateAdresseCubit, CreateAdresseState>(
              listener: (context, state) {
                if (state is CreateAdresseSuccessState) {
                  Helpers().mySnackbar(
                    context: context,
                    message: state.message,
                  );
                  setState(() {
                    isLoading = false;
                  });
                  context.read<AdresseCubit>().getAdresses();
                  widget.onTabSelected!(1);
                  Navigator.pop(context);
                } else if (state is CreateAdresseFailedState) {
                  Helpers().mySnackbar(
                    context: context,
                    message: state.message,
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      top: 20,
                      right: 40,
                      left: 40,
                      bottom: 40,
                    ),
                    child: Row(
                      children: [
                        NumberStepContainer(
                          text: '1',
                          onTap: () {
                            setState(() {
                              currentStep = StepByStep.STEP_1;
                            });
                          },
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(width: 5),
                        TraitLineStep(
                          color: currentStep != StepByStep.STEP_1
                              ? AppTheme.primaryColor
                              : mgrey[300]!,
                        ),
                        const SizedBox(width: 5),
                        NumberStepContainer(
                          text: '2',
                          onTap: () {
                            if (openSection == OpenSection.OPEN_1 ||
                                openSection == OpenSection.OPEN_2) {
                              setState(() {
                                currentStep = StepByStep.STEP_2;
                              });
                            }
                          },
                          color: currentStep != StepByStep.STEP_1
                              ? AppTheme.primaryColor
                              : mgrey[300]!,
                        ),
                        const SizedBox(width: 5),
                        TraitLineStep(
                          color: currentStep != StepByStep.STEP_1 &&
                                  currentStep != StepByStep.STEP_2
                              ? AppTheme.primaryColor
                              : mgrey[300]!,
                        ),
                        const SizedBox(width: 5),
                        NumberStepContainer(
                          text: '3',
                          onTap: () {
                            if (openSection == OpenSection.OPEN_2) {
                              setState(() {
                                currentStep = StepByStep.STEP_3;
                              });
                            }
                          },
                          color: (currentStep != StepByStep.STEP_1 &&
                                  currentStep != StepByStep.STEP_2)
                              ? AppTheme.primaryColor
                              : mgrey[300]!,
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       StepItem(
                  //         icon: Icons.arrow_back_ios_new,
                  //         iColor: current == 1 ? mblack : mwhite,
                  //         cColor: current == 1
                  //             ? AppTheme.lightPrimary
                  //             : AppTheme.primaryColor,
                  //         onTap: () {
                  //           if (currentStep == StepByStep.STEP_3) {
                  //             setState(() {
                  //               currentStep = StepByStep.STEP_2;
                  //             });
                  //           } else if (currentStep == StepByStep.STEP_2) {
                  //             setState(() {
                  //               currentStep = StepByStep.STEP_1;
                  //             });
                  //           }
                  //         },
                  //       ),
                  //       const SizedBox(width: 20),
                  //       StepItem(
                  //         icon: Icons.arrow_forward_ios,
                  //         iColor: current == 3 ? mblack : mwhite,
                  //         cColor: current == 3
                  //             ? AppTheme.lightPrimary
                  //             : AppTheme.primaryColor,
                  //         onTap: () {
                  //           if (current == 1) {
                  //             setState(() {
                  //               current = 2;
                  //             });
                  //           } else if (current == 2) {
                  //             setState(() {
                  //               current = 3;
                  //             });
                  //           }
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: currentStep == StepByStep.STEP_1
                          ? FirstForm(
                              formKey: formKey1,
                              user: widget.user!,
                              pseudo: pseudo,
                              adressName: adressName,
                              city: city,
                              info: info,
                              gaController: gaController,
                              isGoogleAddressSelected: isGoogleAddressSelected,
                              isCurrentLocationSelected:
                                  isCurrentLocationSelected,
                              onGoogleAddressChanged: !isGoogleAddressSelected
                                  ? (value) {
                                      print(value);
                                      setState(() {
                                        isGoogleAddressSelected = value;
                                      });
                                    }
                                  : (value) async {
                                      setState(() {
                                        isGoogleAddressSelected = value;
                                      });
                                      try {
                                        Position position =
                                            await getPositionActuel();
                                        print(
                                            "-------------------position $position");

                                        setState(() {
                                          latitude = position.latitude;
                                          longitude = position.longitude;
                                        });
                                        print(
                                          "Longitude *************$longitude\n Latitude**************$latitude",
                                        );
                                      } catch (e) {
                                        Helpers().mySnackbar(
                                          context: context,
                                          message: e.toString(),
                                          color: Colors.red,
                                        );
                                      }
                                    },
                              onSuggestionClicked: (prediction) {
                                gaController.text = prediction.description!;
                                gaController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                    offset: prediction.description!.length,
                                  ),
                                );
                              },
                              onCurrentLocationChanged: (value) {
                                setState(() {
                                  isCurrentLocationSelected = value;
                                });
                                getPositionActuel();
                              },
                              onTap: () {
                                print(
                                    "--------------------------- $longitude\n---------------$latitude");
                                if (formKey1.currentState!.validate() &&
                                    (isGoogleAddressSelected ||
                                        isCurrentLocationSelected)) {
                                  setState(() {
                                    currentStep = StepByStep.STEP_2;
                                    openSection = OpenSection.OPEN_1;
                                  });
                                } else {
                                  Helpers().mySnackbar(
                                    context: context,
                                    message: "add_address.first_error".tr(),
                                    color: AppTheme.complementaryColor,
                                  );
                                }
                              },
                            )
                          : currentStep == StepByStep.STEP_2
                              ? ImageForm(
                                  selectedImages: selectedImages,
                                  selectedVideos: selectedVideos,
                                  selectedAudios: selectedAudios,
                                  onContinue: () {
                                    // if (selectedImages.length <) {

                                    // } else {

                                    // }
                                    setState(() {
                                      currentStep = StepByStep.STEP_3;
                                      openSection = OpenSection.OPEN_2;
                                    });
                                  },
                                )
                              : ThirdForm(
                                  formKey: formKey2,
                                  pin: pin,
                                  isLoading: isLoading,
                                  protegerPin: protegerPin!,
                                  onSelectionChanged: (value) {
                                    print(value);
                                    setState(() {
                                      protegerPin = value;
                                    });
                                  },
                                  onTap: () {
                                    // print(
                                    //     "------------------${selectedAudios.first.path}");
                                    // print(
                                    //     "------------------${selectedImages.first.path}");
                                    // print(
                                    //     "------------------${selectedVideos.first.path}");
                                    if (formKey2.currentState!.validate()) {
                                      if (protegerPin == 2 &&
                                          pin.text.trim().length < 4) {
                                        Helpers().toast(
                                          message:
                                              "Le code pin doit avoir minimun 4 chiffres",
                                          color: mred,
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        //   if (protegerPin == 2) {
                                        //     if (selectedLocationOption == 1) {
                                        // isCurrentLocationSelected
                                        //     ?
                                        context
                                            .read<CreateAdresseCubit>()
                                            .createAdresse(
                                              AdresseDTO(
                                                pseudo: pseudo.text.trim(),
                                                adressName:
                                                    adressName.text.trim(),
                                                city: city.text.trim(),
                                                info: Helpers().removeEmojis(
                                                  info.text.trim(),
                                                ),
                                                googleAddress: gaController.text
                                                        .trim()
                                                        .isEmpty
                                                    ? ""
                                                    : gaController.text.trim(),
                                                longitude: longitude,
                                                latitude: latitude,
                                                codePin: pin.text.trim().isEmpty
                                                    ? null
                                                    : pin.text.trim(),
                                                favory: false,
                                                user_id:
                                                    widget.user!.id!.toString(),
                                                media: MediaEntity(
                                                  photo1: selectedImages.isEmpty
                                                      ? ""
                                                      : selectedImages
                                                          .first.path,
                                                  photo2: selectedImages.isEmpty
                                                      ? ""
                                                      : selectedImages
                                                          .last.path,
                                                  video1: selectedVideos.isEmpty
                                                      ? ""
                                                      : selectedVideos
                                                          .first.path,
                                                  video2: selectedVideos.isEmpty
                                                      ? ""
                                                      : selectedVideos
                                                          .last.path,
                                                  audio1: selectedAudios.isEmpty
                                                      ? ""
                                                      : selectedAudios
                                                          .first.path,
                                                  audio2: "",
                                                ),
                                              ),
                                            );
                                      }
                                      setState(() {
                                        currentStep = StepByStep.STEP_3;
                                      });
                                    }
                                  },
                                ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Future<Position> getPositionActuel() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Vérifier si les services de localisation sont activés
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     throw Exception('Les services de localisation sont désactivés.');
  //   }

  //   // Vérifier les permissions
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       throw Exception('Les permissions de localisation ont été refusées');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     throw Exception(
  //       'Les permissions de localisation sont définitivement refusées.',
  //     );
  //   }

  //   // Obtenir la position actuelle
  //   return await Geolocator.getCurrentPosition();
  // }
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

    // setState(() {
    latitude = position.latitude;
    longitude = position.longitude;
    // });

    print(
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}\\n$longitude $latitude");

    return position;
  }

  // Future<void> _requestPermissions() async {
  //   if (Platform.isAndroid) {
  //     await Permission.camera.request();
  //     await Permission.photos.request();
  //     await Permission.videos.request();
  //     await Permission.storage.request();
  //   }
  // }
}

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.icon,
    required this.iColor,
    required this.cColor,
    this.onTap,
  });
  final IconData icon;
  final Color iColor, cColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: cColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Icon(
            icon,
            color: iColor,
            size: 15,
          ),
        ),
      ),
    );
  }
}

// ENUM
enum StepByStep {
  STEP_1,
  STEP_2,
  STEP_3,
}

enum OpenSection {
  OPEN_0,
  OPEN_1,
  OPEN_2,
}
